//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/FogEffect_Texture_Additive_With_Light" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_LightMaskTex ("Mask (R)", 2D) = "white" { }
_LightColor ("Light Color", Color) = (1,1,1,1)
_LightWidth ("Light Width", Float) = 0.01
_LightSpeed ("Light Speed", Float) = 0.5
_LightTime ("Light Time", Float) = 1
_ModeTime ("Mode Time", Float) = 1
[Toggle(USE_SCRIPT)] _UseScript ("Use Script", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 61896
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord2.xy;
  mediump vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec2 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
  tmpvar_7 = tmpvar_2;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_12)
      ) * (_FogIntensity * tmpvar_12))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    highp float tmpvar_19;
    tmpvar_19 = (_FogEndDistance - _FogStartDistance);
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, tmpvar_19))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_20;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_TEXCOORD2 = tmpvar_7;
  xlv_COLOR0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
uniform mediump float _LightWidth;
uniform mediump float _LightSpeed;
uniform mediump float _LightTime;
uniform mediump float _ModeTime;
uniform mediump float _UseScript;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1 = ((col_1 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _EmissionScaler);
  if (bool(_UseScript)) {
    mediump float tmpvar_5;
    tmpvar_5 = (_ModeTime * _LightSpeed);
    mediump float tmpvar_6;
    tmpvar_6 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_6 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) <= 0.0))) {
      highp vec3 tmpvar_7;
      tmpvar_7 = ((_LightColor * tmpvar_4) * 2.0).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_7);
    };
    mediump float tmpvar_8;
    tmpvar_8 = abs((xlv_TEXCOORD2.y - tmpvar_5));
    if (((tmpvar_8 < _LightWidth) && ((xlv_TEXCOORD2.y - tmpvar_5) >= 0.0))) {
      highp vec3 tmpvar_9;
      tmpvar_9 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_9);
    };
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10 = (xlv_TEXCOORD1 - 0.5);
    mediump float tmpvar_11;
    tmpvar_11 = sqrt(dot (tmpvar_10, tmpvar_10));
    highp float tmpvar_12;
    tmpvar_12 = (_Time.y / _LightTime);
    highp float tmpvar_13;
    tmpvar_13 = fract(abs(tmpvar_12));
    mediump float tmpvar_14;
    tmpvar_14 = (tmpvar_13 * _LightTime);
    mediump float tmpvar_15;
    if ((tmpvar_12 >= 0.0)) {
      tmpvar_15 = tmpvar_14;
    } else {
      tmpvar_15 = -(tmpvar_14);
    };
    mediump float tmpvar_16;
    tmpvar_16 = abs((tmpvar_11 - (tmpvar_15 * _LightSpeed)));
    if ((tmpvar_16 < _LightWidth)) {
      highp vec3 tmpvar_17;
      tmpvar_17 = (_LightColor * tmpvar_4).xyz;
      col_1.xyz = (col_1.xyz + tmpvar_17);
    };
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
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