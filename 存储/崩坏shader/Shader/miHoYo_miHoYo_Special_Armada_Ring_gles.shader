//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Armada/Ring" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Main Texture", 2D) = "white" { }
_TransparentTex ("Transparent Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle] _PerspectiveDeformation ("Perspective Deformation", Float) = 0
_Vanishpoint ("Vanishpoint Position (Local Space)", Vector) = (0,0,10000,0)
_InvariantPlaneZ ("Invariant Plane Z Position (Local Space)", Float) = 0
_ScaleInZ ("Scale In Z", Range(0.01, 2)) = 1
_RotatePivot ("Rotate Pivate (Local Space)", Vector) = (0,0,0,0)
_RotateSpeed ("Rotate Speed (Radian per Second)", Float) = 0
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 25572
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 128426
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
uniform highp vec3 _RotatePivot;
uniform highp float _RotateSpeed;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  highp vec3 vert_3;
  highp float theta_4;
  theta_4 = (_Time.y * _RotateSpeed);
  highp float tmpvar_5;
  tmpvar_5 = sin(theta_4);
  highp float tmpvar_6;
  tmpvar_6 = cos(theta_4);
  vert_3 = (_glesVertex.xyz - _RotatePivot);
  highp float tmpvar_7;
  tmpvar_7 = ((-(tmpvar_5) * vert_3.z) + (tmpvar_6 * vert_3.x));
  vert_3.z = ((tmpvar_6 * vert_3.z) + (tmpvar_5 * vert_3.x));
  vert_3.x = tmpvar_7;
  tmpvar_1.xyz = (vert_3 + _RotatePivot);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_8;
    highp vec3 tmpvar_9;
    tmpvar_9 = (tmpvar_1.xyz - _Vanishpoint);
    posInPerp_8.z = tmpvar_9.z;
    posInPerp_8.xy = (tmpvar_9.xy * (tmpvar_9.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_8 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * mix (1.0, _EmissionScaler, mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  gl_FragData[0] = color_2;
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
  Name "CONSTANT_REPLACE_NOCUTOFF"
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 144203
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  gl_FragData[0] = color_1;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  gl_FragData[0] = color_1;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
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
}
}
}
Fallback "Diffuse"
}