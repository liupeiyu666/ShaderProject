//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/TreeLeavesDyanmic" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 0
_BendScale ("Bend Scale", Range(0, 0.1)) = 0.01
_UpDownScale ("UpDown Scale", Range(0, 0.5)) = 0.1
_WiggleScale ("WiggleScale Scale", Range(0, 0.5)) = 0.1
_ObjectColor ("Object Color", Color) = (1,1,1,1)
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 32941
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _miHoYo_Wind;
uniform highp vec4 _miHoYo_WindParams3;
uniform highp vec4 _MainTex_ST;
uniform highp float _BendScale;
uniform highp float _UpDownScale;
uniform highp float _WiggleScale;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec3 vPos_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_2 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_2.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_2.y;
  vNewPos_7.xz = (vPos_2.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_2 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_2, vPos_2)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _glesNormal;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * tmpvar_9).xyz;
  highp vec3 vPos_11;
  highp float fBranchPhase_12;
  fBranchPhase_12 = tmpvar_1.y;
  highp float fEdgeAtten_13;
  fEdgeAtten_13 = tmpvar_1.x;
  highp float fBranchAtten_14;
  fBranchAtten_14 = tmpvar_1.z;
  fBranchPhase_12 = (fBranchPhase_12 + dot (tmpvar_5, vec3(1.0, 1.0, 1.0)));
  highp vec2 tmpvar_15;
  tmpvar_15.x = dot (vPos_2, vec3(fBranchPhase_12));
  tmpvar_15.y = fBranchPhase_12;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = abs(((
    fract((((
      (fract(((_miHoYo_WindParams3.x + tmpvar_15).xxyy * vec4(1.975, 0.793, 0.375, 0.193))) * 2.0)
     - 1.0) * 0.5) + 0.5))
   * 2.0) - 1.0));
  tmpvar_16 = (((tmpvar_17 * tmpvar_17) * (3.0 - 
    (2.0 * tmpvar_17)
  )) - 0.5);
  highp vec2 tmpvar_18;
  tmpvar_18 = (tmpvar_16.xz + tmpvar_16.yw);
  vPos_11 = (vPos_2 + (tmpvar_18.x * (
    ((fEdgeAtten_13 * 0.1) * (_WiggleScale * _miHoYo_WindParams3.y))
   * tmpvar_10)));
  vPos_11.y = (vPos_11.y + ((tmpvar_18.y * fBranchAtten_14) * (_UpDownScale * _miHoYo_WindParams3.y)));
  vPos_2 = vPos_11;
  highp vec4 tmpvar_19;
  tmpvar_19.xyz = vPos_11;
  tmpvar_19.w = tmpvar_6.w;
  tmpvar_3 = (unity_MatrixVP * tmpvar_19);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_20;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _BloomFactor;
uniform highp vec3 _ObjectColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = ((col_1.xyz * _ObjectColor) * xlv_COLOR0.w);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _BloomFactor;
  gl_FragData[0] = col_1;
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
}
}
}
}