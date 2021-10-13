//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Stencil_Mask_SSDF" {
Properties {
_MaskTex ("MaskTex", 2D) = "white" { }
_Stencil ("Stencil Value", Float) = 0
_Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_Color0 ("MainColor", Color) = (1,1,1,1)
_Intensity ("Intensity", Float) = 1
_clip ("Clip", Vector) = (0,1,0,0)
}
SubShader {
 Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
 Pass {
  Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
  ZWrite Off
  GpuProgramID 77375
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = clamp (_glesColor, 0.0, 1.0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
}


#endif
#ifdef FRAGMENT
varying lowp vec4 xlv_COLOR0;
void main ()
{
  gl_FragData[0] = xlv_COLOR0;
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
  Tags { "QUEUE" = "Geometry" "RenderType" = "TransparentCutout" }
  ZWrite Off
  GpuProgramID 5348
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform mediump float _Cutoff;
uniform highp vec4 _Color0;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec3 aseOutColor_4;
  mediump vec3 wnormal_5;
  highp vec4 encode_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CustomDepthNormalsTexture, tmpvar_7);
  encode_6 = tmpvar_8;
  highp vec3 n_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((encode_6.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (2.0 / dot (tmpvar_10, tmpvar_10));
  n_9.xy = (tmpvar_11 * tmpvar_10.xy);
  n_9.z = (tmpvar_11 - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_6.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (unity_CameraToWorld * tmpvar_12).xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_WorldToObject * tmpvar_13).xyz;
  highp vec3 x_15;
  x_15 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_14));
  bvec3 tmpvar_16;
  tmpvar_16 = lessThan (x_15, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_16)) {
    discard;
  };
  highp mat3 tmpvar_17;
  tmpvar_17[0] = tmpvar_1.xyz;
  tmpvar_17[1] = tmpvar_2.xyz;
  tmpvar_17[2] = tmpvar_3.xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((normalize(
    (tmpvar_17 * normalize(n_9))
  ) * 2.0) - 1.0);
  wnormal_5 = tmpvar_18;
  mediump float x_19;
  x_19 = (dot (wnormal_5, xlv_TEXCOORD3) - 1.0);
  if ((x_19 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = (((tmpvar_14.xz + vec2(0.5, 0.5)) * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MaskTex, tmpvar_20);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz * _Color0.xyz);
  aseOutColor_4 = tmpvar_22;
  mediump float x_23;
  x_23 = (aseOutColor_4.x - _Cutoff);
  if ((x_23 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (aseOutColor_4 * _Intensity);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform mediump float _Cutoff;
uniform highp vec4 _Color0;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec3 aseOutColor_4;
  mediump vec3 wnormal_5;
  highp vec4 encode_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CustomDepthNormalsTexture, tmpvar_7);
  encode_6 = tmpvar_8;
  highp vec3 n_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((encode_6.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (2.0 / dot (tmpvar_10, tmpvar_10));
  n_9.xy = (tmpvar_11 * tmpvar_10.xy);
  n_9.z = (tmpvar_11 - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_6.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (unity_CameraToWorld * tmpvar_12).xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_WorldToObject * tmpvar_13).xyz;
  highp vec3 x_15;
  x_15 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_14));
  bvec3 tmpvar_16;
  tmpvar_16 = lessThan (x_15, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_16)) {
    discard;
  };
  highp mat3 tmpvar_17;
  tmpvar_17[0] = tmpvar_1.xyz;
  tmpvar_17[1] = tmpvar_2.xyz;
  tmpvar_17[2] = tmpvar_3.xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((normalize(
    (tmpvar_17 * normalize(n_9))
  ) * 2.0) - 1.0);
  wnormal_5 = tmpvar_18;
  mediump float x_19;
  x_19 = (dot (wnormal_5, xlv_TEXCOORD3) - 1.0);
  if ((x_19 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = (((tmpvar_14.xz + vec2(0.5, 0.5)) * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MaskTex, tmpvar_20);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz * _Color0.xyz);
  aseOutColor_4 = tmpvar_22;
  mediump float x_23;
  x_23 = (aseOutColor_4.x - _Cutoff);
  if ((x_23 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (aseOutColor_4 * _Intensity);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _clip;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((unity_MatrixV * (unity_ObjectToWorld * tmpvar_7)).xyz * vec3(-1.0, -1.0, 1.0));
  xlv_TEXCOORD3 = (tmpvar_8 * _clip.xyz);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraToWorld;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform sampler2D _CustomDepthNormalsTexture;
uniform mediump float _DepthScaleValue;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform mediump float _Cutoff;
uniform highp vec4 _Color0;
uniform highp float _Intensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_1.x = unity_MatrixMV[0].x;
  tmpvar_1.y = unity_MatrixMV[1].x;
  tmpvar_1.z = unity_MatrixMV[2].x;
  tmpvar_1.w = unity_MatrixMV[3].x;
  tmpvar_2.x = unity_MatrixMV[0].y;
  tmpvar_2.y = unity_MatrixMV[1].y;
  tmpvar_2.z = unity_MatrixMV[2].y;
  tmpvar_2.w = unity_MatrixMV[3].y;
  tmpvar_3.x = unity_MatrixMV[0].z;
  tmpvar_3.y = unity_MatrixMV[1].z;
  tmpvar_3.z = unity_MatrixMV[2].z;
  tmpvar_3.w = unity_MatrixMV[3].z;
  mediump vec3 aseOutColor_4;
  mediump vec3 wnormal_5;
  highp vec4 encode_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD1.xy / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_CustomDepthNormalsTexture, tmpvar_7);
  encode_6 = tmpvar_8;
  highp vec3 n_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((encode_6.xyz * vec3(3.5554, 3.5554, 0.0)) + vec3(-1.7777, -1.7777, 1.0));
  highp float tmpvar_11;
  tmpvar_11 = (2.0 / dot (tmpvar_10, tmpvar_10));
  n_9.xy = (tmpvar_11 * tmpvar_10.xy);
  n_9.z = (tmpvar_11 - 1.0);
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = ((xlv_TEXCOORD2 * (_ProjectionParams.z / xlv_TEXCOORD2.z)) * (dot (encode_6.zw, vec2(1.0, 0.003921569)) * _DepthScaleValue));
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = (unity_CameraToWorld * tmpvar_12).xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_WorldToObject * tmpvar_13).xyz;
  highp vec3 x_15;
  x_15 = (vec3(0.5, 0.5, 0.5) - abs(tmpvar_14));
  bvec3 tmpvar_16;
  tmpvar_16 = lessThan (x_15, vec3(0.0, 0.0, 0.0));
  if (any(tmpvar_16)) {
    discard;
  };
  highp mat3 tmpvar_17;
  tmpvar_17[0] = tmpvar_1.xyz;
  tmpvar_17[1] = tmpvar_2.xyz;
  tmpvar_17[2] = tmpvar_3.xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((normalize(
    (tmpvar_17 * normalize(n_9))
  ) * 2.0) - 1.0);
  wnormal_5 = tmpvar_18;
  mediump float x_19;
  x_19 = (dot (wnormal_5, xlv_TEXCOORD3) - 1.0);
  if ((x_19 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = (((tmpvar_14.xz + vec2(0.5, 0.5)) * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MaskTex, tmpvar_20);
  highp vec3 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xyz * _Color0.xyz);
  aseOutColor_4 = tmpvar_22;
  mediump float x_23;
  x_23 = (aseOutColor_4.x - _Cutoff);
  if ((x_23 < 0.0)) {
    discard;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (aseOutColor_4 * _Intensity);
  gl_FragData[0] = tmpvar_24;
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