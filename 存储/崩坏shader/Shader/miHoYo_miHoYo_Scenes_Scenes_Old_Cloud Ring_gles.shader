//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Cloud Ring" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_AspectRatio ("Aspect Ratio", Float) = 1
_TexRColor ("Texture Color For R Channel", Color) = (1,1,1,1)
_TexGColor ("Texture Color For G Channel", Color) = (1,1,1,1)
_TexBColor ("Texture Color For B Channel", Color) = (1,1,1,1)
_CloudMaskIntensity ("Cloud Mask Intensity", Range(0, 1)) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_GradFrontColor ("Gradiant Front Color", Color) = (1,1,1,1)
_GradBackColor ("Gradiant Back Color", Color) = (1,1,1,1)
_GradLocationY ("Gradiant LocationY", Range(-5, 1)) = 0
_GradHighY ("Gradiant HighY", Range(0.01, 10)) = 1
_GradLocationRotateX ("Gradiant Location RotateX", Range(-1, 1)) = 0
_GradLocationX ("Gradiant LocationX", Range(-5, 1)) = 0
_GradHighX ("Gradiant HighX", Range(0.01, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry-1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Geometry-1" "RenderType" = "Transparent" }
  ZTest Always
  Cull Off
  GpuProgramID 42486
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
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
uniform highp float _GradLocationX;
uniform highp float _GradHighX;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
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
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.x + _GradLocationX) / _GradHighX);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _TexRColor;
uniform mediump vec4 _TexGColor;
uniform mediump vec4 _TexBColor;
uniform highp float _CloudMaskIntensity;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
varying mediump vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol_1;
  mediump float maskFB_2;
  mediump vec4 outColor_3;
  highp float tmpvar_4;
  tmpvar_4 = clamp (xlv_TEXCOORD1, 0.0, 1.0);
  maskFB_2 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5 = mix (_GradFrontColor, (_GradBackColor * 2.0), vec4(maskFB_2));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texCol_1 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = vec4((texCol_1.x * _TexRColor.w));
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (tmpvar_5, (_TexRColor * mix (1.0, maskFB_2, _CloudMaskIntensity)), tmpvar_7);
  outColor_3 = tmpvar_8;
  outColor_3 = (mix (mix (outColor_3, 
    (_TexGColor * tmpvar_5)
  , vec4(
    (texCol_1.y * _TexGColor.w)
  )), vec4(1.0, 1.0, 1.0, 1.0), (
    (_TexBColor * texCol_1.z)
   * 
    (2.0 * _TexBColor.w)
  )) + ((
    (_TexBColor * _TexBColor.w)
   * texCol_1.z) * (1.0 - maskFB_2)));
  outColor_3.xyz = mix (outColor_3.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_3.w = clamp (texCol_1.x, 0.0, 1.0);
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