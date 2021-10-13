//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect_Trail/Channel Mix2" {
Properties {
_TintColor0 ("Tint Color0", Color) = (0.5,0.5,0.5,0.5)
_TintColor1 ("Tint Color1", Color) = (0.5,0.5,0.5,0.5)
_TintColor2 ("Tint Color2", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_Timer ("_Timer", Range(0, 1)) = 0
_AppearTime ("Appear Time", Range(0, 1)) = 0
_VanishTime ("Vanish Time", Range(0, 1)) = 0
_AlphaOverLife ("Alpha Over Life", Vector) = (0.197,0.815,0,0)
_CamForward ("Camera Forward", Vector) = (0,0,1,0)
_IsUseCamForward ("Is Use Camera Forward", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle(_EndMoveX_ON)] _EndMoveX ("EndMoveX", Float) = 1
[Toggle(_EndMoveY_ON)] _EndMoveY ("EndMoveY", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DTTex ("Distortion Tex", 2D) = "gray" { }
_DTIntensity ("Distortion Intensity", Range(0, 10)) = 5
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 65218
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7 = tmpvar_2;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7 = tmpvar_2;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7 = tmpvar_2;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = tmpvar_2.x;
    tmpvar_7.y = (_glesMultiTexCoord0.y + (_Timer + 0.5));
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = tmpvar_2.x;
    tmpvar_7.y = (_glesMultiTexCoord0.y + (_Timer + 0.5));
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = tmpvar_2.x;
    tmpvar_7.y = (_glesMultiTexCoord0.y + (_Timer + 0.5));
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_EndMoveX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = (_glesMultiTexCoord0.x - (_Timer + 0.5));
    tmpvar_7.y = tmpvar_2.y;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = (_glesMultiTexCoord0.x - (_Timer + 0.5));
    tmpvar_7.y = tmpvar_2.y;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveX_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    tmpvar_7.x = (_glesMultiTexCoord0.x - (_Timer + 0.5));
    tmpvar_7.y = tmpvar_2.y;
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    highp float tmpvar_17;
    tmpvar_17 = (_Timer + 0.5);
    tmpvar_7.x = (_glesMultiTexCoord0.x - tmpvar_17);
    tmpvar_7.y = (_glesMultiTexCoord0.y + tmpvar_17);
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    highp float tmpvar_17;
    tmpvar_17 = (_Timer + 0.5);
    tmpvar_7.x = (_glesMultiTexCoord0.x - tmpvar_17);
    tmpvar_7.y = (_glesMultiTexCoord0.y + tmpvar_17);
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _Timer;
uniform highp float _AppearTime;
uniform highp float _VanishTime;
uniform highp vec2 _AlphaOverLife;
uniform highp vec3 _CamForward;
uniform highp float _IsUseCamForward;
uniform highp mat4 _SizeOverLife;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec3 tmpvar_3;
  tmpvar_3 = _glesNormal;
  highp vec4 tmpvar_4;
  tmpvar_4 = _glesVertex;
  highp vec3 faceForward_5;
  highp float time_6;
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8 = 0.0;
  tmpvar_9 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_10;
  if ((_VanishTime < 0.01)) {
    tmpvar_10 = _AppearTime;
  } else {
    tmpvar_10 = (1.0 + _VanishTime);
  };
  time_6 = (tmpvar_10 - _glesMultiTexCoord0.x);
  highp float size_11;
  size_11 = mix (_SizeOverLife[1].x, _SizeOverLife[2].x, 0.499);
  if ((_IsUseCamForward >= 0.5)) {
    faceForward_5 = (sqrt(dot (_glesNormal, _glesNormal)) * normalize((
      (_glesNormal.yzx * _CamForward.zxy)
     - 
      (_glesNormal.zxy * _CamForward.yzx)
    )));
  } else {
    faceForward_5 = tmpvar_3;
  };
  tmpvar_4.xyz = (_glesVertex.xyz + (faceForward_5 * size_11));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_4.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_9 = tmpvar_1;
  mediump float alpha_14;
  alpha_14 = 1.0;
  highp float tmpvar_15;
  if ((_Timer < _AlphaOverLife.x)) {
    tmpvar_15 = (_Timer / _AlphaOverLife.x);
  } else {
    tmpvar_15 = 1.0;
  };
  alpha_14 = tmpvar_15;
  highp float tmpvar_16;
  if ((_AlphaOverLife.y < _Timer)) {
    tmpvar_16 = ((1.0 - _Timer) / (1.0 - _AlphaOverLife.y));
  } else {
    tmpvar_16 = alpha_14;
  };
  alpha_14 = tmpvar_16;
  tmpvar_9.w = alpha_14;
  tmpvar_7.x = (_glesMultiTexCoord0.x / _AppearTime);
  tmpvar_7.y = tmpvar_2.y;
  if ((_Timer < 0.5)) {
    tmpvar_7.y = tmpvar_2.y;
  };
  if (((_Timer > 0.5) && (_Timer <= 1.0))) {
    highp float tmpvar_17;
    tmpvar_17 = (_Timer + 0.5);
    tmpvar_7.x = (_glesMultiTexCoord0.x - tmpvar_17);
    tmpvar_7.y = (_glesMultiTexCoord0.y + tmpvar_17);
  };
  tmpvar_8 = 0.1;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((tmpvar_7 * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_TEXCOORD2 = time_6;
  xlv_COLOR = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
uniform mediump vec4 _TintColor0;
uniform mediump vec4 _TintColor1;
uniform mediump vec4 _TintColor2;
varying highp vec2 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp float xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 srcColor_2;
  highp float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  highp float x_4;
  x_4 = (0.999 - xlv_TEXCOORD1);
  if ((x_4 < 0.0)) {
    discard;
  };
  highp float x_5;
  x_5 = (xlv_TEXCOORD2 - 0.001);
  if ((x_5 < 0.0)) {
    discard;
  };
  highp float x_6;
  x_6 = (xlv_TEXCOORD0.x - -0.999);
  if ((x_6 < 0.0)) {
    discard;
  };
  highp float x_7;
  x_7 = (2.0 - xlv_TEXCOORD0.x);
  if ((x_7 < 0.0)) {
    discard;
  };
  highp float x_8;
  x_8 = (xlv_TEXCOORD0.y - 0.001);
  if ((x_8 < 0.0)) {
    discard;
  };
  highp float x_9;
  x_9 = (2.0 - xlv_TEXCOORD0.y);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  srcColor_2 = tmpvar_10;
  color_1.w = _TintColor0.w;
  color_1.xyz = mix (_TintColor0.xyz, _TintColor1.xyz, srcColor_2.xxx);
  color_1.xyz = mix (color_1.xyz, _TintColor2.xyz, srcColor_2.yyy);
  color_1.xyz = (color_1.xyz * ((2.0 * _EmissionScaler) * xlv_COLOR).xyz);
  color_1.w = (srcColor_2.z * xlv_COLOR.w);
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
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveX_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_EndMoveX_ON" "_EndMoveY_ON" }
""
}
}
}
}
CustomEditor "MoleMole.TrailShaderEditorBase"
}