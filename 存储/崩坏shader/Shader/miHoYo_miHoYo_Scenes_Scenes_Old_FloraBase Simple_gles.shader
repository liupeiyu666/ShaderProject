//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/FloraBase Simple" {
Properties {
_Diffuse ("Diffuse", 2D) = "black" { }
_AlphaCutoff ("Alpha Cutoff", Float) = 1
_WindMask ("WindMask", 2D) = "bump" { }
_Frequency ("Shake Frequency", Float) = 1
_MainWindStr ("Main Wind Str", Float) = 0.3
_MainWindvector ("Main Wind vector", Vector) = (0,0,0,0)
_AdditionalwindGradient ("Additional wind Gradient", 2D) = "white" { }
_Additionalwindstr ("Additional wind str", Float) = 0.01
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFaceClip" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "DrawDepth" = "FrontFaceClip" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  Cull Off
  GpuProgramID 15516
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec4 _Diffuse_var_3;
  lowp vec4 tmpvar_4;
  highp vec2 P_5;
  P_5 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_4 = texture2D (_Diffuse, P_5);
  _Diffuse_var_3 = tmpvar_4;
  highp float x_6;
  x_6 = ((_Diffuse_var_3.w * _AlphaCutoff) - 0.5);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = _Diffuse_var_3.xyz;
  finalRGBA_2 = tmpvar_7;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform sampler2D _WindMask;
uniform highp vec4 _WindMask_ST;
uniform highp float _MainWindStr;
uniform highp float _Additionalwindstr;
uniform sampler2D _AdditionalwindGradient;
uniform highp vec4 _AdditionalwindGradient_ST;
uniform highp vec4 _MainWindvector;
uniform highp float _Frequency;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_Frequency * _Time);
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = (((_glesMultiTexCoord0.xy + 
    (tmpvar_2.y * vec2(0.1, 0.0))
  ) * _AdditionalwindGradient_ST.xy) + _AdditionalwindGradient_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_AdditionalwindGradient, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_glesMultiTexCoord2.xy * _WindMask_ST.xy) + _WindMask_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_WindMask, tmpvar_6.xy, 0.0);
  highp vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((tmpvar_5.xyz * _Additionalwindstr) * _glesNormal)
   + 
    ((sin((3.141593 + tmpvar_2.y)) * _MainWindStr) * _MainWindvector.xyz)
  ) * tmpvar_8.xyz));
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  mediump vec3 fogParam_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * tmpvar_1);
  highp vec2 tmpvar_12;
  tmpvar_12 = (tmpvar_11.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_13;
  tmpvar_13 = max (0.0, (sqrt(
    dot (tmpvar_12, tmpvar_12)
  ) - _UWFogDistStart));
  highp float tmpvar_14;
  tmpvar_14 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_13)
    ) * (_UWFogDensity * tmpvar_13))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_15;
  tmpvar_15 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_13))
   * 
    (_UWFogColorNFIntensity * tmpvar_13)
  )), 0.0, 1.0);
  fogParam_10.x = tmpvar_15;
  fogParam_10.y = tmpvar_14;
  fogParam_10.z = tmpvar_11.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = _glesMultiTexCoord2.xy;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * tmpvar_1);
  xlv_TEXCOORD3 = fogParam_10;
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
uniform sampler2D _Diffuse;
uniform highp vec4 _Diffuse_ST;
uniform highp float _AlphaCutoff;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 finalRGBA_2;
  highp vec3 finalColor_3;
  highp vec4 _Diffuse_var_4;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = ((xlv_TEXCOORD0 * _Diffuse_ST.xy) + _Diffuse_ST.zw);
  tmpvar_5 = texture2D (_Diffuse, P_6);
  _Diffuse_var_4 = tmpvar_5;
  highp float x_7;
  x_7 = ((_Diffuse_var_4.w * _AlphaCutoff) - 0.5);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp vec3 tmpvar_8;
  tmpvar_8 = _Diffuse_var_4.xyz;
  finalColor_3 = tmpvar_8;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_9;
    xlat_varinput_9 = xlv_TEXCOORD3;
    mediump vec3 fogParam_10;
    highp float tmpvar_11;
    tmpvar_11 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_12;
    tmpvar_12 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_11))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_13;
    tmpvar_13 = clamp ((_UWFogColorHLIntensity * tmpvar_11), 0.0, 1.0);
    fogParam_10.z = 0.0;
    fogParam_10.y = tmpvar_12;
    fogParam_10.x = tmpvar_13;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_9.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_11 * _UWHeightRatio)));
      highp float tmpvar_14;
      tmpvar_14 = clamp (xlat_varinput_9.y, _UWCriticalRange, 1.0);
      xlat_varinput_9.y = tmpvar_14;
    };
    fogParam_10.z = (1.0 - xlat_varinput_9.y);
    highp vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = tmpvar_8;
    finalColor_3 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_15, fogParam_10.zzzz).xyz;
    highp vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = finalColor_3;
    finalColor_3 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_10.xxxx), tmpvar_16, fogParam_10.yyyy).xyz;
  };
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = finalColor_3;
  finalRGBA_2 = tmpvar_17;
  finalRGBA_2.xyz = mix (finalRGBA_2.xyz, vec3(dot (finalRGBA_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  finalRGBA_2.w = clamp (finalRGBA_2.w, 0.0, 1.0);
  tmpvar_1 = finalRGBA_2;
  gl_FragData[0] = tmpvar_1;
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
}
}
}
Fallback "Diffuse"
CustomEditor "ShaderForgeMaterialInspector"
}