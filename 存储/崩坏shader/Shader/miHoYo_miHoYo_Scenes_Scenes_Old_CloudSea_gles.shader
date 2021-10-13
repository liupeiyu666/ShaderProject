//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/CloudSea" {
Properties {
_Tex1 ("Tex 1", 2D) = "white" { }
_TexRColor1 ("Texture Color For R Channel 1", Color) = (1,1,1,1)
_TexGColor1 ("Texture Color For G Channel 1", Color) = (1,1,1,1)
_TexBColor1 ("Texture Color For B Channel 1", Color) = (1,1,1,1)
_Velocity1 ("Velocity 1", Float) = 0
_Tex2 ("Tex 2", 2D) = "white" { }
_TexRColor2 ("Texture Color For R Channel 2", Color) = (1,1,1,1)
_TexGColor2 ("Texture Color For G Channel 2", Color) = (1,1,1,1)
_TexBColor2 ("Texture Color For B Channel 2", Color) = (1,1,1,1)
_Velocity2 ("Velocity 2", Float) = 0
_SunDirAngle ("Sun Direction Angle", Range(0, 6.283)) = 0
_SunDistance ("Sun Distance", Range(0, 10)) = 1
_GradFrontColor ("Gradiant Front Color", Color) = (1,1,1,1)
_GradBackColor ("Gradiant Back Color", Color) = (1,1,1,1)
_GradRangeScale ("Gradiant Range Scale", Float) = 1
_PerspectiveAdjConst ("Perspective Adjust Constant", Float) = 1
_PerspectiveAdjLinear ("Perspective Adjust Linear", Float) = 1
_CloudMaskIntensity ("Cloud Mask Intensity", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
  GpuProgramID 49391
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
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
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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
uniform highp vec4 _Time;
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
uniform highp vec4 _Tex1_ST;
uniform mediump float _Velocity1;
uniform highp vec4 _Tex2_ST;
uniform mediump float _Velocity2;
uniform mediump float _SunDirAngle;
uniform mediump float _SunDistance;
uniform highp float _PerspectiveAdjConst;
uniform highp float _PerspectiveAdjLinear;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 sunPos_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  mediump vec2 tmpvar_7;
  tmpvar_7.x = cos(_SunDirAngle);
  tmpvar_7.y = sin(_SunDirAngle);
  mediump vec2 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _SunDistance) + 0.5);
  sunPos_3 = tmpvar_8;
  tmpvar_5.xy = tmpvar_1;
  tmpvar_5.zw = sunPos_3;
  highp vec2 x_9;
  x_9 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  tmpvar_2 = (((_glesMultiTexCoord0.xy - 0.5) * (_PerspectiveAdjConst + 
    (_PerspectiveAdjLinear * sqrt(dot (x_9, x_9)))
  )) + 0.5);
  mediump vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = _Velocity1;
  highp vec2 tmpvar_11;
  tmpvar_11 = fract((tmpvar_10 * _Time.x));
  tmpvar_4.xy = (((tmpvar_2 * _Tex1_ST.xy) + _Tex1_ST.zw) - tmpvar_11);
  mediump vec2 tmpvar_12;
  tmpvar_12.x = 0.0;
  tmpvar_12.y = _Velocity2;
  highp vec2 tmpvar_13;
  tmpvar_13 = fract((tmpvar_12 * _Time.x));
  tmpvar_4.zw = (((tmpvar_2 * _Tex2_ST.xy) + _Tex2_ST.zw) - tmpvar_13);
  mediump vec4 fogColor_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_16;
  tmpvar_16 = max (0.0, (sqrt(
    dot (tmpvar_15, tmpvar_15)
  ) - _FogStartDistance));
  highp float tmpvar_17;
  tmpvar_17 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_16)
    ) * (_FogIntensity * tmpvar_16))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
  ), 0.0, 1.0)));
  fogColor_14.xyz = tmpvar_18;
  fogColor_14.w = tmpvar_17;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_COLOR1 = fogColor_14;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Tex1;
uniform mediump vec4 _TexRColor1;
uniform mediump vec4 _TexGColor1;
uniform mediump vec4 _TexBColor1;
uniform sampler2D _Tex2;
uniform mediump vec4 _TexRColor2;
uniform mediump vec4 _TexGColor2;
uniform mediump vec4 _TexBColor2;
uniform mediump vec4 _GradFrontColor;
uniform mediump vec4 _GradBackColor;
uniform mediump float _GradRangeScale;
uniform mediump float _CloudMaskIntensity;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _SkyBoxColor;
uniform mediump float _SkyBoxColorScaler;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 texCol1_1;
  mediump vec4 outColor_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (xlv_TEXCOORD1.xy - xlv_TEXCOORD1.zw);
  mediump float tmpvar_4;
  tmpvar_4 = pow (fract((
    sqrt(dot (tmpvar_3, tmpvar_3))
   * _GradRangeScale)), 0.7);
  mediump float tmpvar_5;
  tmpvar_5 = mix (1.0, tmpvar_4, _CloudMaskIntensity);
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (_GradFrontColor, _GradBackColor, vec4(tmpvar_4));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_Tex1, xlv_TEXCOORD0.xy);
  texCol1_1 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_Tex2, xlv_TEXCOORD0.zw);
  mediump vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * tmpvar_5) * tmpvar_6);
  outColor_2.xyz = (mix ((
    mix (mix (mix (vec4(1.0, 1.0, 1.0, 1.0), (_TexRColor1 * tmpvar_5), vec4((texCol1_1.x * _TexRColor1.w))), (_TexGColor1 * tmpvar_6), vec4((texCol1_1.y * _TexGColor1.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor1 * texCol1_1.z) * 2.0))
   + 
    ((_TexBColor1 * texCol1_1.z) * (1.0 - tmpvar_4))
  ), (
    mix (mix (_TexRColor2, (_TexGColor2 * tmpvar_6), vec4((tmpvar_9.y * _TexGColor2.w))), vec4(1.0, 1.0, 1.0, 1.0), ((_TexBColor2 * tmpvar_9.z) * 2.0))
   + 
    ((_TexBColor2 * tmpvar_9.z) * (1.0 - tmpvar_4))
  ), tmpvar_9.xxxx).xyz * _EmissionScaler);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.xyz = (outColor_2.xyz * (_SkyBoxColor * _SkyBoxColorScaler).xyz);
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