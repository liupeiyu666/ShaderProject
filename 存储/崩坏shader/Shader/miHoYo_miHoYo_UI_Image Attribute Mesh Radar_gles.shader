//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/Image Attribute Mesh Radar" {
Properties {
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_Attribute1 ("Attribute 1", Float) = 0.25
_Attribute2 ("Attribute 2", Float) = 0.25
_Attribute3 ("Attribute 3", Float) = 0.25
_Attribute4 ("Attribute 4", Float) = 0.25
_Attribute5 ("Attribute 5", Float) = 0.25
_Attribute6 ("Attribute 6", Float) = 0.25
_LengthCorrection ("LengthCorrection", Float) = 1
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 46871
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
uniform highp float _LengthCorrection;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(greaterThanEqual (_glesColor, vec4(0.82, 0.82, 0.82, 0.82)));
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(greaterThanEqual (_glesColor, vec4(0.72, 0.72, 0.72, 0.72)));
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(greaterThanEqual (_glesColor, vec4(0.62, 0.62, 0.62, 0.62)));
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(greaterThanEqual (_glesColor, vec4(0.52, 0.52, 0.52, 0.52)));
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(greaterThanEqual (_glesColor, vec4(0.42, 0.42, 0.42, 0.42)));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesNormal * _LengthCorrection);
  tmpvar_7.xyz = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_8;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_8;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_8;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_8;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((((
      ((_Attribute1 + -1.0) * tmpvar_7)
     * tmpvar_2) + (
      ((_Attribute2 + -1.0) * tmpvar_9)
     * 
      (tmpvar_3 - tmpvar_2)
    )) + ((
      (_Attribute3 + -1.0)
     * tmpvar_10) * (tmpvar_4 - tmpvar_3))) + (((_Attribute4 + -1.0) * tmpvar_11) * (tmpvar_5 - tmpvar_4)))
   + 
    (((_Attribute5 + -1.0) * tmpvar_12) * (tmpvar_6 - tmpvar_5))
  ) + (
    ((_Attribute6 + -1.0) * tmpvar_13)
   * 
    (vec4(greaterThanEqual (_glesColor, vec4(0.32, 0.32, 0.32, 0.32))) - tmpvar_6)
  )).xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2);
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _MainColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
uniform highp float _LengthCorrection;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(greaterThanEqual (_glesColor, vec4(0.82, 0.82, 0.82, 0.82)));
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(greaterThanEqual (_glesColor, vec4(0.72, 0.72, 0.72, 0.72)));
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(greaterThanEqual (_glesColor, vec4(0.62, 0.62, 0.62, 0.62)));
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(greaterThanEqual (_glesColor, vec4(0.52, 0.52, 0.52, 0.52)));
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(greaterThanEqual (_glesColor, vec4(0.42, 0.42, 0.42, 0.42)));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesNormal * _LengthCorrection);
  tmpvar_7.xyz = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_8;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_8;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_8;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_8;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((((
      ((_Attribute1 + -1.0) * tmpvar_7)
     * tmpvar_2) + (
      ((_Attribute2 + -1.0) * tmpvar_9)
     * 
      (tmpvar_3 - tmpvar_2)
    )) + ((
      (_Attribute3 + -1.0)
     * tmpvar_10) * (tmpvar_4 - tmpvar_3))) + (((_Attribute4 + -1.0) * tmpvar_11) * (tmpvar_5 - tmpvar_4)))
   + 
    (((_Attribute5 + -1.0) * tmpvar_12) * (tmpvar_6 - tmpvar_5))
  ) + (
    ((_Attribute6 + -1.0) * tmpvar_13)
   * 
    (vec4(greaterThanEqual (_glesColor, vec4(0.32, 0.32, 0.32, 0.32))) - tmpvar_6)
  )).xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2);
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _MainColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _Attribute1;
uniform highp float _Attribute2;
uniform highp float _Attribute3;
uniform highp float _Attribute4;
uniform highp float _Attribute5;
uniform highp float _Attribute6;
uniform highp float _LengthCorrection;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(greaterThanEqual (_glesColor, vec4(0.82, 0.82, 0.82, 0.82)));
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(greaterThanEqual (_glesColor, vec4(0.72, 0.72, 0.72, 0.72)));
  highp vec4 tmpvar_4;
  tmpvar_4 = vec4(greaterThanEqual (_glesColor, vec4(0.62, 0.62, 0.62, 0.62)));
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(greaterThanEqual (_glesColor, vec4(0.52, 0.52, 0.52, 0.52)));
  highp vec4 tmpvar_6;
  tmpvar_6 = vec4(greaterThanEqual (_glesColor, vec4(0.42, 0.42, 0.42, 0.42)));
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  highp vec3 tmpvar_8;
  tmpvar_8 = (_glesNormal * _LengthCorrection);
  tmpvar_7.xyz = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = tmpvar_8;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = tmpvar_8;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = tmpvar_8;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 0.0;
  tmpvar_12.xyz = tmpvar_8;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = tmpvar_8;
  tmpvar_1.xyz = (_glesVertex.xyz + ((
    ((((
      ((_Attribute1 + -1.0) * tmpvar_7)
     * tmpvar_2) + (
      ((_Attribute2 + -1.0) * tmpvar_9)
     * 
      (tmpvar_3 - tmpvar_2)
    )) + ((
      (_Attribute3 + -1.0)
     * tmpvar_10) * (tmpvar_4 - tmpvar_3))) + (((_Attribute4 + -1.0) * tmpvar_11) * (tmpvar_5 - tmpvar_4)))
   + 
    (((_Attribute5 + -1.0) * tmpvar_12) * (tmpvar_6 - tmpvar_5))
  ) + (
    ((_Attribute6 + -1.0) * tmpvar_13)
   * 
    (vec4(greaterThanEqual (_glesColor, vec4(0.32, 0.32, 0.32, 0.32))) - tmpvar_6)
  )).xyz);
  highp vec4 tmpvar_14;
  tmpvar_14.w = 1.0;
  tmpvar_14.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_14));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, tmpvar_2);
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _MainColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
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
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "RECT_MASK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "RECT_MASK" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}