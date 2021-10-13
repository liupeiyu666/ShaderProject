//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/FireShell" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler To Add", Range(1, 100)) = 1
_NoiseTex ("Noise Tex", 2D) = "white" { }
_NoiseScaler ("Noise Scaler", Range(0, 10)) = 1
_Transition ("Transition", Range(0, 1)) = 0
_Width ("Width", Range(0, 1)) = 0.2
_ClipWidth ("Clip Width (along z)", Range(-5, 5)) = 0.2
_ClipOffset ("Clip Offset (along z)", Range(-5, 5)) = 0
_FresnelParams ("Fresnel", Vector) = (1,0,0,0)
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
  GpuProgramID 22130
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = (tmpvar_3.x + (tmpvar_3.z * tmpvar_3.z));
  tmpvar_4.y = (((tmpvar_3.y - 
    (0.2 * tmpvar_3.z)
  ) - (
    (0.7 * tmpvar_3.z)
   * tmpvar_3.z)) + ((1.5 * tmpvar_3.x) * tmpvar_3.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((tmpvar_4 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1.xyz;
  xlv_TEXCOORD2 = _glesTANGENT.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _ClipWidth;
uniform highp float _ClipOffset;
uniform highp float _Width;
uniform mediump vec4 _FresnelParams;
highp float xlat_mutable_Transition;
highp float xlat_mutable_Width;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.xz = xlv_TEXCOORD2.xz;
  mediump float intensity_2;
  mediump float noiseValue_3;
  mediump float clipFactor_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_1.y = abs(xlv_TEXCOORD2.y);
  mediump vec3 N_6;
  N_6 = tmpvar_1;
  mediump float tmpvar_7;
  tmpvar_7 = (1.0 - (_FresnelParams.z + max (0.0, 
    (pow (clamp ((1.0 - N_6.y), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
  )));
  highp float tmpvar_8;
  tmpvar_8 = clamp (((xlv_TEXCOORD1.z - _ClipOffset) / _ClipWidth), 0.0, 1.0);
  clipFactor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_3 = tmpvar_9;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  xlat_mutable_Width = (_Width * (tmpvar_7 * clipFactor_4));
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * noiseValue_3) * _NoiseScaler) - 1.0);
  intensity_2 = tmpvar_10;
  if ((intensity_2 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_11;
    tmpvar_11 = clamp ((10.0 * (
      -(intensity_2)
     + 
      ((1.5 + xlat_mutable_Width) * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_5.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_11);
    outColor_5.w = tmpvar_11;
  } else {
    outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = (tmpvar_3.x + (tmpvar_3.z * tmpvar_3.z));
  tmpvar_4.y = (((tmpvar_3.y - 
    (0.2 * tmpvar_3.z)
  ) - (
    (0.7 * tmpvar_3.z)
   * tmpvar_3.z)) + ((1.5 * tmpvar_3.x) * tmpvar_3.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((tmpvar_4 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1.xyz;
  xlv_TEXCOORD2 = _glesTANGENT.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _ClipWidth;
uniform highp float _ClipOffset;
uniform highp float _Width;
uniform mediump vec4 _FresnelParams;
highp float xlat_mutable_Transition;
highp float xlat_mutable_Width;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.xz = xlv_TEXCOORD2.xz;
  mediump float intensity_2;
  mediump float noiseValue_3;
  mediump float clipFactor_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_1.y = abs(xlv_TEXCOORD2.y);
  mediump vec3 N_6;
  N_6 = tmpvar_1;
  mediump float tmpvar_7;
  tmpvar_7 = (1.0 - (_FresnelParams.z + max (0.0, 
    (pow (clamp ((1.0 - N_6.y), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
  )));
  highp float tmpvar_8;
  tmpvar_8 = clamp (((xlv_TEXCOORD1.z - _ClipOffset) / _ClipWidth), 0.0, 1.0);
  clipFactor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_3 = tmpvar_9;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  xlat_mutable_Width = (_Width * (tmpvar_7 * clipFactor_4));
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * noiseValue_3) * _NoiseScaler) - 1.0);
  intensity_2 = tmpvar_10;
  if ((intensity_2 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_11;
    tmpvar_11 = clamp ((10.0 * (
      -(intensity_2)
     + 
      ((1.5 + xlat_mutable_Width) * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_5.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_11);
    outColor_5.w = tmpvar_11;
  } else {
    outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = (_glesVertex.xyz + (_glesTANGENT.xyz * _Displacement));
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_1.xyz * 0.5);
  highp vec2 tmpvar_4;
  tmpvar_4.x = (tmpvar_3.x + (tmpvar_3.z * tmpvar_3.z));
  tmpvar_4.y = (((tmpvar_3.y - 
    (0.2 * tmpvar_3.z)
  ) - (
    (0.7 * tmpvar_3.z)
   * tmpvar_3.z)) + ((1.5 * tmpvar_3.x) * tmpvar_3.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((tmpvar_4 * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1.xyz;
  xlv_TEXCOORD2 = _glesTANGENT.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _NoiseTex;
uniform highp float _NoiseScaler;
uniform highp float _Transition;
uniform mediump vec4 _Color;
uniform highp float _EmissionScaler;
uniform highp float _ClipWidth;
uniform highp float _ClipOffset;
uniform highp float _Width;
uniform mediump vec4 _FresnelParams;
highp float xlat_mutable_Transition;
highp float xlat_mutable_Width;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1.xz = xlv_TEXCOORD2.xz;
  mediump float intensity_2;
  mediump float noiseValue_3;
  mediump float clipFactor_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_1.y = abs(xlv_TEXCOORD2.y);
  mediump vec3 N_6;
  N_6 = tmpvar_1;
  mediump float tmpvar_7;
  tmpvar_7 = (1.0 - (_FresnelParams.z + max (0.0, 
    (pow (clamp ((1.0 - N_6.y), 0.001, 1.0), _FresnelParams.x) * _FresnelParams.y)
  )));
  highp float tmpvar_8;
  tmpvar_8 = clamp (((xlv_TEXCOORD1.z - _ClipOffset) / _ClipWidth), 0.0, 1.0);
  clipFactor_4 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD0).x;
  noiseValue_3 = tmpvar_9;
  xlat_mutable_Transition = (_Transition * _NoiseScaler);
  xlat_mutable_Width = (_Width * (tmpvar_7 * clipFactor_4));
  highp float tmpvar_10;
  tmpvar_10 = (((1.99 * noiseValue_3) * _NoiseScaler) - 1.0);
  intensity_2 = tmpvar_10;
  if ((intensity_2 >= (1.5 * xlat_mutable_Transition))) {
    highp float tmpvar_11;
    tmpvar_11 = clamp ((10.0 * (
      -(intensity_2)
     + 
      ((1.5 + xlat_mutable_Width) * xlat_mutable_Transition)
    )), 0.0, 1.0);
    outColor_5.xyz = ((_Color.xyz * _EmissionScaler) * tmpvar_11);
    outColor_5.w = tmpvar_11;
  } else {
    outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  };
  outColor_5.w = clamp (outColor_5.w, 0.0, 1.0);
  gl_FragData[0] = outColor_5;
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