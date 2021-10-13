//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_SkyBox" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "RenderType" = "Opaque" }
  GpuProgramID 39638
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
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
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
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
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _SkyBoxBloomFactor;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.xyz = (col_1.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_5.xyz - _WorldSpaceCameraPos);
  highp float tmpvar_6;
  tmpvar_6 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_7;
  tmpvar_7 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_6)
    ) * (_FogIntensity * tmpvar_6))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_6)) * (_FogColorIntensity * tmpvar_6))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_8;
  fogColor_3.w = tmpvar_7;
  mediump vec3 fogParam_9;
  highp vec2 tmpvar_10;
  tmpvar_10 = (tmpvar_5.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_11;
  tmpvar_11 = max (0.0, (sqrt(
    dot (tmpvar_10, tmpvar_10)
  ) - _UWFogDistStart));
  highp float tmpvar_12;
  tmpvar_12 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_11)
    ) * (_UWFogDensity * tmpvar_11))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_13;
  tmpvar_13 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_11))
   * 
    (_UWFogColorNFIntensity * tmpvar_11)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_13;
  fogParam_9.y = tmpvar_12;
  fogParam_9.z = tmpvar_5.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR1 = fogColor_3;
  xlv_TEXCOORD1 = fogParam_9;
}


#endif
#ifdef FRAGMENT
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
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  if ((xlv_TEXCOORD1.z > _WaterPlaneHeight)) {
    col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  } else {
    mediump vec3 xlat_varinput_3;
    xlat_varinput_3 = xlv_TEXCOORD1;
    mediump vec3 fogParam_4;
    highp float tmpvar_5;
    tmpvar_5 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD1.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_6;
    tmpvar_6 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_5))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_7;
    tmpvar_7 = clamp ((_UWFogColorHLIntensity * tmpvar_5), 0.0, 1.0);
    fogParam_4.z = 0.0;
    fogParam_4.y = tmpvar_6;
    fogParam_4.x = tmpvar_7;
    if ((xlv_TEXCOORD1.y > 0.99)) {
      xlat_varinput_3.y = (xlv_TEXCOORD1.y * (1.0 - (tmpvar_5 * _UWHeightRatio)));
      highp float tmpvar_8;
      tmpvar_8 = clamp (xlat_varinput_3.y, _UWCriticalRange, 1.0);
      xlat_varinput_3.y = tmpvar_8;
    };
    fogParam_4.z = (1.0 - xlat_varinput_3.y);
    mediump vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = col_1.xyz;
    highp vec3 tmpvar_10;
    tmpvar_10 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD1.xxxx), tmpvar_9, fogParam_4.zzzz).xyz;
    col_1.xyz = tmpvar_10;
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 0.0;
    tmpvar_11.xyz = col_1.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_4.xxxx), tmpvar_11, fogParam_4.yyyy).xyz;
    col_1.xyz = tmpvar_12;
  };
  col_1.w = 1.0;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
Fallback "Diffuse"
}