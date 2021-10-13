//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Texture_Waterfall" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emmision Scaler", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 57765
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  tmpvar_5 = tmpvar_1;
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
  xlv_COLOR1 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform mediump float _frameInterpolationFactor;
uniform sampler2D _MainTex;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
uniform highp float _BloomFactor;
uniform highp float _EmissionScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 color_1;
  mediump vec2 texcoord_2;
  texcoord_2 = xlv_TEXCOORD0;
  mediump vec2 texcoord_next_frame_3;
  texcoord_next_frame_3 = xlv_TEXCOORD1;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, texcoord_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, texcoord_next_frame_3);
  mediump vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  mediump vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, tmpvar_7, vec4(_frameInterpolationFactor));
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, vec3((tmpvar_8.y * _TintColor1.w)));
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, vec3((tmpvar_8.z * _TintColor2.w)));
  color_1.xyz = ((color_1.xyz * xlv_TEXCOORD2.xyz) * _EmissionScaler);
  color_1.xyz = mix (color_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_1.w = ((_BloomFactor * tmpvar_8.x) * xlv_TEXCOORD2.w);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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