//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/HUD Ring" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_Texture1 ("Texture 1", 2D) = "white" { }
_Texture1_Alpha ("Texture 1 Alpha", 2D) = "white" { }
_Texture2 ("Texture 2", 2D) = "white" { }
_Texture2_Alpha ("Texture 2 Alpha", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 50367
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0);
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1);
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0);
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1);
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0);
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1);
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _EmissionScaler;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump vec4 texColor2_2;
  mediump vec4 texColor1_3;
  lowp vec4 tmpvar_4;
  tmpvar_4.xyz = texture2D (_Texture1, xlv_TEXCOORD0).xyz;
  tmpvar_4.w = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  texColor1_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5.xyz = texture2D (_Texture2, xlv_TEXCOORD1).xyz;
  tmpvar_5.w = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  texColor2_2 = tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_6 = ((2.0 * _TintColor) * mix (texColor1_3, texColor2_2, texColor2_2.wwww));
  color_1.w = tmpvar_6.w;
  color_1.xyz = (tmpvar_6.xyz * _EmissionScaler);
  gl_FragData[0] = color_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
}
}
 Pass {
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 87545
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0).w;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1).w;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0).w;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1).w;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _Texture1;
uniform sampler2D _Texture2;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1, xlv_TEXCOORD0).w;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2, xlv_TEXCOORD1).w;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).x;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).x;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).y;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).y;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _Texture1_ST;
uniform highp vec4 _Texture2_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _Texture1_ST.xy) + _Texture1_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _Texture2_ST.xy) + _Texture2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _Texture1_Alpha;
uniform sampler2D _Texture2_Alpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  mediump float alpha2_2;
  mediump float alpha1_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_Texture1_Alpha, xlv_TEXCOORD0).z;
  alpha1_3 = tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_Texture2_Alpha, xlv_TEXCOORD1).z;
  alpha2_2 = tmpvar_5;
  mediump float x_6;
  x_6 = (mix (alpha1_3, alpha2_2, alpha2_2) - 0.01);
  if ((x_6 < 0.0)) {
    discard;
  };
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_ORIG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_R" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_G" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "ALPHA_B" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "ALPHA_B" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ShaderEditorBase"
}