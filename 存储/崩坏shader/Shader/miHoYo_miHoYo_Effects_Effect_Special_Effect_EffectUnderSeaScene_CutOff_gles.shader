//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/EffectUnderSeaScene_CutOff" {
Properties {
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base(R) Mask(G) Trans (A)", 2D) = "white" { }
_BaseColor ("Base Color", Color) = (1,1,1,1)
_UpColor ("Up Color", Color) = (1,1,1,1)
_MaskColor ("Mask Color", Color) = (1,1,1,1)
_MaskScale ("Mask Scale", Float) = 1
_Magnitude ("Distortion Magnitude", Float) = 1
_Frequency ("Distortion Frequency", Float) = 1
_InvWaveLength ("Distortion Inverse Wave Length", Float) = 10
_Normal_Scale ("Normal Scale", Float) = 1
_Magnitude1 ("Distortion Magnitude normal", Float) = 1
_Frequency1 ("Distortion Frequency normal", Float) = 1
_USpeed ("Main Tex U Speed", Float) = 1
_VSpeed ("Main Tex V Speed", Float) = 1
_FlowMap ("FlowMap(RG)", 2D) = "white" { }
_Speed ("Speed", Range(0, 1)) = 0.4
_FlowIntensity ("FlowIntensity", Range(0, 1)) = 0.25
_FlowSignX ("FlowSignX", Range(-1, 1)) = 1
_FlowSignY ("FlowSignY", Range(-1, 1)) = -1
_EnvTex ("Environment Texture (RGB)", Cube) = "grey" { }
_Reflectivity ("Reflectivity", Range(0, 5)) = 1
_CamDistRatio ("Camera Distance Ratio", Range(0, 1)) = 0.1
_CamHeightOffset ("Camera Height", Float) = 5
_CamRotate ("Camera Rotate", Range(-3.14159, 3.14159)) = 0
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceVAnimClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceVAnimClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 65169
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  highp vec4 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_1 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_6;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_15.xyz;
  tmpvar_9 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_20)
      ) * (_FogIntensity * tmpvar_20))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
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
    highp float tmpvar_27;
    tmpvar_27 = (_FogEndDistance - _FogStartDistance);
    tmpvar_26 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_28;
    tmpvar_28 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_25) / max (0.1, tmpvar_27))
    , 0.0, 1.0))));
    fogColor_23.xyz = tmpvar_28;
    fogColor_23.w = tmpvar_26;
    tmpvar_17 = fogColor_23;
  };
  highp vec4 tmpvar_29;
  tmpvar_29 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_29.xz - ((tmpvar_29.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_30;
  tmpvar_30 = normalize((tmpvar_29.xyz - adjCamPos_5));
  tmpvar_12 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = cos(_CamRotate);
  cost_4 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = sin(_CamRotate);
  sint_3 = tmpvar_32;
  highp mat2 tmpvar_33;
  tmpvar_33[0].x = cost_4;
  tmpvar_33[0].y = -(sint_3);
  tmpvar_33[1].x = sint_3;
  tmpvar_33[1].y = cost_4;
  tmpvar_12.xz = (tmpvar_33 * tmpvar_12.xz);
  gl_Position = tmpvar_9;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_1.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase.xyz + (h_26 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_28 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  tmpvar_17 = tmpvar_20;
  highp vec4 tmpvar_54;
  tmpvar_54 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_54.xz - ((tmpvar_54.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_55;
  tmpvar_55 = normalize((tmpvar_54.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_55;
  mediump float tmpvar_56;
  tmpvar_56 = cos(_CamRotate);
  cost_4 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = sin(_CamRotate);
  sint_3 = tmpvar_57;
  highp mat2 tmpvar_58;
  tmpvar_58[0].x = cost_4;
  tmpvar_58[0].y = -(sint_3);
  tmpvar_58[1].x = sint_3;
  tmpvar_58[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_58 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  highp float sint_3;
  highp float cost_4;
  highp vec3 adjCamPos_5;
  mediump vec4 offsetVertex_6;
  mediump float normalOut_7;
  highp vec4 offset_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  mediump vec3 tmpvar_11;
  offset_8.yzw = vec3(0.0, 0.0, 0.0);
  offset_8.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_8.y = offset_8.x;
  highp float tmpvar_12;
  tmpvar_12 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_7 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = ((_glesVertex + (
    (offset_8 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_7) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_6 = tmpvar_13;
  highp vec4 pos_14;
  pos_14 = offsetVertex_6;
  highp vec4 tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = pos_14.xyz;
  tmpvar_15 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_10 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_18.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_20;
  mediump float fogFactor_21;
  mediump vec3 fogColor_22;
  mediump vec3 heightFogColor_23;
  highp float HeightFogFactor_24;
  mediump vec3 atomesphereFogColor_25;
  mediump float h_26;
  highp float linearFogDensity_27;
  mediump float len_28;
  highp float tmpvar_29;
  tmpvar_29 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_28 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (((len_28 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_27 = (tmpvar_30 * (2.0 - tmpvar_30));
  if ((len_28 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_27 = (linearFogDensity_27 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_31;
  tmpvar_31 = min (pow (linearFogDensity_27, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_27 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (((tmpvar_18.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  h_26 = (tmpvar_32 * (2.0 - tmpvar_32));
  highp vec3 tmpvar_34;
  tmpvar_34 = (_HeigtFogColBase2.xyz + (h_26 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_25 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = mix (atomesphereFogColor_25, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_28 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_25 = tmpvar_35;
  mediump float tmpvar_36;
  mediump float r_37;
  mediump float f_38;
  mediump float u_39;
  mediump float l_40;
  mediump float fogInt_41;
  fogInt_41 = 1.0;
  highp float tmpvar_42;
  tmpvar_42 = (_HeigtFogParams2.x * tmpvar_19.y);
  highp float tmpvar_43;
  tmpvar_43 = abs(tmpvar_42);
  if ((tmpvar_43 > 0.01)) {
    highp float tmpvar_44;
    tmpvar_44 = exp(-(tmpvar_42));
    fogInt_41 = ((1.0 - tmpvar_44) / tmpvar_42);
  };
  highp float tmpvar_45;
  tmpvar_45 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_40 = tmpvar_45;
  highp float tmpvar_46;
  tmpvar_46 = (l_40 * _HeigtFogParams2.y);
  u_39 = tmpvar_46;
  fogInt_41 = (fogInt_41 * u_39);
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (((l_40 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  r_37 = (tmpvar_47 * (2.0 - tmpvar_47));
  r_37 = ((r_37 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_38 = ((1.0 - clamp (
    exp2(-(fogInt_41))
  , 0.0, 1.0)) * r_37);
  highp float tmpvar_49;
  tmpvar_49 = min (f_38, _HeigtFogColBase2.w);
  tmpvar_36 = tmpvar_49;
  HeightFogFactor_24 = tmpvar_36;
  highp vec3 tmpvar_50;
  tmpvar_50 = _Mihoyo_FogColor2.xyz;
  heightFogColor_23 = tmpvar_50;
  highp vec3 tmpvar_51;
  tmpvar_51 = ((heightFogColor_23 * HeightFogFactor_24) + ((atomesphereFogColor_25 * tmpvar_31) * (1.0 - HeightFogFactor_24)));
  fogColor_22 = tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = ((1.0 - tmpvar_31) * (1.0 - HeightFogFactor_24));
  fogFactor_21 = tmpvar_52;
  mediump vec4 tmpvar_53;
  tmpvar_53.xyz = fogColor_22;
  tmpvar_53.w = fogFactor_21;
  tmpvar_20 = tmpvar_53;
  highp vec4 tmpvar_54;
  mediump float fogFactor_55;
  mediump vec3 fogColor_56;
  mediump vec3 heightFogColor_57;
  highp float HeightFogFactor_58;
  mediump vec3 atomesphereFogColor_59;
  mediump float h_60;
  highp float linearFogDensity_61;
  mediump float len_62;
  highp float tmpvar_63;
  tmpvar_63 = sqrt(dot (tmpvar_19, tmpvar_19));
  len_62 = tmpvar_63;
  highp float tmpvar_64;
  tmpvar_64 = clamp (((len_62 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_61 = (tmpvar_64 * (2.0 - tmpvar_64));
  if ((len_62 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_61 = (linearFogDensity_61 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_65;
  tmpvar_65 = min (pow (linearFogDensity_61, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_61 = tmpvar_65;
  mediump float tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (((tmpvar_18.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_66 = tmpvar_67;
  h_60 = (tmpvar_66 * (2.0 - tmpvar_66));
  highp vec3 tmpvar_68;
  tmpvar_68 = (_HeigtFogColBase3.xyz + (h_60 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_59 = tmpvar_68;
  highp vec3 tmpvar_69;
  tmpvar_69 = mix (atomesphereFogColor_59, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_62 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_59 = tmpvar_69;
  mediump float tmpvar_70;
  mediump float r_71;
  mediump float f_72;
  mediump float u_73;
  mediump float l_74;
  mediump float fogInt_75;
  fogInt_75 = 1.0;
  highp float tmpvar_76;
  tmpvar_76 = (_HeigtFogParams3.x * tmpvar_19.y);
  highp float tmpvar_77;
  tmpvar_77 = abs(tmpvar_76);
  if ((tmpvar_77 > 0.01)) {
    highp float tmpvar_78;
    tmpvar_78 = exp(-(tmpvar_76));
    fogInt_75 = ((1.0 - tmpvar_78) / tmpvar_76);
  };
  highp float tmpvar_79;
  tmpvar_79 = sqrt(dot (tmpvar_19, tmpvar_19));
  l_74 = tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = (l_74 * _HeigtFogParams3.y);
  u_73 = tmpvar_80;
  fogInt_75 = (fogInt_75 * u_73);
  mediump float tmpvar_81;
  highp float tmpvar_82;
  tmpvar_82 = clamp (((l_74 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_81 = tmpvar_82;
  r_71 = (tmpvar_81 * (2.0 - tmpvar_81));
  r_71 = ((r_71 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_72 = ((1.0 - clamp (
    exp2(-(fogInt_75))
  , 0.0, 1.0)) * r_71);
  highp float tmpvar_83;
  tmpvar_83 = min (f_72, _HeigtFogColBase3.w);
  tmpvar_70 = tmpvar_83;
  HeightFogFactor_58 = tmpvar_70;
  highp vec3 tmpvar_84;
  tmpvar_84 = _Mihoyo_FogColor3.xyz;
  heightFogColor_57 = tmpvar_84;
  highp vec3 tmpvar_85;
  tmpvar_85 = ((heightFogColor_57 * HeightFogFactor_58) + ((atomesphereFogColor_59 * tmpvar_65) * (1.0 - HeightFogFactor_58)));
  fogColor_56 = tmpvar_85;
  highp float tmpvar_86;
  tmpvar_86 = ((1.0 - tmpvar_65) * (1.0 - HeightFogFactor_58));
  fogFactor_55 = tmpvar_86;
  mediump vec4 tmpvar_87;
  tmpvar_87.xyz = fogColor_56;
  tmpvar_87.w = fogFactor_55;
  tmpvar_54 = tmpvar_87;
  highp vec4 tmpvar_88;
  tmpvar_88 = mix (tmpvar_20, tmpvar_54, vec4(_LerpFactor));
  tmpvar_17 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_5.xz = (tmpvar_89.xz - ((tmpvar_89.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_5.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_90;
  tmpvar_90 = normalize((tmpvar_89.xyz - adjCamPos_5));
  tmpvar_11 = tmpvar_90;
  mediump float tmpvar_91;
  tmpvar_91 = cos(_CamRotate);
  cost_4 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = sin(_CamRotate);
  sint_3 = tmpvar_92;
  highp mat2 tmpvar_93;
  tmpvar_93[0].x = cost_4;
  tmpvar_93[0].y = -(sint_3);
  tmpvar_93[1].x = sint_3;
  tmpvar_93[1].y = cost_4;
  tmpvar_11.xz = (tmpvar_93 * tmpvar_11.xz);
  gl_Position = tmpvar_15;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_17;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  finalColor_2.xyz = (xlv_COLOR1.xyz + (finalColor_2.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = _glesNormal;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  highp vec4 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec2 tmpvar_12;
  mediump vec3 tmpvar_13;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_14;
  tmpvar_14 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_2 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_15;
  highp vec4 pos_16;
  pos_16 = offsetVertex_7;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_16.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_11 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_12 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_21)
      ) * (_FogIntensity * tmpvar_21))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_21)) * (_FogColorIntensity * tmpvar_21))
    ), 0.0, 1.0)));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_18 = fogColor_19;
  } else {
    mediump vec4 fogColor_24;
    highp vec3 tmpvar_25;
    tmpvar_25 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_26;
    tmpvar_26 = max (0.0, (sqrt(
      dot (tmpvar_25, tmpvar_25)
    ) - _FogStartDistance));
    highp float tmpvar_27;
    highp float tmpvar_28;
    tmpvar_28 = (_FogEndDistance - _FogStartDistance);
    tmpvar_27 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_26) / max (0.1, tmpvar_28))
    , 0.0, 1.0))));
    fogColor_24.xyz = tmpvar_29;
    fogColor_24.w = tmpvar_27;
    tmpvar_18 = fogColor_24;
  };
  highp vec4 tmpvar_30;
  tmpvar_30 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_30.xz - ((tmpvar_30.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize((tmpvar_30.xyz - adjCamPos_6));
  tmpvar_13 = tmpvar_31;
  mediump float tmpvar_32;
  tmpvar_32 = cos(_CamRotate);
  cost_5 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = sin(_CamRotate);
  sint_4 = tmpvar_33;
  highp mat2 tmpvar_34;
  tmpvar_34[0].x = cost_5;
  tmpvar_34[0].y = -(sint_4);
  tmpvar_34[1].x = sint_4;
  tmpvar_34[1].y = cost_5;
  tmpvar_13.xz = (tmpvar_34 * tmpvar_13.xz);
  highp vec4 tmpvar_35;
  tmpvar_35.xyz = offsetVertex_7.xyz;
  tmpvar_35.w = tmpvar_1.w;
  mediump vec3 fogParam_36;
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_ObjectToWorld * tmpvar_35);
  highp vec2 tmpvar_38;
  tmpvar_38 = (tmpvar_37.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_39;
  tmpvar_39 = max (0.0, (sqrt(
    dot (tmpvar_38, tmpvar_38)
  ) - _UWFogDistStart));
  highp float tmpvar_40;
  tmpvar_40 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_39)
    ) * (_UWFogDensity * tmpvar_39))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_41;
  tmpvar_41 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_39))
   * 
    (_UWFogColorNFIntensity * tmpvar_39)
  )), 0.0, 1.0);
  fogParam_36.x = tmpvar_41;
  fogParam_36.y = tmpvar_40;
  fogParam_36.z = tmpvar_37.y;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = tmpvar_11;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_2.xyz;
  xlv_TEXCOORD3 = tmpvar_13;
  xlv_TEXCOORD4 = fogParam_36;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _HeigtFogParams;
uniform highp vec4 _HeigtFogRamp;
uniform highp vec4 _HeigtFogColBase;
uniform highp vec4 _HeigtFogColDelta;
uniform highp vec4 _HeigtFogColParams;
uniform highp vec4 _HeigtFogRadialCol;
uniform highp vec4 _Mihoyo_FogColor;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase.xyz + (h_27 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_29 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  tmpvar_18 = tmpvar_21;
  highp vec4 tmpvar_55;
  tmpvar_55 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_55.xz - ((tmpvar_55.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_56;
  tmpvar_56 = normalize((tmpvar_55.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_56;
  mediump float tmpvar_57;
  tmpvar_57 = cos(_CamRotate);
  cost_5 = tmpvar_57;
  mediump float tmpvar_58;
  tmpvar_58 = sin(_CamRotate);
  sint_4 = tmpvar_58;
  highp mat2 tmpvar_59;
  tmpvar_59[0].x = cost_5;
  tmpvar_59[0].y = -(sint_4);
  tmpvar_59[1].x = sint_4;
  tmpvar_59[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_59 * tmpvar_12.xz);
  highp vec4 tmpvar_60;
  tmpvar_60.xyz = offsetVertex_7.xyz;
  tmpvar_60.w = tmpvar_1.w;
  mediump vec3 fogParam_61;
  highp vec4 tmpvar_62;
  tmpvar_62 = (unity_ObjectToWorld * tmpvar_60);
  highp vec2 tmpvar_63;
  tmpvar_63 = (tmpvar_62.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_64;
  tmpvar_64 = max (0.0, (sqrt(
    dot (tmpvar_63, tmpvar_63)
  ) - _UWFogDistStart));
  highp float tmpvar_65;
  tmpvar_65 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_64)
    ) * (_UWFogDensity * tmpvar_64))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_66;
  tmpvar_66 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_64))
   * 
    (_UWFogColorNFIntensity * tmpvar_64)
  )), 0.0, 1.0);
  fogParam_61.x = tmpvar_66;
  fogParam_61.y = tmpvar_65;
  fogParam_61.z = tmpvar_62.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_61;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
uniform highp float _Magnitude;
uniform highp float _Frequency;
uniform highp float _InvWaveLength;
uniform highp float _Magnitude1;
uniform highp float _Frequency1;
uniform mediump float _Normal_Scale;
uniform mediump float _CamDistRatio;
uniform mediump float _CamHeightOffset;
uniform mediump float _CamRotate;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = _glesNormal;
  highp float sint_4;
  highp float cost_5;
  highp vec3 adjCamPos_6;
  mediump vec4 offsetVertex_7;
  mediump float normalOut_8;
  highp vec4 offset_9;
  mediump vec2 tmpvar_10;
  mediump vec2 tmpvar_11;
  mediump vec3 tmpvar_12;
  offset_9.yzw = vec3(0.0, 0.0, 0.0);
  offset_9.x = (sin((
    (((_Frequency * _Time.y) + (_glesVertex.x * _InvWaveLength)) + (_glesVertex.y * _InvWaveLength))
   + 
    (_glesVertex.z * _InvWaveLength)
  )) * _Magnitude);
  offset_9.y = offset_9.x;
  highp float tmpvar_13;
  tmpvar_13 = abs((sin(
    (_Frequency1 * _Time.y)
  ) * _Magnitude1));
  normalOut_8 = tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = ((_glesVertex + (
    (offset_9 * _glesColor.x)
   * 
    (1.0 - _glesColor.y)
  )) + ((tmpvar_3 * normalOut_8) * (_Normal_Scale * _glesColor.y)));
  offsetVertex_7 = tmpvar_14;
  highp vec4 pos_15;
  pos_15 = offsetVertex_7;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = pos_15.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_10 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_11 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_21;
  mediump float fogFactor_22;
  mediump vec3 fogColor_23;
  mediump vec3 heightFogColor_24;
  highp float HeightFogFactor_25;
  mediump vec3 atomesphereFogColor_26;
  mediump float h_27;
  highp float linearFogDensity_28;
  mediump float len_29;
  highp float tmpvar_30;
  tmpvar_30 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (((len_29 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_28 = (tmpvar_31 * (2.0 - tmpvar_31));
  if ((len_29 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_28 = (linearFogDensity_28 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_32;
  tmpvar_32 = min (pow (linearFogDensity_28, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_28 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (((tmpvar_19.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  h_27 = (tmpvar_33 * (2.0 - tmpvar_33));
  highp vec3 tmpvar_35;
  tmpvar_35 = (_HeigtFogColBase2.xyz + (h_27 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_26 = tmpvar_35;
  highp vec3 tmpvar_36;
  tmpvar_36 = mix (atomesphereFogColor_26, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_29 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_26 = tmpvar_36;
  mediump float tmpvar_37;
  mediump float r_38;
  mediump float f_39;
  mediump float u_40;
  mediump float l_41;
  mediump float fogInt_42;
  fogInt_42 = 1.0;
  highp float tmpvar_43;
  tmpvar_43 = (_HeigtFogParams2.x * tmpvar_20.y);
  highp float tmpvar_44;
  tmpvar_44 = abs(tmpvar_43);
  if ((tmpvar_44 > 0.01)) {
    highp float tmpvar_45;
    tmpvar_45 = exp(-(tmpvar_43));
    fogInt_42 = ((1.0 - tmpvar_45) / tmpvar_43);
  };
  highp float tmpvar_46;
  tmpvar_46 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_41 = tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = (l_41 * _HeigtFogParams2.y);
  u_40 = tmpvar_47;
  fogInt_42 = (fogInt_42 * u_40);
  mediump float tmpvar_48;
  highp float tmpvar_49;
  tmpvar_49 = clamp (((l_41 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_48 = tmpvar_49;
  r_38 = (tmpvar_48 * (2.0 - tmpvar_48));
  r_38 = ((r_38 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_39 = ((1.0 - clamp (
    exp2(-(fogInt_42))
  , 0.0, 1.0)) * r_38);
  highp float tmpvar_50;
  tmpvar_50 = min (f_39, _HeigtFogColBase2.w);
  tmpvar_37 = tmpvar_50;
  HeightFogFactor_25 = tmpvar_37;
  highp vec3 tmpvar_51;
  tmpvar_51 = _Mihoyo_FogColor2.xyz;
  heightFogColor_24 = tmpvar_51;
  highp vec3 tmpvar_52;
  tmpvar_52 = ((heightFogColor_24 * HeightFogFactor_25) + ((atomesphereFogColor_26 * tmpvar_32) * (1.0 - HeightFogFactor_25)));
  fogColor_23 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = ((1.0 - tmpvar_32) * (1.0 - HeightFogFactor_25));
  fogFactor_22 = tmpvar_53;
  mediump vec4 tmpvar_54;
  tmpvar_54.xyz = fogColor_23;
  tmpvar_54.w = fogFactor_22;
  tmpvar_21 = tmpvar_54;
  highp vec4 tmpvar_55;
  mediump float fogFactor_56;
  mediump vec3 fogColor_57;
  mediump vec3 heightFogColor_58;
  highp float HeightFogFactor_59;
  mediump vec3 atomesphereFogColor_60;
  mediump float h_61;
  highp float linearFogDensity_62;
  mediump float len_63;
  highp float tmpvar_64;
  tmpvar_64 = sqrt(dot (tmpvar_20, tmpvar_20));
  len_63 = tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (((len_63 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_62 = (tmpvar_65 * (2.0 - tmpvar_65));
  if ((len_63 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_62 = (linearFogDensity_62 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_66;
  tmpvar_66 = min (pow (linearFogDensity_62, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_62 = tmpvar_66;
  mediump float tmpvar_67;
  highp float tmpvar_68;
  tmpvar_68 = clamp (((tmpvar_19.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_67 = tmpvar_68;
  h_61 = (tmpvar_67 * (2.0 - tmpvar_67));
  highp vec3 tmpvar_69;
  tmpvar_69 = (_HeigtFogColBase3.xyz + (h_61 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_60 = tmpvar_69;
  highp vec3 tmpvar_70;
  tmpvar_70 = mix (atomesphereFogColor_60, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_63 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_60 = tmpvar_70;
  mediump float tmpvar_71;
  mediump float r_72;
  mediump float f_73;
  mediump float u_74;
  mediump float l_75;
  mediump float fogInt_76;
  fogInt_76 = 1.0;
  highp float tmpvar_77;
  tmpvar_77 = (_HeigtFogParams3.x * tmpvar_20.y);
  highp float tmpvar_78;
  tmpvar_78 = abs(tmpvar_77);
  if ((tmpvar_78 > 0.01)) {
    highp float tmpvar_79;
    tmpvar_79 = exp(-(tmpvar_77));
    fogInt_76 = ((1.0 - tmpvar_79) / tmpvar_77);
  };
  highp float tmpvar_80;
  tmpvar_80 = sqrt(dot (tmpvar_20, tmpvar_20));
  l_75 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = (l_75 * _HeigtFogParams3.y);
  u_74 = tmpvar_81;
  fogInt_76 = (fogInt_76 * u_74);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (((l_75 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  r_72 = (tmpvar_82 * (2.0 - tmpvar_82));
  r_72 = ((r_72 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_73 = ((1.0 - clamp (
    exp2(-(fogInt_76))
  , 0.0, 1.0)) * r_72);
  highp float tmpvar_84;
  tmpvar_84 = min (f_73, _HeigtFogColBase3.w);
  tmpvar_71 = tmpvar_84;
  HeightFogFactor_59 = tmpvar_71;
  highp vec3 tmpvar_85;
  tmpvar_85 = _Mihoyo_FogColor3.xyz;
  heightFogColor_58 = tmpvar_85;
  highp vec3 tmpvar_86;
  tmpvar_86 = ((heightFogColor_58 * HeightFogFactor_59) + ((atomesphereFogColor_60 * tmpvar_66) * (1.0 - HeightFogFactor_59)));
  fogColor_57 = tmpvar_86;
  highp float tmpvar_87;
  tmpvar_87 = ((1.0 - tmpvar_66) * (1.0 - HeightFogFactor_59));
  fogFactor_56 = tmpvar_87;
  mediump vec4 tmpvar_88;
  tmpvar_88.xyz = fogColor_57;
  tmpvar_88.w = fogFactor_56;
  tmpvar_55 = tmpvar_88;
  highp vec4 tmpvar_89;
  tmpvar_89 = mix (tmpvar_21, tmpvar_55, vec4(_LerpFactor));
  tmpvar_18 = tmpvar_89;
  highp vec4 tmpvar_90;
  tmpvar_90 = (unity_ObjectToWorld * _glesVertex);
  adjCamPos_6.xz = (tmpvar_90.xz - ((tmpvar_90.xz - _WorldSpaceCameraPos.xz) * _CamDistRatio));
  adjCamPos_6.y = (_WorldSpaceCameraPos.y + _CamHeightOffset);
  highp vec3 tmpvar_91;
  tmpvar_91 = normalize((tmpvar_90.xyz - adjCamPos_6));
  tmpvar_12 = tmpvar_91;
  mediump float tmpvar_92;
  tmpvar_92 = cos(_CamRotate);
  cost_5 = tmpvar_92;
  mediump float tmpvar_93;
  tmpvar_93 = sin(_CamRotate);
  sint_4 = tmpvar_93;
  highp mat2 tmpvar_94;
  tmpvar_94[0].x = cost_5;
  tmpvar_94[0].y = -(sint_4);
  tmpvar_94[1].x = sint_4;
  tmpvar_94[1].y = cost_5;
  tmpvar_12.xz = (tmpvar_94 * tmpvar_12.xz);
  highp vec4 tmpvar_95;
  tmpvar_95.xyz = offsetVertex_7.xyz;
  tmpvar_95.w = tmpvar_1.w;
  mediump vec3 fogParam_96;
  highp vec4 tmpvar_97;
  tmpvar_97 = (unity_ObjectToWorld * tmpvar_95);
  highp vec2 tmpvar_98;
  tmpvar_98 = (tmpvar_97.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_99;
  tmpvar_99 = max (0.0, (sqrt(
    dot (tmpvar_98, tmpvar_98)
  ) - _UWFogDistStart));
  highp float tmpvar_100;
  tmpvar_100 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_99)
    ) * (_UWFogDensity * tmpvar_99))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_101;
  tmpvar_101 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_99))
   * 
    (_UWFogColorNFIntensity * tmpvar_99)
  )), 0.0, 1.0);
  fogParam_96.x = tmpvar_101;
  fogParam_96.y = tmpvar_100;
  fogParam_96.z = tmpvar_97.y;
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_10;
  xlv_COLOR0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_18;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_3.xyz;
  xlv_TEXCOORD3 = tmpvar_12;
  xlv_TEXCOORD4 = fogParam_96;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _BaseColor;
uniform mediump vec4 _UpColor;
uniform mediump vec4 _MaskColor;
uniform mediump float _MaskScale;
uniform highp float _USpeed;
uniform highp float _VSpeed;
uniform lowp samplerCube _EnvTex;
uniform mediump float _Reflectivity;
uniform sampler2D _FlowMap;
uniform highp float _Speed;
uniform highp float _FlowIntensity;
uniform highp float _FlowSignX;
uniform highp float _FlowSignY;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 Maskmap_1;
  mediump vec4 finalColor_2;
  mediump vec4 base_color1_3;
  mediump vec4 base_color0_4;
  mediump vec2 flow_dir_5;
  mediump float flow_scale1_6;
  mediump float flow_scale0_7;
  mediump vec3 flowAll_8;
  mediump float time_9;
  mediump vec2 uv_10;
  mediump vec2 UV_11;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _MainTex_ST.xy) + _MainTex_ST.zw);
  UV_11 = tmpvar_12;
  highp vec2 tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_USpeed * _Time.y);
  tmpvar_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (_VSpeed * _Time.y);
  tmpvar_13.y = tmpvar_15;
  UV_11 = (UV_11 + tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_14;
  tmpvar_16.y = tmpvar_15;
  highp vec2 tmpvar_17;
  tmpvar_17 = (UV_11 + tmpvar_16);
  uv_10 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = _Time.y;
  time_9 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_FlowMap, uv_10).xyz;
  flowAll_8 = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = fract(((_Speed * time_9) + flowAll_8.z));
  flow_scale0_7 = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = fract(((
    (_Speed * time_9)
   + flowAll_8.z) + 0.5));
  flow_scale1_6 = tmpvar_21;
  flowAll_8.xy = (2.0 * (flowAll_8.xy - vec2(0.5, 0.5)));
  highp vec2 tmpvar_22;
  tmpvar_22.x = _FlowSignX;
  tmpvar_22.y = _FlowSignY;
  flowAll_8.xy = (flowAll_8.xy * tmpvar_22);
  highp vec2 tmpvar_23;
  tmpvar_23 = (flowAll_8.xy * _FlowIntensity);
  flow_dir_5 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24 = (uv_10 + (flow_dir_5 * flow_scale0_7));
  mediump vec2 tmpvar_25;
  tmpvar_25 = (uv_10 + (flow_dir_5 * flow_scale1_6));
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  base_color0_4 = tmpvar_26;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_25);
  base_color1_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = mix (base_color0_4, base_color1_3, vec4(abs((2.0 * 
    (flow_scale0_7 - 0.5)
  ))));
  finalColor_2.w = 0.0;
  finalColor_2.xyz = mix (_BaseColor.xyz, _UpColor.xyz, vec3((tmpvar_28.x * xlv_COLOR0.x)));
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (tmpvar_28.x * _EmissionScaler)));
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2D (_MainTex, xlv_TEXCOORD1);
  Maskmap_1 = tmpvar_29;
  finalColor_2.xyz = (finalColor_2.xyz * (1.0 + (
    (_MaskColor.xyz * Maskmap_1.y)
   * _MaskScale)));
  mediump vec3 tmpvar_30;
  tmpvar_30 = (xlv_TEXCOORD3 - (2.0 * (
    dot (xlv_TEXCOORD2, xlv_TEXCOORD3)
   * xlv_TEXCOORD2)));
  lowp vec4 tmpvar_31;
  tmpvar_31 = textureCube (_EnvTex, tmpvar_30);
  finalColor_2.xyz = (finalColor_2.xyz + ((tmpvar_31.xyz * _Reflectivity) * (vec3(1.0, 1.0, 1.0) - xlv_COLOR0.xxx)));
  finalColor_2.w = tmpvar_28.w;
  mediump float x_32;
  x_32 = (tmpvar_28.w - _Cutoff);
  if ((x_32 < 0.0)) {
    discard;
  };
  if ((xlv_TEXCOORD4.z > _WaterPlaneHeight)) {
    finalColor_2.xyz = mix (finalColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_33;
    xlat_varinput_33 = xlv_TEXCOORD4;
    mediump vec3 fogParam_34;
    highp float tmpvar_35;
    tmpvar_35 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD4.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_36;
    tmpvar_36 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_35))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_37;
    tmpvar_37 = clamp ((_UWFogColorHLIntensity * tmpvar_35), 0.0, 1.0);
    fogParam_34.z = 0.0;
    fogParam_34.y = tmpvar_36;
    fogParam_34.x = tmpvar_37;
    if ((xlv_TEXCOORD4.y > 0.99)) {
      xlat_varinput_33.y = (xlv_TEXCOORD4.y * (1.0 - (tmpvar_35 * _UWHeightRatio)));
      highp float tmpvar_38;
      tmpvar_38 = clamp (xlat_varinput_33.y, _UWCriticalRange, 1.0);
      xlat_varinput_33.y = tmpvar_38;
    };
    fogParam_34.z = (1.0 - xlat_varinput_33.y);
    mediump vec4 tmpvar_39;
    tmpvar_39.w = 0.0;
    tmpvar_39.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_40;
    tmpvar_40 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD4.xxxx), tmpvar_39, fogParam_34.zzzz).xyz;
    finalColor_2.xyz = tmpvar_40;
    mediump vec4 tmpvar_41;
    tmpvar_41.w = 0.0;
    tmpvar_41.xyz = finalColor_2.xyz;
    highp vec3 tmpvar_42;
    tmpvar_42 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_34.xxxx), tmpvar_41, fogParam_34.yyyy).xyz;
    finalColor_2.xyz = tmpvar_42;
  };
  finalColor_2.xyz = mix (finalColor_2.xyz, vec3(dot (finalColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = finalColor_2;
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
}
}