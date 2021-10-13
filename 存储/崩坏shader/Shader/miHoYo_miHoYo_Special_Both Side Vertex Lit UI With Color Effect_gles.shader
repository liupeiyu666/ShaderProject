//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Both Side Vertex Lit UI With Color Effect" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_Emission ("Emmisive Color", Color) = (0,0,0,0)
_MainTex ("Base (RGB) Trans. (Alpha)", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "Vertex" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 1583
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
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
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform lowp vec4 glstate_lightmodel_ambient;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _Color;
uniform mediump vec4 _Emission;
uniform highp vec4 _MainTex_ST;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (_Emission.xyz + (_Color.xyz * glstate_lightmodel_ambient.xyz));
  color_1.w = 1.0;
  lowp vec4 tmpvar_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = clamp (color_1, 0.0, 1.0);
  tmpvar_2 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.xyz = (tmpvar_2 * xlv_COLOR0).xyz;
  col_1.xyz = (col_1 * 2.0).xyz;
  col_1.w = (tmpvar_2.w * _Color.w);
  gl_FragData[0] = col_1;
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
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
}
}
}
}