//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Screen/Blur" {
Properties {
}
SubShader {
 Pass {
  Name "BLUR VERTICAL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 43493
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _BlurScale;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  highp vec2 scale_2;
  scale_2 = (vec2(0.0, 1.0) * _BlurScale);
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_3 = 0; i_3 < _BlurTaps; i_3++) {
    lowp vec4 tmpvar_5;
    highp vec2 P_6;
    P_6 = (uv_1 + (_BlurOffsets[i_3].xy * scale_2));
    tmpvar_5 = texture2D (_MainTex, P_6);
    sum_4 = (sum_4 + (tmpvar_5 * _BlurWeights[(i_3 * 2)]));
    lowp vec4 tmpvar_7;
    highp vec2 P_8;
    P_8 = (uv_1 + (_BlurOffsets[i_3].zw * scale_2));
    tmpvar_7 = texture2D (_MainTex, P_8);
    sum_4 = (sum_4 + (tmpvar_7 * _BlurWeights[(
      (i_3 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _BlurScale;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  highp vec2 scale_2;
  scale_2 = (vec2(0.0, 1.0) * _BlurScale);
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_3 = 0; i_3 < _BlurTaps; i_3++) {
    lowp vec4 tmpvar_5;
    highp vec2 P_6;
    P_6 = (uv_1 + (_BlurOffsets[i_3].xy * scale_2));
    tmpvar_5 = texture2D (_MainTex, P_6);
    sum_4 = (sum_4 + (tmpvar_5 * _BlurWeights[(i_3 * 2)]));
    lowp vec4 tmpvar_7;
    highp vec2 P_8;
    P_8 = (uv_1 + (_BlurOffsets[i_3].zw * scale_2));
    tmpvar_7 = texture2D (_MainTex, P_8);
    sum_4 = (sum_4 + (tmpvar_7 * _BlurWeights[(
      (i_3 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _BlurScale;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  highp vec2 scale_2;
  scale_2 = (vec2(0.0, 1.0) * _BlurScale);
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_3 = 0; i_3 < _BlurTaps; i_3++) {
    lowp vec4 tmpvar_5;
    highp vec2 P_6;
    P_6 = (uv_1 + (_BlurOffsets[i_3].xy * scale_2));
    tmpvar_5 = texture2D (_MainTex, P_6);
    sum_4 = (sum_4 + (tmpvar_5 * _BlurWeights[(i_3 * 2)]));
    lowp vec4 tmpvar_7;
    highp vec2 P_8;
    P_8 = (uv_1 + (_BlurOffsets[i_3].zw * scale_2));
    tmpvar_7 = texture2D (_MainTex, P_8);
    sum_4 = (sum_4 + (tmpvar_7 * _BlurWeights[(
      (i_3 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_4;
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
 Pass {
  Name "BLUR HORIZONTAL"
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 67897
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  mediump vec4 sum_3;
  sum_3 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_2 = 0; i_2 < _BlurTaps; i_2++) {
    lowp vec4 tmpvar_4;
    highp vec2 P_5;
    P_5 = (uv_1 + (_BlurOffsets[i_2].xy * vec2(1.0, 0.0)));
    tmpvar_4 = texture2D (_MainTex, P_5);
    sum_3 = (sum_3 + (tmpvar_4 * _BlurWeights[(i_2 * 2)]));
    lowp vec4 tmpvar_6;
    highp vec2 P_7;
    P_7 = (uv_1 + (_BlurOffsets[i_2].zw * vec2(1.0, 0.0)));
    tmpvar_6 = texture2D (_MainTex, P_7);
    sum_3 = (sum_3 + (tmpvar_6 * _BlurWeights[(
      (i_2 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  mediump vec4 sum_3;
  sum_3 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_2 = 0; i_2 < _BlurTaps; i_2++) {
    lowp vec4 tmpvar_4;
    highp vec2 P_5;
    P_5 = (uv_1 + (_BlurOffsets[i_2].xy * vec2(1.0, 0.0)));
    tmpvar_4 = texture2D (_MainTex, P_5);
    sum_3 = (sum_3 + (tmpvar_4 * _BlurWeights[(i_2 * 2)]));
    lowp vec4 tmpvar_6;
    highp vec2 P_7;
    P_7 = (uv_1 + (_BlurOffsets[i_2].zw * vec2(1.0, 0.0)));
    tmpvar_6 = texture2D (_MainTex, P_7);
    sum_3 = (sum_3 + (tmpvar_6 * _BlurWeights[(
      (i_2 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp int _BlurTaps;
uniform highp float _BlurWeights[16];
uniform highp vec4 _BlurOffsets[8];
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  uv_1 = xlv_TEXCOORD0;
  mediump vec4 sum_3;
  sum_3 = vec4(0.0, 0.0, 0.0, 0.0);
  for (highp int i_2 = 0; i_2 < _BlurTaps; i_2++) {
    lowp vec4 tmpvar_4;
    highp vec2 P_5;
    P_5 = (uv_1 + (_BlurOffsets[i_2].xy * vec2(1.0, 0.0)));
    tmpvar_4 = texture2D (_MainTex, P_5);
    sum_3 = (sum_3 + (tmpvar_4 * _BlurWeights[(i_2 * 2)]));
    lowp vec4 tmpvar_6;
    highp vec2 P_7;
    P_7 = (uv_1 + (_BlurOffsets[i_2].zw * vec2(1.0, 0.0)));
    tmpvar_6 = texture2D (_MainTex, P_7);
    sum_3 = (sum_3 + (tmpvar_6 * _BlurWeights[(
      (i_2 * 2)
     + 1)]));
  };
  gl_FragData[0] = sum_3;
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
}