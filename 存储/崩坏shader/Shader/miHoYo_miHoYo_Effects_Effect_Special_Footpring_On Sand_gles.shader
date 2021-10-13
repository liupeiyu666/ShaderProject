//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Footpring/On Sand" {
Properties {
_NormalMap ("Normal Map", 2D) = "blue" { }
_ColorMask ("Color Mask", 2D) = "black" { }
_Color ("Color", Color) = (1,1,1,1)
_LightColor ("Light Color", Color) = (1,1,1,1)
_ShadowColor ("Shadow Color", Color) = (1,1,1,1)
_LightIntensity ("Light Intensity", Range(0, 10)) = 1
_ShadowIntensity ("Shadow Intensity", Range(0, 10)) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 0.75
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent-1" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Transparent-1" }
  ZWrite Off
  Cull Off
  Offset -1, -1
  GpuProgramID 11175
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec4 fogColor_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_4;
  tmpvar_4 = max (0.0, (sqrt(
    dot (tmpvar_3, tmpvar_3)
  ) - _FogStartDistance));
  highp float tmpvar_5;
  tmpvar_5 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_4)
    ) * (_FogIntensity * tmpvar_4))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_6;
  tmpvar_6 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_4)) * (_FogColorIntensity * tmpvar_4))
  ), 0.0, 1.0)));
  fogColor_2.xyz = tmpvar_6;
  fogColor_2.w = tmpvar_5;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR1 = fogColor_2;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = mix (tmpvar_9.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor.w), _HeigtFogColDelta.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase.xyz + (h_13 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_15 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  tmpvar_4 = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor.w), _HeigtFogColDelta.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase.xyz + (h_13 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_15 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  tmpvar_4 = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams.z) + _HeigtFogParams.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor.w), _HeigtFogColDelta.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams.x) + _HeigtFogColParams.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase.xyz + (h_13 * _HeigtFogColDelta.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol.xyz, vec3(clamp ((_HeigtFogColParams.w * 
    (len_15 - _HeigtFogRamp.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp.x) + _HeigtFogRamp.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp.z) + (1.0 - _HeigtFogRamp.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  tmpvar_4 = tmpvar_7;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor2.w), _HeigtFogColDelta2.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase2.xyz + (h_13 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_15 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams2.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams2.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta2.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor2.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  highp vec4 tmpvar_41;
  mediump float fogFactor_42;
  mediump vec3 fogColor_43;
  mediump vec3 heightFogColor_44;
  highp float HeightFogFactor_45;
  mediump vec3 atomesphereFogColor_46;
  mediump float h_47;
  highp float linearFogDensity_48;
  mediump float len_49;
  highp float tmpvar_50;
  tmpvar_50 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((len_49 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_48 = (tmpvar_51 * (2.0 - tmpvar_51));
  if ((len_49 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_48 = (linearFogDensity_48 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_52;
  tmpvar_52 = min (pow (linearFogDensity_48, _Mihoyo_FogColor3.w), _HeigtFogColDelta3.w);
  linearFogDensity_48 = tmpvar_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (((tmpvar_5.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  h_47 = (tmpvar_53 * (2.0 - tmpvar_53));
  highp vec3 tmpvar_55;
  tmpvar_55 = (_HeigtFogColBase3.xyz + (h_47 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_46 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (atomesphereFogColor_46, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_49 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_46 = tmpvar_56;
  mediump float tmpvar_57;
  mediump float r_58;
  mediump float f_59;
  mediump float u_60;
  mediump float l_61;
  mediump float fogInt_62;
  fogInt_62 = 1.0;
  highp float tmpvar_63;
  tmpvar_63 = (_HeigtFogParams3.x * tmpvar_6.y);
  highp float tmpvar_64;
  tmpvar_64 = abs(tmpvar_63);
  if ((tmpvar_64 > 0.01)) {
    highp float tmpvar_65;
    tmpvar_65 = exp(-(tmpvar_63));
    fogInt_62 = ((1.0 - tmpvar_65) / tmpvar_63);
  };
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_61 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (l_61 * _HeigtFogParams3.y);
  u_60 = tmpvar_67;
  fogInt_62 = (fogInt_62 * u_60);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((l_61 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  r_58 = (tmpvar_68 * (2.0 - tmpvar_68));
  r_58 = ((r_58 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_59 = ((1.0 - clamp (
    exp2(-(fogInt_62))
  , 0.0, 1.0)) * r_58);
  highp float tmpvar_70;
  tmpvar_70 = min (f_59, _HeigtFogColDelta3.w);
  tmpvar_57 = tmpvar_70;
  HeightFogFactor_45 = tmpvar_57;
  highp vec3 tmpvar_71;
  tmpvar_71 = _Mihoyo_FogColor3.xyz;
  heightFogColor_44 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = ((heightFogColor_44 * HeightFogFactor_45) + ((atomesphereFogColor_46 * tmpvar_52) * (1.0 - HeightFogFactor_45)));
  fogColor_43 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = ((1.0 - tmpvar_52) * (1.0 - HeightFogFactor_45));
  fogFactor_42 = tmpvar_73;
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = fogColor_43;
  tmpvar_74.w = fogFactor_42;
  tmpvar_41 = tmpvar_74;
  highp vec4 tmpvar_75;
  tmpvar_75 = mix (tmpvar_7, tmpvar_41, vec4(_LerpFactor));
  tmpvar_4 = tmpvar_75;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor2.w), _HeigtFogColDelta2.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase2.xyz + (h_13 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_15 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams2.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams2.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta2.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor2.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  highp vec4 tmpvar_41;
  mediump float fogFactor_42;
  mediump vec3 fogColor_43;
  mediump vec3 heightFogColor_44;
  highp float HeightFogFactor_45;
  mediump vec3 atomesphereFogColor_46;
  mediump float h_47;
  highp float linearFogDensity_48;
  mediump float len_49;
  highp float tmpvar_50;
  tmpvar_50 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((len_49 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_48 = (tmpvar_51 * (2.0 - tmpvar_51));
  if ((len_49 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_48 = (linearFogDensity_48 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_52;
  tmpvar_52 = min (pow (linearFogDensity_48, _Mihoyo_FogColor3.w), _HeigtFogColDelta3.w);
  linearFogDensity_48 = tmpvar_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (((tmpvar_5.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  h_47 = (tmpvar_53 * (2.0 - tmpvar_53));
  highp vec3 tmpvar_55;
  tmpvar_55 = (_HeigtFogColBase3.xyz + (h_47 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_46 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (atomesphereFogColor_46, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_49 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_46 = tmpvar_56;
  mediump float tmpvar_57;
  mediump float r_58;
  mediump float f_59;
  mediump float u_60;
  mediump float l_61;
  mediump float fogInt_62;
  fogInt_62 = 1.0;
  highp float tmpvar_63;
  tmpvar_63 = (_HeigtFogParams3.x * tmpvar_6.y);
  highp float tmpvar_64;
  tmpvar_64 = abs(tmpvar_63);
  if ((tmpvar_64 > 0.01)) {
    highp float tmpvar_65;
    tmpvar_65 = exp(-(tmpvar_63));
    fogInt_62 = ((1.0 - tmpvar_65) / tmpvar_63);
  };
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_61 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (l_61 * _HeigtFogParams3.y);
  u_60 = tmpvar_67;
  fogInt_62 = (fogInt_62 * u_60);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((l_61 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  r_58 = (tmpvar_68 * (2.0 - tmpvar_68));
  r_58 = ((r_58 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_59 = ((1.0 - clamp (
    exp2(-(fogInt_62))
  , 0.0, 1.0)) * r_58);
  highp float tmpvar_70;
  tmpvar_70 = min (f_59, _HeigtFogColDelta3.w);
  tmpvar_57 = tmpvar_70;
  HeightFogFactor_45 = tmpvar_57;
  highp vec3 tmpvar_71;
  tmpvar_71 = _Mihoyo_FogColor3.xyz;
  heightFogColor_44 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = ((heightFogColor_44 * HeightFogFactor_45) + ((atomesphereFogColor_46 * tmpvar_52) * (1.0 - HeightFogFactor_45)));
  fogColor_43 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = ((1.0 - tmpvar_52) * (1.0 - HeightFogFactor_45));
  fogFactor_42 = tmpvar_73;
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = fogColor_43;
  tmpvar_74.w = fogFactor_42;
  tmpvar_41 = tmpvar_74;
  highp vec4 tmpvar_75;
  tmpvar_75 = mix (tmpvar_7, tmpvar_41, vec4(_LerpFactor));
  tmpvar_4 = tmpvar_75;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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
uniform mediump float _Opaqueness;
uniform highp vec4 _NormalMap_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  mediump vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp vec4 tmpvar_7;
  mediump float fogFactor_8;
  mediump vec3 fogColor_9;
  mediump vec3 heightFogColor_10;
  highp float HeightFogFactor_11;
  mediump vec3 atomesphereFogColor_12;
  mediump float h_13;
  highp float linearFogDensity_14;
  mediump float len_15;
  highp float tmpvar_16;
  tmpvar_16 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_15 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = clamp (((len_15 * _HeigtFogParams2.z) + _HeigtFogParams2.w), 0.0, 1.0);
  linearFogDensity_14 = (tmpvar_17 * (2.0 - tmpvar_17));
  if ((len_15 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_14 = (linearFogDensity_14 * _HeigtFogColDelta2.w);
  };
  highp float tmpvar_18;
  tmpvar_18 = min (pow (linearFogDensity_14, _Mihoyo_FogColor2.w), _HeigtFogColDelta2.w);
  linearFogDensity_14 = tmpvar_18;
  mediump float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((tmpvar_5.y * _HeigtFogColParams2.x) + _HeigtFogColParams2.y), 0.0, 1.0);
  tmpvar_19 = tmpvar_20;
  h_13 = (tmpvar_19 * (2.0 - tmpvar_19));
  highp vec3 tmpvar_21;
  tmpvar_21 = (_HeigtFogColBase2.xyz + (h_13 * _HeigtFogColDelta2.xyz));
  atomesphereFogColor_12 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = mix (atomesphereFogColor_12, _HeigtFogRadialCol2.xyz, vec3(clamp ((_HeigtFogColParams2.w * 
    (len_15 - _HeigtFogRamp2.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_12 = tmpvar_22;
  mediump float tmpvar_23;
  mediump float r_24;
  mediump float f_25;
  mediump float u_26;
  mediump float l_27;
  mediump float fogInt_28;
  fogInt_28 = 1.0;
  highp float tmpvar_29;
  tmpvar_29 = (_HeigtFogParams2.x * tmpvar_6.y);
  highp float tmpvar_30;
  tmpvar_30 = abs(tmpvar_29);
  if ((tmpvar_30 > 0.01)) {
    highp float tmpvar_31;
    tmpvar_31 = exp(-(tmpvar_29));
    fogInt_28 = ((1.0 - tmpvar_31) / tmpvar_29);
  };
  highp float tmpvar_32;
  tmpvar_32 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_27 = tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = (l_27 * _HeigtFogParams2.y);
  u_26 = tmpvar_33;
  fogInt_28 = (fogInt_28 * u_26);
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (((l_27 * _HeigtFogRamp2.x) + _HeigtFogRamp2.y), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  r_24 = (tmpvar_34 * (2.0 - tmpvar_34));
  r_24 = ((r_24 * _HeigtFogRamp2.z) + (1.0 - _HeigtFogRamp2.z));
  f_25 = ((1.0 - clamp (
    exp2(-(fogInt_28))
  , 0.0, 1.0)) * r_24);
  highp float tmpvar_36;
  tmpvar_36 = min (f_25, _HeigtFogColDelta2.w);
  tmpvar_23 = tmpvar_36;
  HeightFogFactor_11 = tmpvar_23;
  highp vec3 tmpvar_37;
  tmpvar_37 = _Mihoyo_FogColor2.xyz;
  heightFogColor_10 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = ((heightFogColor_10 * HeightFogFactor_11) + ((atomesphereFogColor_12 * tmpvar_18) * (1.0 - HeightFogFactor_11)));
  fogColor_9 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((1.0 - tmpvar_18) * (1.0 - HeightFogFactor_11));
  fogFactor_8 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = fogColor_9;
  tmpvar_40.w = fogFactor_8;
  tmpvar_7 = tmpvar_40;
  highp vec4 tmpvar_41;
  mediump float fogFactor_42;
  mediump vec3 fogColor_43;
  mediump vec3 heightFogColor_44;
  highp float HeightFogFactor_45;
  mediump vec3 atomesphereFogColor_46;
  mediump float h_47;
  highp float linearFogDensity_48;
  mediump float len_49;
  highp float tmpvar_50;
  tmpvar_50 = sqrt(dot (tmpvar_6, tmpvar_6));
  len_49 = tmpvar_50;
  highp float tmpvar_51;
  tmpvar_51 = clamp (((len_49 * _HeigtFogParams3.z) + _HeigtFogParams3.w), 0.0, 1.0);
  linearFogDensity_48 = (tmpvar_51 * (2.0 - tmpvar_51));
  if ((len_49 >= (_ProjectionParams.z * 0.9999))) {
    linearFogDensity_48 = (linearFogDensity_48 * _HeigtFogColDelta3.w);
  };
  highp float tmpvar_52;
  tmpvar_52 = min (pow (linearFogDensity_48, _Mihoyo_FogColor3.w), _HeigtFogColDelta3.w);
  linearFogDensity_48 = tmpvar_52;
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp (((tmpvar_5.y * _HeigtFogColParams3.x) + _HeigtFogColParams3.y), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  h_47 = (tmpvar_53 * (2.0 - tmpvar_53));
  highp vec3 tmpvar_55;
  tmpvar_55 = (_HeigtFogColBase3.xyz + (h_47 * _HeigtFogColDelta3.xyz));
  atomesphereFogColor_46 = tmpvar_55;
  highp vec3 tmpvar_56;
  tmpvar_56 = mix (atomesphereFogColor_46, _HeigtFogRadialCol3.xyz, vec3(clamp ((_HeigtFogColParams3.w * 
    (len_49 - _HeigtFogRamp3.w)
  ), 0.0, 1.0)));
  atomesphereFogColor_46 = tmpvar_56;
  mediump float tmpvar_57;
  mediump float r_58;
  mediump float f_59;
  mediump float u_60;
  mediump float l_61;
  mediump float fogInt_62;
  fogInt_62 = 1.0;
  highp float tmpvar_63;
  tmpvar_63 = (_HeigtFogParams3.x * tmpvar_6.y);
  highp float tmpvar_64;
  tmpvar_64 = abs(tmpvar_63);
  if ((tmpvar_64 > 0.01)) {
    highp float tmpvar_65;
    tmpvar_65 = exp(-(tmpvar_63));
    fogInt_62 = ((1.0 - tmpvar_65) / tmpvar_63);
  };
  highp float tmpvar_66;
  tmpvar_66 = sqrt(dot (tmpvar_6, tmpvar_6));
  l_61 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = (l_61 * _HeigtFogParams3.y);
  u_60 = tmpvar_67;
  fogInt_62 = (fogInt_62 * u_60);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (((l_61 * _HeigtFogRamp3.x) + _HeigtFogRamp3.y), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  r_58 = (tmpvar_68 * (2.0 - tmpvar_68));
  r_58 = ((r_58 * _HeigtFogRamp3.z) + (1.0 - _HeigtFogRamp3.z));
  f_59 = ((1.0 - clamp (
    exp2(-(fogInt_62))
  , 0.0, 1.0)) * r_58);
  highp float tmpvar_70;
  tmpvar_70 = min (f_59, _HeigtFogColDelta3.w);
  tmpvar_57 = tmpvar_70;
  HeightFogFactor_45 = tmpvar_57;
  highp vec3 tmpvar_71;
  tmpvar_71 = _Mihoyo_FogColor3.xyz;
  heightFogColor_44 = tmpvar_71;
  highp vec3 tmpvar_72;
  tmpvar_72 = ((heightFogColor_44 * HeightFogFactor_45) + ((atomesphereFogColor_46 * tmpvar_52) * (1.0 - HeightFogFactor_45)));
  fogColor_43 = tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = ((1.0 - tmpvar_52) * (1.0 - HeightFogFactor_45));
  fogFactor_42 = tmpvar_73;
  mediump vec4 tmpvar_74;
  tmpvar_74.xyz = fogColor_43;
  tmpvar_74.w = fogFactor_42;
  tmpvar_41 = tmpvar_74;
  highp vec4 tmpvar_75;
  tmpvar_75 = mix (tmpvar_7, tmpvar_41, vec4(_LerpFactor));
  tmpvar_4 = tmpvar_75;
  xlv_TEXCOORD0 = tmpvar_1;
  gl_Position = tmpvar_2;
  xlv_COLOR1 = tmpvar_4;
  xlv_TEXCOORD1 = ((_glesColor.xyz * 2.0) - 1.0);
  xlv_TEXCOORD2 = (_glesColor.w * _Opaqueness);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NormalMap;
uniform sampler2D _ColorMask;
uniform mediump vec4 _Color;
uniform mediump vec4 _LightColor;
uniform mediump vec4 _ShadowColor;
uniform mediump float _LightIntensity;
uniform mediump float _ShadowIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump float xlv_TEXCOORD2;
void main ()
{
  mediump float mask_1;
  mediump vec3 N_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = ((texture2D (_NormalMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0).xzy;
  N_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = (dot (N_2, xlv_TEXCOORD1) - xlv_TEXCOORD1.y);
  mediump vec4 tmpvar_6;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_6 = _LightColor;
  } else {
    tmpvar_6 = _ShadowColor;
  };
  color_3.xyz = tmpvar_6.xyz;
  mediump float tmpvar_7;
  if ((tmpvar_5 >= 0.0)) {
    tmpvar_7 = _LightIntensity;
  } else {
    tmpvar_7 = -(_ShadowIntensity);
  };
  color_3.w = (tmpvar_5 * tmpvar_7);
  lowp float tmpvar_8;
  tmpvar_8 = texture2D (_ColorMask, xlv_TEXCOORD0).x;
  mask_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = mix (color_3, _Color, vec4(mask_1));
  color_3.w = (tmpvar_9.w * xlv_TEXCOORD2);
  color_3.xyz = (xlv_COLOR1.xyz + (tmpvar_9.xyz * clamp (xlv_COLOR1.w, 0.0, 1.0)));
  mediump float x_10;
  x_10 = (color_3.w - 0.01);
  if ((x_10 < 0.0)) {
    discard;
  };
  color_3.w = clamp (color_3.w, 0.0, 1.0);
  gl_FragData[0] = color_3;
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