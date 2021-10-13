//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Sky" {
Properties {
_MainTex ("Main Texture", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 48318
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxTexXLocation;
uniform highp float _SkyBoxTexYLocation;
uniform highp float _SkyBoxTexHigh;
uniform highp float _SkyBoxGradLocation;
uniform highp float _SkyBoxGradHigh;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _SkyBoxTexXLocation;
  tmpvar_2.y = -(_SkyBoxTexYLocation);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy + tmpvar_2) * floor((1.0/(_SkyBoxTexHigh))));
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.y + _SkyBoxGradLocation) / _SkyBoxGradHigh);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _SkyBoxTexRColor;
uniform mediump vec4 _SkyBoxTexGColor;
uniform mediump vec4 _SkyBoxTexBColor;
uniform mediump vec4 _SkyBoxGradBottomColor;
uniform mediump vec4 _SkyBoxGradTopColor;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump vec4 outColor_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = mix (_SkyBoxGradBottomColor, _SkyBoxGradTopColor, vec4(clamp (xlv_TEXCOORD1, 0.0, 1.0)));
  outColor_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_4;
  if (((xlv_TEXCOORD0.y >= 0.0) && (xlv_TEXCOORD0.y < 0.99))) {
    outColor_2 = mix (mix (mix (outColor_2, _SkyBoxTexRColor, vec4(
      (texCol_1.x * _SkyBoxTexRColor.w)
    )), _SkyBoxTexGColor, vec4((texCol_1.y * _SkyBoxTexGColor.w))), vec4(1.0, 1.0, 1.0, 1.0), (_SkyBoxTexBColor * texCol_1.z));
  };
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  outColor_2.w = _SkyBoxBloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
}