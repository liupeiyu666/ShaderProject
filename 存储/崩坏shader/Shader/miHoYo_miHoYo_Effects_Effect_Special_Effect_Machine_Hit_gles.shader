//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Machine_Hit" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_OutsideEmission ("Outside Emission", Float) = 1
_InsideEmission ("Inside Emission", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_MainColor ("Main Color", Color) = (1,1,1,1)
_LightMaskTex ("Mask (R)", 2D) = "white" { }
_LightColor ("Light Color", Color) = (1,1,1,1)
_Random1234 ("Random 1234", Vector) = (-1,-1,-1,-1)
_Random5678 ("Random 5678", Vector) = (-1,-1,-1,-1)
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 13002
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec2 tmpvar_6;
  mediump vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = tmpvar_1;
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
  tmpvar_7 = tmpvar_2;
  highp float tmpvar_21;
  tmpvar_21 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_21;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_22;
  tmpvar_22 = abs(result_3);
  if ((tmpvar_22 >= 1.0)) {
    tmpvar_7.w = 0.0;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR0 = tmpvar_7;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * (vec3(1.0, 1.0, 1.0) - xlv_COLOR1.www));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase.xyz + (h_18 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_20 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  tmpvar_9 = tmpvar_12;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_46;
  tmpvar_46 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_46;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_47;
  tmpvar_47 = abs(result_3);
  if ((tmpvar_47 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase.xyz + (h_18 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_20 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  tmpvar_9 = tmpvar_12;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_46;
  tmpvar_46 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_46;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_47;
  tmpvar_47 = abs(result_3);
  if ((tmpvar_47 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor.w), _HeigtFogColBase.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase.xyz + (h_18 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_20 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  tmpvar_9 = tmpvar_12;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_46;
  tmpvar_46 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_46;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_47;
  tmpvar_47 = abs(result_3);
  if ((tmpvar_47 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase2.xyz + (h_18 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_20 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams2.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams2.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase2.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor2.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  highp vec4 tmpvar_46;
  mediump float fogFactor_47;
  mediump vec3 fogColor_48;
  mediump vec3 heightFogColor_49;
  highp float HeightFogFactor_50;
  mediump vec3 atomesphereFogColor_51;
  mediump float h_52;
  highp float linearFogDensity_53;
  mediump float len_54;
  highp float tmpvar_55;
  tmpvar_55 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_54 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((len_54 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_53 = (tmpvar_56 * (2.0 - tmpvar_56));
  if ((len_54 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_53 = (linearFogDensity_53 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_57;
  tmpvar_57 = min (pow (linearFogDensity_53, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_53 = tmpvar_57;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  h_52 = (tmpvar_58 * (2.0 - tmpvar_58));
  highp vec3 tmpvar_60;
  tmpvar_60 = (_HeigtFogColBase3.xyz + (h_52 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_51 = tmpvar_60;
  highp vec3 tmpvar_61;
  tmpvar_61 = mix (atomesphereFogColor_51, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_54 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_51 = tmpvar_61;
  mediump float tmpvar_62;
  mediump float r_63;
  mediump float f_64;
  mediump float u_65;
  mediump float l_66;
  mediump float fogInt_67;
  fogInt_67 = 1.0;
  highp float tmpvar_68;
  tmpvar_68 = (_HeigtFogParams3.x * tmpvar_11.y);
  highp float tmpvar_69;
  tmpvar_69 = abs(tmpvar_68);
  if ((tmpvar_69 > 0.01)) {
    highp float tmpvar_70;
    tmpvar_70 = exp(-(tmpvar_68));
    fogInt_67 = ((1.0 - tmpvar_70) / tmpvar_68);
  };
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_66 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = (l_66 * _HeigtFogParams3.y);
  u_65 = tmpvar_72;
  fogInt_67 = (fogInt_67 * u_65);
  mediump float tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = clamp (((l_66 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_73 = tmpvar_74;
  r_63 = (tmpvar_73 * (2.0 - tmpvar_73));
  r_63 = ((r_63 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_64 = ((1.0 - clamp (
    exp2(-(fogInt_67))
  , 0.0, 1.0)) * r_63);
  highp float tmpvar_75;
  tmpvar_75 = min (f_64, _HeigtFogColBase3.w);
  tmpvar_62 = tmpvar_75;
  HeightFogFactor_50 = tmpvar_62;
  highp vec3 tmpvar_76;
  tmpvar_76 = _Mihoyo_FogColor3.xyz;
  heightFogColor_49 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = ((heightFogColor_49 * HeightFogFactor_50) + ((atomesphereFogColor_51 * tmpvar_57) * (1.0 - HeightFogFactor_50)));
  fogColor_48 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = ((1.0 - tmpvar_57) * (1.0 - HeightFogFactor_50));
  fogFactor_47 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.xyz = fogColor_48;
  tmpvar_79.w = fogFactor_47;
  tmpvar_46 = tmpvar_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = mix (tmpvar_12, tmpvar_46, vec4(_LerpFactor));
  tmpvar_9 = tmpvar_80;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_81;
  tmpvar_81 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_81;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_82;
  tmpvar_82 = abs(result_3);
  if ((tmpvar_82 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase2.xyz + (h_18 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_20 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams2.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams2.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase2.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor2.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  highp vec4 tmpvar_46;
  mediump float fogFactor_47;
  mediump vec3 fogColor_48;
  mediump vec3 heightFogColor_49;
  highp float HeightFogFactor_50;
  mediump vec3 atomesphereFogColor_51;
  mediump float h_52;
  highp float linearFogDensity_53;
  mediump float len_54;
  highp float tmpvar_55;
  tmpvar_55 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_54 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((len_54 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_53 = (tmpvar_56 * (2.0 - tmpvar_56));
  if ((len_54 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_53 = (linearFogDensity_53 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_57;
  tmpvar_57 = min (pow (linearFogDensity_53, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_53 = tmpvar_57;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  h_52 = (tmpvar_58 * (2.0 - tmpvar_58));
  highp vec3 tmpvar_60;
  tmpvar_60 = (_HeigtFogColBase3.xyz + (h_52 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_51 = tmpvar_60;
  highp vec3 tmpvar_61;
  tmpvar_61 = mix (atomesphereFogColor_51, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_54 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_51 = tmpvar_61;
  mediump float tmpvar_62;
  mediump float r_63;
  mediump float f_64;
  mediump float u_65;
  mediump float l_66;
  mediump float fogInt_67;
  fogInt_67 = 1.0;
  highp float tmpvar_68;
  tmpvar_68 = (_HeigtFogParams3.x * tmpvar_11.y);
  highp float tmpvar_69;
  tmpvar_69 = abs(tmpvar_68);
  if ((tmpvar_69 > 0.01)) {
    highp float tmpvar_70;
    tmpvar_70 = exp(-(tmpvar_68));
    fogInt_67 = ((1.0 - tmpvar_70) / tmpvar_68);
  };
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_66 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = (l_66 * _HeigtFogParams3.y);
  u_65 = tmpvar_72;
  fogInt_67 = (fogInt_67 * u_65);
  mediump float tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = clamp (((l_66 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_73 = tmpvar_74;
  r_63 = (tmpvar_73 * (2.0 - tmpvar_73));
  r_63 = ((r_63 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_64 = ((1.0 - clamp (
    exp2(-(fogInt_67))
  , 0.0, 1.0)) * r_63);
  highp float tmpvar_75;
  tmpvar_75 = min (f_64, _HeigtFogColBase3.w);
  tmpvar_62 = tmpvar_75;
  HeightFogFactor_50 = tmpvar_62;
  highp vec3 tmpvar_76;
  tmpvar_76 = _Mihoyo_FogColor3.xyz;
  heightFogColor_49 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = ((heightFogColor_49 * HeightFogFactor_50) + ((atomesphereFogColor_51 * tmpvar_57) * (1.0 - HeightFogFactor_50)));
  fogColor_48 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = ((1.0 - tmpvar_57) * (1.0 - HeightFogFactor_50));
  fogFactor_47 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.xyz = fogColor_48;
  tmpvar_79.w = fogFactor_47;
  tmpvar_46 = tmpvar_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = mix (tmpvar_12, tmpvar_46, vec4(_LerpFactor));
  tmpvar_9 = tmpvar_80;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_81;
  tmpvar_81 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_81;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_82;
  tmpvar_82 = abs(result_3);
  if ((tmpvar_82 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
  gl_FragData[0] = col_1;
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
attribute vec4 _glesMultiTexCoord2;
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
uniform mediump vec4 _Random1234;
uniform mediump vec4 _Random5678;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  mediump float result_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_5 = tmpvar_1;
  mediump vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_12;
  mediump float fogFactor_13;
  mediump vec3 fogColor_14;
  mediump vec3 heightFogColor_15;
  highp float HeightFogFactor_16;
  mediump vec3 atomesphereFogColor_17;
  mediump float h_18;
  highp float linearFogDensity_19;
  mediump float len_20;
  highp float tmpvar_21;
  tmpvar_21 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_20 = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = clamp (((len_20 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_19 = (tmpvar_22 * (2.0 - tmpvar_22));
  if ((len_20 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_19 = (linearFogDensity_19 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_23;
  tmpvar_23 = min (pow (linearFogDensity_19, _Mihoyo_FogColor2.w), _HeigtFogColBase2.w);
  linearFogDensity_19 = tmpvar_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (((tmpvar_10.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  h_18 = (tmpvar_24 * (2.0 - tmpvar_24));
  highp vec3 tmpvar_26;
  tmpvar_26 = (_HeigtFogColBase2.xyz + (h_18 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_17 = tmpvar_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = mix (atomesphereFogColor_17, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_20 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_17 = tmpvar_27;
  mediump float tmpvar_28;
  mediump float r_29;
  mediump float f_30;
  mediump float u_31;
  mediump float l_32;
  mediump float fogInt_33;
  fogInt_33 = 1.0;
  highp float tmpvar_34;
  tmpvar_34 = (_HeigtFogParams2.x * tmpvar_11.y);
  highp float tmpvar_35;
  tmpvar_35 = abs(tmpvar_34);
  if ((tmpvar_35 > 0.01)) {
    highp float tmpvar_36;
    tmpvar_36 = exp(-(tmpvar_34));
    fogInt_33 = ((1.0 - tmpvar_36) / tmpvar_34);
  };
  highp float tmpvar_37;
  tmpvar_37 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_32 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = (l_32 * _HeigtFogParams2.y);
  u_31 = tmpvar_38;
  fogInt_33 = (fogInt_33 * u_31);
  mediump float tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = clamp (((l_32 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_39 = tmpvar_40;
  r_29 = (tmpvar_39 * (2.0 - tmpvar_39));
  r_29 = ((r_29 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_30 = ((1.0 - clamp (
    exp2(-(fogInt_33))
  , 0.0, 1.0)) * r_29);
  highp float tmpvar_41;
  tmpvar_41 = min (f_30, _HeigtFogColBase2.w);
  tmpvar_28 = tmpvar_41;
  HeightFogFactor_16 = tmpvar_28;
  highp vec3 tmpvar_42;
  tmpvar_42 = _Mihoyo_FogColor2.xyz;
  heightFogColor_15 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = ((heightFogColor_15 * HeightFogFactor_16) + ((atomesphereFogColor_17 * tmpvar_23) * (1.0 - HeightFogFactor_16)));
  fogColor_14 = tmpvar_43;
  highp float tmpvar_44;
  tmpvar_44 = ((1.0 - tmpvar_23) * (1.0 - HeightFogFactor_16));
  fogFactor_13 = tmpvar_44;
  mediump vec4 tmpvar_45;
  tmpvar_45.xyz = fogColor_14;
  tmpvar_45.w = fogFactor_13;
  tmpvar_12 = tmpvar_45;
  highp vec4 tmpvar_46;
  mediump float fogFactor_47;
  mediump vec3 fogColor_48;
  mediump vec3 heightFogColor_49;
  highp float HeightFogFactor_50;
  mediump vec3 atomesphereFogColor_51;
  mediump float h_52;
  highp float linearFogDensity_53;
  mediump float len_54;
  highp float tmpvar_55;
  tmpvar_55 = sqrt(dot (tmpvar_11, tmpvar_11));
  len_54 = tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (((len_54 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_53 = (tmpvar_56 * (2.0 - tmpvar_56));
  if ((len_54 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_53 = (linearFogDensity_53 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_57;
  tmpvar_57 = min (pow (linearFogDensity_53, _Mihoyo_FogColor3.w), _HeigtFogColBase3.w);
  linearFogDensity_53 = tmpvar_57;
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (((tmpvar_10.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  h_52 = (tmpvar_58 * (2.0 - tmpvar_58));
  highp vec3 tmpvar_60;
  tmpvar_60 = (_HeigtFogColBase3.xyz + (h_52 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_51 = tmpvar_60;
  highp vec3 tmpvar_61;
  tmpvar_61 = mix (atomesphereFogColor_51, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_54 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_51 = tmpvar_61;
  mediump float tmpvar_62;
  mediump float r_63;
  mediump float f_64;
  mediump float u_65;
  mediump float l_66;
  mediump float fogInt_67;
  fogInt_67 = 1.0;
  highp float tmpvar_68;
  tmpvar_68 = (_HeigtFogParams3.x * tmpvar_11.y);
  highp float tmpvar_69;
  tmpvar_69 = abs(tmpvar_68);
  if ((tmpvar_69 > 0.01)) {
    highp float tmpvar_70;
    tmpvar_70 = exp(-(tmpvar_68));
    fogInt_67 = ((1.0 - tmpvar_70) / tmpvar_68);
  };
  highp float tmpvar_71;
  tmpvar_71 = sqrt(dot (tmpvar_11, tmpvar_11));
  l_66 = tmpvar_71;
  highp float tmpvar_72;
  tmpvar_72 = (l_66 * _HeigtFogParams3.y);
  u_65 = tmpvar_72;
  fogInt_67 = (fogInt_67 * u_65);
  mediump float tmpvar_73;
  highp float tmpvar_74;
  tmpvar_74 = clamp (((l_66 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_73 = tmpvar_74;
  r_63 = (tmpvar_73 * (2.0 - tmpvar_73));
  r_63 = ((r_63 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_64 = ((1.0 - clamp (
    exp2(-(fogInt_67))
  , 0.0, 1.0)) * r_63);
  highp float tmpvar_75;
  tmpvar_75 = min (f_64, _HeigtFogColBase3.w);
  tmpvar_62 = tmpvar_75;
  HeightFogFactor_50 = tmpvar_62;
  highp vec3 tmpvar_76;
  tmpvar_76 = _Mihoyo_FogColor3.xyz;
  heightFogColor_49 = tmpvar_76;
  highp vec3 tmpvar_77;
  tmpvar_77 = ((heightFogColor_49 * HeightFogFactor_50) + ((atomesphereFogColor_51 * tmpvar_57) * (1.0 - HeightFogFactor_50)));
  fogColor_48 = tmpvar_77;
  highp float tmpvar_78;
  tmpvar_78 = ((1.0 - tmpvar_57) * (1.0 - HeightFogFactor_50));
  fogFactor_47 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.xyz = fogColor_48;
  tmpvar_79.w = fogFactor_47;
  tmpvar_46 = tmpvar_79;
  highp vec4 tmpvar_80;
  tmpvar_80 = mix (tmpvar_12, tmpvar_46, vec4(_LerpFactor));
  tmpvar_9 = tmpvar_80;
  tmpvar_6 = tmpvar_2;
  highp float tmpvar_81;
  tmpvar_81 = (((
    (_glesMultiTexCoord2.xy - _Random1234.x)
   * 
    (_glesMultiTexCoord2.xy - _Random1234.y)
  ) * (_glesMultiTexCoord2.xy - _Random1234.z)) * (_glesMultiTexCoord2.xy - _Random1234.w)).x;
  result_3 = tmpvar_81;
  result_3 = (((
    (result_3 * (_glesMultiTexCoord2.xy - _Random5678.x))
   * 
    (_glesMultiTexCoord2.xy - _Random5678.y)
  ) * (_glesMultiTexCoord2.xy - _Random5678.z)) * (_glesMultiTexCoord2.xy - _Random5678.w)).x;
  mediump float tmpvar_82;
  tmpvar_82 = abs(result_3);
  if ((tmpvar_82 >= 1.0)) {
    tmpvar_6.w = 0.0;
  };
  gl_Position = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
  xlv_COLOR1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _OutsideEmission;
uniform mediump float _InsideEmission;
uniform mediump vec4 _MainColor;
uniform sampler2D _LightMaskTex;
uniform highp vec4 _LightColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.w = ((col_1 * _MainColor) * (xlv_COLOR0 * _OutsideEmission)).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMaskTex, xlv_TEXCOORD0);
  mediump float tmpvar_4;
  tmpvar_4 = (tmpvar_3.x * _InsideEmission);
  highp vec3 tmpvar_5;
  tmpvar_5 = (_LightColor * tmpvar_4).xyz;
  col_1.xyz = tmpvar_5;
  if ((xlv_COLOR0.w > 0.0)) {
    col_1.w = _BloomFactor;
  };
  col_1.xyz = (col_1.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0));
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
}
}
}
}