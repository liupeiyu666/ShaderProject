//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/Util/Draw_Alpha" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_AlphaClip ("Alpha Clip", Float) = 0.01
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "None" }
  GpuProgramID 45784
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "NoneAlphaClip" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "NoneAlphaClip" }
  GpuProgramID 83560
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = 0.0;
  xlv_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_1 - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = 0.0;
  xlv_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_1 - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = 0.0;
  xlv_TEXCOORD2 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform mediump float _AlphaClip;
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  mediump float x_4;
  x_4 = (alpha_1 - _AlphaClip);
  if ((x_4 < 0.0)) {
    discard;
  };
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "Simple" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Simple" }
  GpuProgramID 188826
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
  LOD 200
  Tags { "OutlineType" = "Simple" }
  Cull Front
  GpuProgramID 233823
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  tmpvar_5 = o_15;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.001)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  tmpvar_5 = o_15;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.001)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixMV[0].xyz;
  tmpvar_8[1] = unity_MatrixMV[1].xyz;
  tmpvar_8[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_9.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(N_1);
  N_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * tmpvar_7);
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_10.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  highp float fadeOffset_12;
  fadeOffset_12 = _FadeOffset;
  highp float fadeDistance_13;
  fadeDistance_13 = _FadeDistance;
  highp float tmpvar_14;
  tmpvar_14 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_12) / fadeDistance_13), 0.0, 1.0);
  tmpvar_4.w = tmpvar_14;
  tmpvar_4.w = (tmpvar_4.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_17;
  tmpvar_17.x = tmpvar_16.x;
  tmpvar_17.y = (tmpvar_16.y * _ProjectionParams.x);
  o_15.xy = (tmpvar_17 + tmpvar_16.w);
  o_15.zw = tmpvar_3.zw;
  tmpvar_5 = o_15;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.001)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "Complex" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Complex" }
  GpuProgramID 318088
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  outColor_1.yzw = vec3(0.0, 0.0, 0.0);
  outColor_1.x = xlv_TEXCOORD1;
  gl_FragData[0] = outColor_1;
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
  LOD 200
  Tags { "OutlineType" = "Complex" }
  Cull Front
  GpuProgramID 381977
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_3.zw;
  tmpvar_5 = o_12;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.1)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_3.zw;
  tmpvar_5 = o_12;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.1)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
varying mediump vec4 xlv_COLOR0;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_6;
  tmpvar_6 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_MatrixMV[0].xyz;
  tmpvar_7[1] = unity_MatrixMV[1].xyz;
  tmpvar_7[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_8.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize(N_1);
  N_1 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_10));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_9.xy * tmpvar_11));
  tmpvar_4.xyz = _OutlineColor.xyz;
  tmpvar_4.w = 1.0;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  highp vec4 o_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = tmpvar_13.x;
  tmpvar_14.y = (tmpvar_13.y * _ProjectionParams.x);
  o_12.xy = (tmpvar_14 + tmpvar_13.w);
  o_12.zw = tmpvar_3.zw;
  tmpvar_5 = o_12;
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _AlphaWithoutOutLineTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float a2_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  outColor_2.x = 1.0;
  mediump vec2 P_3;
  P_3 = (xlv_TEXCOORD0.xy / xlv_TEXCOORD0.w);
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_AlphaWithoutOutLineTex, P_3).x;
  a2_1 = tmpvar_4;
  if ((a2_1 >= 0.1)) {
    outColor_2.x = a2_1;
  };
  gl_FragData[0] = outColor_2;
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
SubShader {
 LOD 200
 Tags { "OutlineType" = "TransparentDualFace" "QUEUE" = "Transparent" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "TransparentDualFace" "QUEUE" = "Transparent" }
  Cull Front
  GpuProgramID 425590
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
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
  LOD 200
  Tags { "OutlineType" = "TransparentDualFace" "QUEUE" = "Transparent" }
  GpuProgramID 509626
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump float _VertexAlphaFactor;
uniform mediump float _Opaqueness;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump float tmpvar_2;
  mediump vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  tmpvar_3 = o_6;
  highp float tmpvar_9;
  tmpvar_9 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  tmpvar_2 = ((tmpvar_9 * _Opaqueness) * _Color.w);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float alpha_1;
  mediump vec4 outColor_2;
  outColor_2.yzw = vec3(0.0, 0.0, 0.0);
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  alpha_1 = tmpvar_3;
  outColor_2.x = alpha_1;
  gl_FragData[0] = outColor_2;
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