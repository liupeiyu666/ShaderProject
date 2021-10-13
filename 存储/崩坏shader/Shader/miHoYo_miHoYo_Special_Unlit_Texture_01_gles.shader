//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Unlit/Texture_01" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_FadeDistance ("Fade Start Distance", Float) = 0.5
_FadeOffset ("Fade Start Offset", Float) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 10998
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.w = min (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 text_C_Color_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  text_C_Color_1 = tmpvar_3;
  outColor_2.xyz = text_C_Color_1.xyz;
  outColor_2.w = (text_C_Color_1.w * xlv_COLOR0.w);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.w = min (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 text_C_Color_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  text_C_Color_1 = tmpvar_3;
  outColor_2.xyz = text_C_Color_1.xyz;
  outColor_2.w = (text_C_Color_1.w * xlv_COLOR0.w);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainTex_ST;
uniform highp float _FadeDistance;
uniform highp float _FadeOffset;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xyz = vec3(0.0, 0.0, 0.0);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.w = min (((
    (-(((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).z) - _ProjectionParams.y)
   - _FadeOffset) / _FadeDistance), 1.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 text_C_Color_1;
  highp vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  text_C_Color_1 = tmpvar_3;
  outColor_2.xyz = text_C_Color_1.xyz;
  outColor_2.w = (text_C_Color_1.w * xlv_COLOR0.w);
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
}
Fallback "Diffuse"
}