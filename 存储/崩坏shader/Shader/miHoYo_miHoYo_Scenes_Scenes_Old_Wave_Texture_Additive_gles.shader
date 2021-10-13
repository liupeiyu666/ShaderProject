//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Wave_Texture_Additive" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_Wavesspeed ("Waves speed", Range(-10, 10)) = 0.75
_GradientPower ("Gradient Power", Float) = 5
[Toggle(INVERT_GRAD)] _InvertGrad ("Invert Grad", Float) = 0
[Toggle(INVERT_V)] _InvertV ("Invert V", Float) = 0
_NormalMap ("Normal Map", 2D) = "white" { }
_Distortion ("Distortion", Float) = 1
_BumpVelocity0 ("Bump Velocity 0", Vector) = (0,0,0,0)
_BumpScale0 ("Bump Scale 0", Float) = 1
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpScale1 ("Bump Scale 1", Float) = 1
_ClampYMin ("Clamp Y Min", Float) = 0
_ClampYMax ("Clamp Y Max", Float) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 7561
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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
uniform mediump vec2 _BumpVelocity0;
uniform mediump float _BumpScale0;
uniform mediump vec2 _BumpVelocity1;
uniform mediump float _BumpScale1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BumpScale0) + (_BumpVelocity0 * _Time.y));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BumpScale1) + (_BumpVelocity1 * _Time.y));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 tmpvar_7;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_10;
    tmpvar_10 = max (0.0, (sqrt(
      dot (tmpvar_9, tmpvar_9)
    ) - _FogStartDistance));
    highp float tmpvar_11;
    tmpvar_11 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_10)
      ) * (_FogIntensity * tmpvar_10))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_10)) * (_FogColorIntensity * tmpvar_10))
    ), 0.0, 1.0)));
    fogColor_8.xyz = tmpvar_12;
    fogColor_8.w = tmpvar_11;
    tmpvar_7 = fogColor_8;
  } else {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    highp float tmpvar_17;
    tmpvar_17 = (_FogEndDistance - _FogStartDistance);
    tmpvar_16 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_15) / max (0.1, tmpvar_17))
    , 0.0, 1.0))));
    fogColor_13.xyz = tmpvar_18;
    fogColor_13.w = tmpvar_16;
    tmpvar_7 = fogColor_13;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _MainColor;
uniform mediump float _GradientPower;
uniform sampler2D _NormalMap;
uniform mediump float _Distortion;
uniform mediump float _Wavesspeed;
uniform mediump float _ClampYMin;
uniform mediump float _ClampYMax;
uniform mediump float _InvertGrad;
uniform mediump float _InvertV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp float grad_1;
  mediump vec4 col_2;
  mediump vec2 rimPanningV_3;
  mediump vec3 accNormal_4;
  if ((xlv_TEXCOORD2.y > _ClampYMax)) {
    discard;
  };
  if ((xlv_TEXCOORD2.y < _ClampYMin)) {
    discard;
  };
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz + texture2D (_NormalMap, xlv_TEXCOORD1).xyz) - 0.6);
  accNormal_4 = tmpvar_5;
  mediump vec2 tmpvar_6;
  tmpvar_6 = (accNormal_4.xy * _Distortion);
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD2 + ((_Time.y * vec2(0.0, 0.11)) * _Wavesspeed));
  rimPanningV_3 = tmpvar_7;
  col_2 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_InvertV > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).x;
    tmpvar_8.y = (1.0 - ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3).y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, tmpvar_8);
    col_2 = tmpvar_9;
  } else {
    lowp vec4 tmpvar_10;
    mediump vec2 P_11;
    P_11 = ((xlv_TEXCOORD2 - tmpvar_6) + rimPanningV_3);
    tmpvar_10 = texture2D (_MainTex, P_11);
    col_2 = tmpvar_10;
  };
  col_2 = ((col_2 * _MainColor) * (xlv_COLOR0 * _EmissionScaler));
  mediump float tmpvar_12;
  tmpvar_12 = pow ((1.0 - xlv_TEXCOORD2.y), _GradientPower);
  grad_1 = tmpvar_12;
  if ((_InvertGrad > 0.0)) {
    grad_1 = clamp ((1.0 - grad_1), 0.0, 1.0);
  };
  highp float tmpvar_13;
  tmpvar_13 = clamp ((col_2.w * grad_1), 0.0, 1.0);
  col_2.w = tmpvar_13;
  col_2.xyz = (col_2.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_2;
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