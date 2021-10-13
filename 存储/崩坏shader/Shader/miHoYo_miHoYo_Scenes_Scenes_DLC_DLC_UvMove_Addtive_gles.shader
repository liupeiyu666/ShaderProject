//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_UvMove_Addtive" {
Properties {
_MainTex1 ("Texture1", 2D) = "white" { }
_MainColor1 ("MainColor1", Color) = (1,1,1,1)
_Opacity1 ("Opacity1", Range(0, 1)) = 1
_ScrollXSpeed1 ("ScrollXSpeed1", Float) = 0
_ScrollYSpeed1 ("ScrollYSpeed1", Float) = 0
_MainTex2 ("Texture2", 2D) = "black" { }
_MainColor2 ("MainColor2", Color) = (1,1,1,1)
_Opacity2 ("Opacity2", Range(0, 1)) = 1
_ScrollXSpeed2 ("ScrollXSpeed2", Float) = 0
_ScrollYSpeed2 ("ScrollYSpeed2", Float) = 0
}
SubShader {
 LOD 100
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 64604
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex1_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex1_ST.xy) + _MainTex1_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex1;
uniform highp vec4 _MainColor1;
uniform highp float _Opacity1;
uniform mediump float _ScrollXSpeed1;
uniform mediump float _ScrollYSpeed1;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec4 col_3;
  highp vec4 tex2_4;
  mediump float yScrollValue2_5;
  mediump float xScrollValue2_6;
  highp vec4 tex1_7;
  mediump float yScrollValue1_8;
  mediump float xScrollValue1_9;
  highp float tmpvar_10;
  tmpvar_10 = (_ScrollXSpeed1 * _Time).x;
  xScrollValue1_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_ScrollYSpeed1 * _Time).x;
  yScrollValue1_8 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = xScrollValue1_9;
  tmpvar_12.y = yScrollValue1_8;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex1, tmpvar_1);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _MainColor1);
  tex1_7.xyz = tmpvar_14.xyz;
  tex1_7.w = (tmpvar_14.w * _Opacity1);
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_6;
  tmpvar_17.y = yScrollValue2_5;
  tmpvar_2 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_2);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * _MainColor2);
  tex2_4.xyz = tmpvar_19.xyz;
  tex2_4.w = (tmpvar_19.w * _Opacity2);
  col_3.xyz = ((_Opacity1 * tmpvar_14.xyz) + (_Opacity2 * tmpvar_19.xyz));
  col_3.w = (tex1_7.w + tex2_4.w);
  col_3.w = clamp (col_3.w, 0.0, 1.0);
  gl_FragData[0] = col_3;
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
uniform highp vec4 _MainTex1_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex1_ST.xy) + _MainTex1_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex1;
uniform highp vec4 _MainColor1;
uniform highp float _Opacity1;
uniform mediump float _ScrollXSpeed1;
uniform mediump float _ScrollYSpeed1;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec4 col_3;
  highp vec4 tex2_4;
  mediump float yScrollValue2_5;
  mediump float xScrollValue2_6;
  highp vec4 tex1_7;
  mediump float yScrollValue1_8;
  mediump float xScrollValue1_9;
  highp float tmpvar_10;
  tmpvar_10 = (_ScrollXSpeed1 * _Time).x;
  xScrollValue1_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_ScrollYSpeed1 * _Time).x;
  yScrollValue1_8 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = xScrollValue1_9;
  tmpvar_12.y = yScrollValue1_8;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex1, tmpvar_1);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _MainColor1);
  tex1_7.xyz = tmpvar_14.xyz;
  tex1_7.w = (tmpvar_14.w * _Opacity1);
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_6;
  tmpvar_17.y = yScrollValue2_5;
  tmpvar_2 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_2);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * _MainColor2);
  tex2_4.xyz = tmpvar_19.xyz;
  tex2_4.w = (tmpvar_19.w * _Opacity2);
  col_3.xyz = ((_Opacity1 * tmpvar_14.xyz) + (_Opacity2 * tmpvar_19.xyz));
  col_3.w = (tex1_7.w + tex2_4.w);
  col_3.w = clamp (col_3.w, 0.0, 1.0);
  gl_FragData[0] = col_3;
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
uniform highp vec4 _MainTex1_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex1_ST.xy) + _MainTex1_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex1;
uniform highp vec4 _MainColor1;
uniform highp float _Opacity1;
uniform mediump float _ScrollXSpeed1;
uniform mediump float _ScrollYSpeed1;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec4 col_3;
  highp vec4 tex2_4;
  mediump float yScrollValue2_5;
  mediump float xScrollValue2_6;
  highp vec4 tex1_7;
  mediump float yScrollValue1_8;
  mediump float xScrollValue1_9;
  highp float tmpvar_10;
  tmpvar_10 = (_ScrollXSpeed1 * _Time).x;
  xScrollValue1_9 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_ScrollYSpeed1 * _Time).x;
  yScrollValue1_8 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = xScrollValue1_9;
  tmpvar_12.y = yScrollValue1_8;
  tmpvar_1 = (xlv_TEXCOORD0 + tmpvar_12);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_MainTex1, tmpvar_1);
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _MainColor1);
  tex1_7.xyz = tmpvar_14.xyz;
  tex1_7.w = (tmpvar_14.w * _Opacity1);
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_6 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_5 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_6;
  tmpvar_17.y = yScrollValue2_5;
  tmpvar_2 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_2);
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_18 * _MainColor2);
  tex2_4.xyz = tmpvar_19.xyz;
  tex2_4.w = (tmpvar_19.w * _Opacity2);
  col_3.xyz = ((_Opacity1 * tmpvar_14.xyz) + (_Opacity2 * tmpvar_19.xyz));
  col_3.w = (tex1_7.w + tex2_4.w);
  col_3.w = clamp (col_3.w, 0.0, 1.0);
  gl_FragData[0] = col_3;
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