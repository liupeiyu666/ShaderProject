//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/PondWaterCaustics" {
Properties {
[Header(Caustics)] _CausticTex ("CausticTex", 2D) = "white" { }
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticTiling ("CausticTiling", Range(0, 2)) = 0.3
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 20)) = 1.2
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 0.3)) = 0.03
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.348
_CausticFade ("CausticFade", Range(0.01, 1)) = 0.837
_CausticFadeMinHeight ("CausticFadeMinHeight", Range(-200, 200)) = -145
_CausticFadeMaxHeight ("CausticFadeMaxHeight", Range(-200, 200)) = -13
_CausticFadeRange ("CausticFadeRange", Range(0, 10)) = 4.88
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 26108
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadeRange;
uniform highp float _CausticFadeMinHeight;
uniform highp float _CausticFadeMaxHeight;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 texCoord_1;
  texCoord_1 = xlv_TEXCOORD0;
  highp vec3 causticColor_2;
  highp vec4 color2_3;
  highp vec4 color1_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (texCoord_1 * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_6 + tmpvar_5);
  tmpvar_7 = texture2D (_CausticTex, P_8);
  color1_4 = tmpvar_7;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_6 * vec2(1.5, 1.5)) - tmpvar_5);
  tmpvar_9 = texture2D (_CausticTex, P_10);
  color2_3 = tmpvar_9;
  highp vec2 tmpvar_11;
  tmpvar_11 = (((_CausticTiling * 100.0) * texCoord_1) + (_CausticDistortionValue * mix (color1_4.yz, color2_3.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_CausticTex, tmpvar_11).xyz;
  causticColor_2 = tmpvar_12;
  causticColor_2 = (causticColor_2 * _CausticIntensity);
  causticColor_2 = (_CausticColor * causticColor_2.x);
  highp float edge0_13;
  edge0_13 = (_CausticFadeMaxHeight + _CausticFadeRange);
  highp float tmpvar_14;
  tmpvar_14 = clamp (((xlv_TEXCOORD1.y - edge0_13) / (_CausticFadeMaxHeight - edge0_13)), 0.0, 1.0);
  highp float edge0_15;
  edge0_15 = (_CausticFadeMinHeight - _CausticFadeRange);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((xlv_TEXCOORD1.y - edge0_15) / (_CausticFadeMinHeight - edge0_15)), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (causticColor_2 * ((_CausticFade * 
    (tmpvar_14 * (tmpvar_14 * (3.0 - (2.0 * tmpvar_14))))
  ) * (tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  )));
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadeRange;
uniform highp float _CausticFadeMinHeight;
uniform highp float _CausticFadeMaxHeight;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 texCoord_1;
  texCoord_1 = xlv_TEXCOORD0;
  highp vec3 causticColor_2;
  highp vec4 color2_3;
  highp vec4 color1_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (texCoord_1 * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_6 + tmpvar_5);
  tmpvar_7 = texture2D (_CausticTex, P_8);
  color1_4 = tmpvar_7;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_6 * vec2(1.5, 1.5)) - tmpvar_5);
  tmpvar_9 = texture2D (_CausticTex, P_10);
  color2_3 = tmpvar_9;
  highp vec2 tmpvar_11;
  tmpvar_11 = (((_CausticTiling * 100.0) * texCoord_1) + (_CausticDistortionValue * mix (color1_4.yz, color2_3.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_CausticTex, tmpvar_11).xyz;
  causticColor_2 = tmpvar_12;
  causticColor_2 = (causticColor_2 * _CausticIntensity);
  causticColor_2 = (_CausticColor * causticColor_2.x);
  highp float edge0_13;
  edge0_13 = (_CausticFadeMaxHeight + _CausticFadeRange);
  highp float tmpvar_14;
  tmpvar_14 = clamp (((xlv_TEXCOORD1.y - edge0_13) / (_CausticFadeMaxHeight - edge0_13)), 0.0, 1.0);
  highp float edge0_15;
  edge0_15 = (_CausticFadeMinHeight - _CausticFadeRange);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((xlv_TEXCOORD1.y - edge0_15) / (_CausticFadeMinHeight - edge0_15)), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (causticColor_2 * ((_CausticFade * 
    (tmpvar_14 * (tmpvar_14 * (3.0 - (2.0 * tmpvar_14))))
  ) * (tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  )));
  gl_FragData[0] = tmpvar_17;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _CausticTex;
uniform highp vec3 _CausticColor;
uniform highp float _CausticIntensity;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticFade;
uniform highp float _CausticFadeRange;
uniform highp float _CausticFadeMinHeight;
uniform highp float _CausticFadeMaxHeight;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 texCoord_1;
  texCoord_1 = xlv_TEXCOORD0;
  highp vec3 causticColor_2;
  highp vec4 color2_3;
  highp vec4 color1_4;
  highp float tmpvar_5;
  tmpvar_5 = (_Time * _CausticDistortionSpeed).x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (texCoord_1 * (vec2(_CausticDistortionTiling) * 200.0));
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = (tmpvar_6 + tmpvar_5);
  tmpvar_7 = texture2D (_CausticTex, P_8);
  color1_4 = tmpvar_7;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_6 * vec2(1.5, 1.5)) - tmpvar_5);
  tmpvar_9 = texture2D (_CausticTex, P_10);
  color2_3 = tmpvar_9;
  highp vec2 tmpvar_11;
  tmpvar_11 = (((_CausticTiling * 100.0) * texCoord_1) + (_CausticDistortionValue * mix (color1_4.yz, color2_3.yz, vec2(0.6, 0.6))));
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_CausticTex, tmpvar_11).xyz;
  causticColor_2 = tmpvar_12;
  causticColor_2 = (causticColor_2 * _CausticIntensity);
  causticColor_2 = (_CausticColor * causticColor_2.x);
  highp float edge0_13;
  edge0_13 = (_CausticFadeMaxHeight + _CausticFadeRange);
  highp float tmpvar_14;
  tmpvar_14 = clamp (((xlv_TEXCOORD1.y - edge0_13) / (_CausticFadeMaxHeight - edge0_13)), 0.0, 1.0);
  highp float edge0_15;
  edge0_15 = (_CausticFadeMinHeight - _CausticFadeRange);
  highp float tmpvar_16;
  tmpvar_16 = clamp (((xlv_TEXCOORD1.y - edge0_15) / (_CausticFadeMinHeight - edge0_15)), 0.0, 1.0);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = (causticColor_2 * ((_CausticFade * 
    (tmpvar_14 * (tmpvar_14 * (3.0 - (2.0 * tmpvar_14))))
  ) * (tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  )));
  gl_FragData[0] = tmpvar_17;
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}