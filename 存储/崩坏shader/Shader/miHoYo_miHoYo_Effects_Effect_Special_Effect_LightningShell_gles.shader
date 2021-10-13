//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/LightningShell" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler To Add", Range(1, 100)) = 1
_NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseScaler ("Noise Scaler", Range(0, 10)) = 1
_Transition ("Transition", Range(0, 1)) = 0
_Displacement ("Displacement", Range(0, 0.1)) = 0
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "DisableBatching" = "true" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 40596
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _Displacement;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = (tmpvar_4.x + (tmpvar_4.z * tmpvar_4.z));
  tmpvar_5.y = ((tmpvar_4.y + (0.5 * tmpvar_4.z)) + ((0.5 * tmpvar_4.x) * tmpvar_4.x));
  tmpvar_2 = tmpvar_5;
  tmpvar_2 = ((tmpvar_2 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _BloomFactor;
highp float xlat_mutable_Transition;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float intensity_1;
  mediump float noiseValue_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * noiseValue_2) * _NoiseScaler) - 1.0);
  intensity_1 = tmpvar_5;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  if ((intensity_1 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_6;
    tmpvar_6 = clamp ((10.0 * (
      -(intensity_1)
     + 
      (1.7 * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_3.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_6);
    outColor_3.w = _BloomFactor;
  } else {
    outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _Displacement;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = (tmpvar_4.x + (tmpvar_4.z * tmpvar_4.z));
  tmpvar_5.y = ((tmpvar_4.y + (0.5 * tmpvar_4.z)) + ((0.5 * tmpvar_4.x) * tmpvar_4.x));
  tmpvar_2 = tmpvar_5;
  tmpvar_2 = ((tmpvar_2 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _BloomFactor;
highp float xlat_mutable_Transition;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float intensity_1;
  mediump float noiseValue_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * noiseValue_2) * _NoiseScaler) - 1.0);
  intensity_1 = tmpvar_5;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  if ((intensity_1 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_6;
    tmpvar_6 = clamp ((10.0 * (
      -(intensity_1)
     + 
      (1.7 * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_3.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_6);
    outColor_3.w = _BloomFactor;
  } else {
    outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _Displacement;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = (tmpvar_4.x + (tmpvar_4.z * tmpvar_4.z));
  tmpvar_5.y = ((tmpvar_4.y + (0.5 * tmpvar_4.z)) + ((0.5 * tmpvar_4.x) * tmpvar_4.x));
  tmpvar_2 = tmpvar_5;
  tmpvar_2 = ((tmpvar_2 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _BloomFactor;
highp float xlat_mutable_Transition;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float intensity_1;
  mediump float noiseValue_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_2 = tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * noiseValue_2) * _NoiseScaler) - 1.0);
  intensity_1 = tmpvar_5;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  if ((intensity_1 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_6;
    tmpvar_6 = clamp ((10.0 * (
      -(intensity_1)
     + 
      (1.7 * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_3.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_6);
    outColor_3.w = _BloomFactor;
  } else {
    outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  };
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
}
}
}
CustomEditor "MoleMole.PropShaderEditorBase"
}