//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/VR/InsideSphere Unlit (stereo+fog) Stereo UV" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
[Toggle(STEREO_DEBUG)] _StereoDebug ("Stereo Debug Tinting", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Background" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 48119
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  lowp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  lowp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  col_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_COLOR);
  lowp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  col_1 = (col_1 * xlv_COLOR);
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  col_1 = (col_1 * xlv_COLOR);
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (tmpvar_5) {
    tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_10;
    tmpvar_10.x = (1.0 - tmpvar_1.x);
    tmpvar_10.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_10;
  } else {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    highp vec2 tmpvar_11;
    tmpvar_11.x = (1.0 - tmpvar_1.x);
    tmpvar_11.y = tmpvar_1.y;
    tmpvar_1 = tmpvar_11;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  mediump vec3 tmpvar_3;
  mediump vec3 col_4;
  col_4 = tmpvar_2.xyz;
  tmpvar_3 = (col_4 * ((col_4 * 
    ((col_4 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = tmpvar_3;
  col_1 = (col_1 * xlv_COLOR);
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "STEREO_DEBUG" }
""
}
}
}
}
}