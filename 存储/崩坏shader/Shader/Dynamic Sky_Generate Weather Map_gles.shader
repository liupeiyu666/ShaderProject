//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Generate Weather Map" {
Properties {
_PerlineWorleyNoiseTex ("Perline-Worley Noise", 2D) = "white" { }
[Header(Cloud Coverage)] _CloudDistanceMap ("Cloud Distance Map", 2D) = "white" { }
_CloudCoverageNoiseScale ("Cloud Coverage Noise Scale", Range(0, 0.5)) = 0.1
_CloudCoverageSmoothness ("Cloud Coverage Smoothness", Range(0, 1)) = 0.2
[Header(Cloud Smoothness)] _CloudSmoothnessNoiseScale ("Cloud Smoothness Noise Scale", Range(0, 0.5)) = 0.2
[Header(Cloud Shadow)] _CloudShadowSmoothness ("Cloud Shadow Smoothness", Range(0, 1)) = 0.2
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 51061
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _PerlineWorleyNoiseTex;
uniform sampler2D _CloudDistanceMap;
uniform highp float _CloudCoverageSmoothness;
uniform mediump float _CloudShadowSmoothness;
uniform highp float _CloudCoverage;
uniform highp float _CloudCoverageRemapped;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump float cloudShadow_1;
  mediump float cloudShadowDist_2;
  mediump float noiseLayer2_3;
  mediump float noiseLayer1_4;
  mediump float cloudCoverage_5;
  mediump float cloudCoverageDist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.xy).x;
  cloudCoverageDist_6 = tmpvar_7;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - _CloudCoverageRemapped);
  tmpvar_8 = max ((tmpvar_9 - _CloudCoverageSmoothness), 0.0);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((cloudCoverageDist_6 - tmpvar_8) / (
    min ((tmpvar_9 + _CloudCoverageSmoothness), 1.0)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  cloudCoverage_5 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.xy).w * 0.7);
  noiseLayer1_4 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.zw).w - 0.5);
  noiseLayer2_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp ((clamp (
    (cloudCoverage_5 + noiseLayer1_4)
  , 0.0, 1.0) + (
    sign(noiseLayer2_3)
   * 
    (noiseLayer2_3 * noiseLayer2_3)
  )), 0.0, 1.0);
  cloudCoverage_5 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp ((tmpvar_14 / 0.8), 0.0, 1.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD2.xy);
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.zw).y;
  cloudShadowDist_2 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max ((_CloudCoverage - _CloudShadowSmoothness), 0.0);
  highp float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((cloudShadowDist_2 - tmpvar_18) / (
    min ((_CloudCoverage + _CloudShadowSmoothness), 1.0)
   - tmpvar_18)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  cloudShadow_1 = tmpvar_19;
  cloudShadow_1 = (1.0 - (noiseLayer1_4 * (1.0 - cloudShadow_1)));
  mediump vec4 tmpvar_21;
  tmpvar_21.x = tmpvar_14;
  tmpvar_21.y = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  tmpvar_21.z = min (((
    (1.0 - tmpvar_14)
   * tmpvar_16.w) * 3.0), 1.0);
  tmpvar_21.w = cloudShadow_1;
  gl_FragData[0] = tmpvar_21;
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
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _PerlineWorleyNoiseTex;
uniform sampler2D _CloudDistanceMap;
uniform highp float _CloudCoverageSmoothness;
uniform mediump float _CloudShadowSmoothness;
uniform highp float _CloudCoverage;
uniform highp float _CloudCoverageRemapped;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump float cloudShadow_1;
  mediump float cloudShadowDist_2;
  mediump float noiseLayer2_3;
  mediump float noiseLayer1_4;
  mediump float cloudCoverage_5;
  mediump float cloudCoverageDist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.xy).x;
  cloudCoverageDist_6 = tmpvar_7;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - _CloudCoverageRemapped);
  tmpvar_8 = max ((tmpvar_9 - _CloudCoverageSmoothness), 0.0);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((cloudCoverageDist_6 - tmpvar_8) / (
    min ((tmpvar_9 + _CloudCoverageSmoothness), 1.0)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  cloudCoverage_5 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.xy).w * 0.7);
  noiseLayer1_4 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.zw).w - 0.5);
  noiseLayer2_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp ((clamp (
    (cloudCoverage_5 + noiseLayer1_4)
  , 0.0, 1.0) + (
    sign(noiseLayer2_3)
   * 
    (noiseLayer2_3 * noiseLayer2_3)
  )), 0.0, 1.0);
  cloudCoverage_5 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp ((tmpvar_14 / 0.8), 0.0, 1.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD2.xy);
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.zw).y;
  cloudShadowDist_2 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max ((_CloudCoverage - _CloudShadowSmoothness), 0.0);
  highp float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((cloudShadowDist_2 - tmpvar_18) / (
    min ((_CloudCoverage + _CloudShadowSmoothness), 1.0)
   - tmpvar_18)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  cloudShadow_1 = tmpvar_19;
  cloudShadow_1 = (1.0 - (noiseLayer1_4 * (1.0 - cloudShadow_1)));
  mediump vec4 tmpvar_21;
  tmpvar_21.x = tmpvar_14;
  tmpvar_21.y = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  tmpvar_21.z = min (((
    (1.0 - tmpvar_14)
   * tmpvar_16.w) * 3.0), 1.0);
  tmpvar_21.w = cloudShadow_1;
  gl_FragData[0] = tmpvar_21;
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
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _PerlineWorleyNoiseTex;
uniform sampler2D _CloudDistanceMap;
uniform highp float _CloudCoverageSmoothness;
uniform mediump float _CloudShadowSmoothness;
uniform highp float _CloudCoverage;
uniform highp float _CloudCoverageRemapped;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump float cloudShadow_1;
  mediump float cloudShadowDist_2;
  mediump float noiseLayer2_3;
  mediump float noiseLayer1_4;
  mediump float cloudCoverage_5;
  mediump float cloudCoverageDist_6;
  lowp float tmpvar_7;
  tmpvar_7 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.xy).x;
  cloudCoverageDist_6 = tmpvar_7;
  highp float tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (1.0 - _CloudCoverageRemapped);
  tmpvar_8 = max ((tmpvar_9 - _CloudCoverageSmoothness), 0.0);
  highp float tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = clamp (((cloudCoverageDist_6 - tmpvar_8) / (
    min ((tmpvar_9 + _CloudCoverageSmoothness), 1.0)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_10 = (tmpvar_11 * (tmpvar_11 * (3.0 - 
    (2.0 * tmpvar_11)
  )));
  cloudCoverage_5 = tmpvar_10;
  lowp float tmpvar_12;
  tmpvar_12 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.xy).w * 0.7);
  noiseLayer1_4 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD1.zw).w - 0.5);
  noiseLayer2_3 = tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp ((clamp (
    (cloudCoverage_5 + noiseLayer1_4)
  , 0.0, 1.0) + (
    sign(noiseLayer2_3)
   * 
    (noiseLayer2_3 * noiseLayer2_3)
  )), 0.0, 1.0);
  cloudCoverage_5 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp ((tmpvar_14 / 0.8), 0.0, 1.0);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_PerlineWorleyNoiseTex, xlv_TEXCOORD2.xy);
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_CloudDistanceMap, xlv_TEXCOORD0.zw).y;
  cloudShadowDist_2 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = max ((_CloudCoverage - _CloudShadowSmoothness), 0.0);
  highp float tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = clamp (((cloudShadowDist_2 - tmpvar_18) / (
    min ((_CloudCoverage + _CloudShadowSmoothness), 1.0)
   - tmpvar_18)), 0.0, 1.0);
  tmpvar_19 = (tmpvar_20 * (tmpvar_20 * (3.0 - 
    (2.0 * tmpvar_20)
  )));
  cloudShadow_1 = tmpvar_19;
  cloudShadow_1 = (1.0 - (noiseLayer1_4 * (1.0 - cloudShadow_1)));
  mediump vec4 tmpvar_21;
  tmpvar_21.x = tmpvar_14;
  tmpvar_21.y = (tmpvar_15 * (tmpvar_15 * (3.0 - 
    (2.0 * tmpvar_15)
  )));
  tmpvar_21.z = min (((
    (1.0 - tmpvar_14)
   * tmpvar_16.w) * 3.0), 1.0);
  tmpvar_21.w = cloudShadow_1;
  gl_FragData[0] = tmpvar_21;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FixedWeatherMap;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_FixedWeatherMap, xlv_TEXCOORD2.zw);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FixedWeatherMap;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_FixedWeatherMap, xlv_TEXCOORD2.zw);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _CloudCoverageNoiseScale;
