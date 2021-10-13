//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Toon/Base_01" {
Properties {
_Color ("Main Color", Color) = (0.5,0.5,0.5,1)
_EmissionColor ("Emmisive Color", Color) = (0.5,0.5,0.5,1)
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_Outline ("Outline Width", Float) = 0.02
_SpecMulti ("Specular Multiply", Float) = 1
_Shininess ("Shininess", Float) = 2
_FadeDistance ("Fade Start Distance", Float) = 0.5
_FadeOffset ("Fade Start Offset", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_Ramp ("Toon Ramp (RGB)", 2D) = "white" { }
_SpecRamp ("Specular Ramp (RGB)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 22851
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, tmpvar_7.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp float tmpvar_12;
  tmpvar_12 = pow (max (dot (tmpvar_9, 
    normalize((tmpvar_7.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_12;
  if ((d_2 <= 0.5)) {
    s_1 = 0.025;
  };
  mediump vec2 tmpvar_13;
  tmpvar_13.x = s_1;
  tmpvar_13.y = s_1;
  tmpvar_3.w = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _Color);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, tmpvar_7.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp float tmpvar_12;
  tmpvar_12 = pow (max (dot (tmpvar_9, 
    normalize((tmpvar_7.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_12;
  if ((d_2 <= 0.5)) {
    s_1 = 0.025;
  };
  mediump vec2 tmpvar_13;
  tmpvar_13.x = s_1;
  tmpvar_13.y = s_1;
  tmpvar_3.w = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _Color);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
  gl_FragData[0] = outColor_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
uniform highp float _Shininess;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump float s_1;
  mediump float d_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_7;
  tmpvar_7 = normalize(_WorldSpaceLightPos0);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesNormal));
  highp float tmpvar_10;
  tmpvar_10 = ((dot (tmpvar_9, tmpvar_7.xyz) * 0.4975) + 0.5);
  d_2 = tmpvar_10;
  mediump vec2 tmpvar_11;
  tmpvar_11.x = d_2;
  tmpvar_11.y = d_2;
  highp float tmpvar_12;
  tmpvar_12 = pow (max (dot (tmpvar_9, 
    normalize((tmpvar_7.xyz + normalize((_WorldSpaceCameraPos - 
      (unity_ObjectToWorld * _glesVertex)
    .xyz))))
  ), 0.0), _Shininess);
  s_1 = tmpvar_12;
  if ((d_2 <= 0.5)) {
    s_1 = 0.025;
  };
  mediump vec2 tmpvar_13;
  tmpvar_13.x = s_1;
  tmpvar_13.y = s_1;
  tmpvar_3.w = min (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_11;
  xlv_TEXCOORD2 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _Ramp;
uniform sampler2D _SpecRamp;
uniform highp float _SpecMulti;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 ramp_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _Color);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Ramp, xlv_TEXCOORD1).xyz;
  ramp_1 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_SpecRamp, xlv_TEXCOORD2);
  outColor_2.xyz = ((tmpvar_4.xyz * (
    (tmpvar_6.xyz * _SpecMulti)
   + 1.0)) * ramp_1);
  outColor_2.w = (tmpvar_4.w * xlv_COLOR0.w);
  outColor_2.w = clamp (outColor_2.w, 0.0, 1.0);
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
  Name "OUTLINE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 95114
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    normalize((tmpvar_9 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1.xyz = xlv_COLOR0.xyz;
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    normalize((tmpvar_9 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1.xyz = xlv_COLOR0.xyz;
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _OutlineColor;
uniform highp float _Outline;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5.zw = tmpvar_7.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = tmpvar_2.xyz;
  tmpvar_9[1] = tmpvar_3.xyz;
  tmpvar_9[2] = tmpvar_4.xyz;
  highp mat2 tmpvar_10;
  tmpvar_10[0] = glstate_matrix_projection[0].xy;
  tmpvar_10[1] = glstate_matrix_projection[1].xy;
  tmpvar_5.xy = (tmpvar_7.xy + ((tmpvar_10 * 
    normalize((tmpvar_9 * _glesNormal))
  .xy) * _Outline));
  tmpvar_6.xyz = _OutlineColor.xyz;
  tmpvar_6.w = (_OutlineColor.w * min ((
    ((-((
      (unity_MatrixV * unity_ObjectToWorld)
     * _glesVertex).z) - _ProjectionParams.y) - _FadeOffset)
   / _FadeDistance), 1.0));
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
varying highp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 outColor_1;
  outColor_1.xyz = xlv_COLOR0.xyz;
  outColor_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
Fallback "Diffuse"
}