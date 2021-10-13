//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Blind_Billboard" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
_ScaleTime ("Scale Time", Range(0, 1)) = 1
_UMin ("U Min", Float) = 0
_UMax ("U Max", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 30410
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform mediump float _ScaleTime;
uniform mediump float _UMin;
uniform mediump float _UMax;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  mediump vec4 tmpvar_2;
  bool tmpvar_3;
  tmpvar_3 = bool(0);
  for (highp int i_4 = 0; i_4 < 20; i_4++) {
    highp float time_5;
    time_5 = _ScaleTime;
    highp float width_6;
    mediump float tmpvar_7;
    tmpvar_7 = (((_UMax - _UMin) / 2.0) / 20.0);
    width_6 = tmpvar_7;
    highp float tmpvar_8;
    tmpvar_8 = ((_UMin + (
      (float(i_4) * width_6)
     * 2.0)) + width_6);
    highp vec4 tmpvar_9;
    tmpvar_9.zw = vec2(0.0, 0.0);
    tmpvar_9.x = (tmpvar_8 - (width_6 * time_5));
    tmpvar_9.y = (tmpvar_8 + (width_6 * time_5));
    if ((((tmpvar_9.x + _MainTex_ST.z) <= tmpvar_1.x) && (tmpvar_1.x <= (tmpvar_9.y + _MainTex_ST.z)))) {
      mediump vec4 outColor_10;
      lowp vec4 tmpvar_11;
      tmpvar_11 = texture2D (_MainTex, tmpvar_1);
      outColor_10 = tmpvar_11;
      outColor_10.xyz = mix (outColor_10.xyz, vec3(dot (outColor_10.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
      tmpvar_2 = outColor_10;
      tmpvar_3 = bool(1);
      break;
    };
  };
  if (!(tmpvar_3)) {
    discard;
    lowp vec4 tmpvar_12;
    tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
    tmpvar_2 = tmpvar_12;
    tmpvar_3 = bool(1);
  };
  gl_FragData[0] = tmpvar_2;
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
}
}
}
}