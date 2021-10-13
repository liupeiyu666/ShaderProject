//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/HUD Circle" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_TintColor ("TintColor", Color) = (1,1,1,1)
_OutSide ("OutSide", Range(0, 10)) = 0
_Inside ("Inside", Range(0, 1)) = 0
_texcoord ("", 2D) = "white" { }
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+3" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 32367
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Inside;
uniform highp float _OutSide;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_glesVertex.xyz * ((_Inside * 3.56) - 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesVertex.xyz * _OutSide);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_2 * 
    (1.0 - _glesColor)
  ) + (tmpvar_3 * _glesColor)).xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TintColor;
uniform mediump float _EmissionScaler;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode23_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode23_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = tex2DNode23_3.w;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode23_3 * _TintColor) * _EmissionScaler).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = aseOutColor_1;
  tmpvar_8.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_8;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Inside;
uniform highp float _OutSide;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_glesVertex.xyz * ((_Inside * 3.56) - 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesVertex.xyz * _OutSide);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_2 * 
    (1.0 - _glesColor)
  ) + (tmpvar_3 * _glesColor)).xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TintColor;
uniform mediump float _EmissionScaler;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode23_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode23_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = tex2DNode23_3.w;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode23_3 * _TintColor) * _EmissionScaler).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = aseOutColor_1;
  tmpvar_8.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_8;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Inside;
uniform highp float _OutSide;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 0.0;
  tmpvar_2.xyz = (_glesVertex.xyz * ((_Inside * 3.56) - 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesVertex.xyz * _OutSide);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_2 * 
    (1.0 - _glesColor)
  ) + (tmpvar_3 * _glesColor)).xyz);
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _TintColor;
uniform mediump float _EmissionScaler;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode23_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_4);
  tex2DNode23_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = tex2DNode23_3.w;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode23_3 * _TintColor) * _EmissionScaler).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = aseOutColor_1;
  tmpvar_8.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_8;
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
CustomEditor "MoleMole.ShaderEditorBase"
}