uniform highp float _CloudSmoothnessNoiseScale;
uniform highp vec2 _CloudDirection;
uniform highp vec2 _CloudCoverageRotateDirection;
uniform highp float _CloudCoverageElapsedTime;
uniform highp vec2 _CloudShadowStretch;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy - 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = _CloudCoverageRotateDirection.y;
  tmpvar_6.y = -(_CloudCoverageRotateDirection.x);
  highp vec2 tmpvar_7;
  tmpvar_7.x = dot (tmpvar_6, tmpvar_5);
  tmpvar_7.y = dot (_CloudCoverageRotateDirection, tmpvar_5);
  tmpvar_1.xy = (tmpvar_7 + 0.5);
  tmpvar_1.zw = ((tmpvar_5 * _CloudShadowStretch) + 0.5);
  highp vec2 tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = _CloudDirection.y;
  tmpvar_9.y = -(_CloudDirection.x);
  highp vec2 tmpvar_10;
  tmpvar_10.x = dot (tmpvar_9, tmpvar_5);
  tmpvar_10.y = dot (_CloudDirection, tmpvar_5);
  tmpvar_8 = (tmpvar_10 + 0.5);
  tmpvar_2.xy = ((tmpvar_8 * _CloudCoverageNoiseScale) + _CloudCoverageElapsedTime);
  tmpvar_2.zw = (((tmpvar_8 * _CloudCoverageNoiseScale) * 5.0) + (_CloudCoverageElapsedTime * 2.0));
  tmpvar_3.xy = ((tmpvar_8 * _CloudSmoothnessNoiseScale) + (_CloudCoverageElapsedTime * vec2(0.6, 1.2)));
  tmpvar_3.zw = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FixedWeatherMap;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_FixedWeatherMap, xlv_TEXCOORD2.zw);
  tmpvar_1 = tmpvar_2;
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
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_FIXED_WEATHER_MAP" }
""
}
}
}
}
}