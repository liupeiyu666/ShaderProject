//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/VertexAni_Common" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,1)
_MainTex ("MainTex", 2D) = "white" { }
_MoveandScaleXYZmovespeedWScaleSpeed ("Move and Scale (XYZ: move speed W:Scale Speed)", Vector) = (0.1,0.1,0.1,0.1)
_UVSpeed ("UVSpeed", Vector) = (0,0,0,0)
_ScaleSpeed ("Scale Speed", Float) = 0.5
_MoveSpeed ("Move Speed", Float) = 1
_Noise ("Noise", 2D) = "white" { }
_texcoord ("", 2D) = "white" { }
[Header(Motion Vectors)] _MotionVectorsAlphaCutoff ("Motion Vectors Alpha Cutoff", Range(0, 1)) = 0.1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "MAIN"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 2855
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  mediump vec4 tex2DNode1_3;
  mediump vec2 panner15_4;
  mediump vec2 uv_MainTex_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_5 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (uv_MainTex_5 + (_Time.y * _UVSpeed));
  panner15_4 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, panner15_4);
  tex2DNode1_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_3.w);
  aseOutAlpha_2 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = ((_MainColor * tex2DNode1_3) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_10;
  mediump float tmpvar_11;
  tmpvar_11 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = aseOutColor_1;
  tmpvar_12.w = tmpvar_11;
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  tmpvar_4.xyw = tmpvar_12.xyw;
  tmpvar_4.z = (tmpvar_12.z + (_MHYZBias * tmpvar_12.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 unity_DebugViewInfo;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  mediump vec4 tex2DNode1_4;
  mediump vec2 panner15_5;
  mediump vec2 uv_MainTex_6;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
    uv_MainTex_6 = tmpvar_7;
    highp vec2 tmpvar_8;
    tmpvar_8 = (uv_MainTex_6 + (_Time.y * _UVSpeed));
    panner15_5 = tmpvar_8;
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_MainTex, panner15_5);
    tex2DNode1_4 = tmpvar_9;
    highp float tmpvar_10;
    tmpvar_10 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_4.w);
    aseOutAlpha_3 = tmpvar_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((_MainColor * tex2DNode1_4) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_11;
    mediump float tmpvar_12;
    tmpvar_12 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_12;
    mediump vec4 tmpvar_13;
    tmpvar_13.xyz = aseOutColor_2;
    tmpvar_13.w = tmpvar_12;
    tmpvar_1 = tmpvar_13;
  };
  gl_FragData[0] = tmpvar_1;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
 Pass {
  Name "MOTIONVECTORS"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "MOTIONVECTORS" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 93138
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12);
  tmpvar_4 = (unity_MatrixVP * tmpvar_13);
  tmpvar_4.z = (tmpvar_4.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_4.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_13);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_13);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump float aseOutAlpha_4;
  mediump vec4 tex2DNode1_5;
  mediump vec2 panner15_6;
  mediump vec2 uv_MainTex_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (uv_MainTex_7 + (_Time.y * _UVSpeed));
  panner15_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, panner15_6);
  tex2DNode1_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_5.w);
  aseOutAlpha_4 = tmpvar_11;
  mediump float x_12;
  x_12 = (aseOutAlpha_4 - _MotionVectorsAlphaCutoff);
  if ((x_12 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = uvDiff_3;
  velocity_2.xy = tmpvar_14.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12);
  tmpvar_4 = (unity_MatrixVP * tmpvar_13);
  tmpvar_4.z = (tmpvar_4.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_4.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_13);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_13);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump float aseOutAlpha_4;
  mediump vec4 tex2DNode1_5;
  mediump vec2 panner15_6;
  mediump vec2 uv_MainTex_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (uv_MainTex_7 + (_Time.y * _UVSpeed));
  panner15_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, panner15_6);
  tex2DNode1_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_5.w);
  aseOutAlpha_4 = tmpvar_11;
  mediump float x_12;
  x_12 = (aseOutAlpha_4 - _MotionVectorsAlphaCutoff);
  if ((x_12 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = uvDiff_3;
  velocity_2.xy = tmpvar_14.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
uniform highp float _MotionVectorDepthBias;
uniform highp mat4 _NonJitteredVP;
uniform highp mat4 _PreviousVP;
uniform mediump vec4 _MoveandScaleXYZmovespeedWScaleSpeed;
uniform sampler2D _Noise;
uniform highp vec4 _Noise_ST;
uniform mediump float _MoveSpeed;
uniform mediump float _ScaleSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  mediump float mulTime65_2;
  mediump float mulTime56_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _Noise_ST.xy) + _Noise_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_Noise, tmpvar_5.xy, 0.0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = (_MoveandScaleXYZmovespeedWScaleSpeed * tmpvar_6);
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _MoveSpeed);
  mulTime56_3 = tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_Time.y * _ScaleSpeed);
  mulTime65_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = sin(mulTime56_3);
  mediump float tmpvar_11;
  tmpvar_11 = sin(mulTime65_2);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_7.xyz * tmpvar_10) + (
    (tmpvar_7.w * _glesNormal)
   * tmpvar_11)));
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * tmpvar_12);
  tmpvar_4 = (unity_MatrixVP * tmpvar_13);
  tmpvar_4.z = (tmpvar_4.z + ((_MHYZBias + 
    (_MotionVectorDepthBias * 2.0)
  ) * tmpvar_4.w));
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = (_NonJitteredVP * tmpvar_13);
  xlv_TEXCOORD4 = (_PreviousVP * tmpvar_13);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump float _MotionVectorsAlphaCutoff;
uniform mediump vec4 _MainColor;
uniform sampler2D _MainTex;
uniform mediump vec2 _UVSpeed;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 velocity_2;
  mediump vec2 uvDiff_3;
  mediump float aseOutAlpha_4;
  mediump vec4 tex2DNode1_5;
  mediump vec2 panner15_6;
  mediump vec2 uv_MainTex_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  uv_MainTex_7 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = (uv_MainTex_7 + (_Time.y * _UVSpeed));
  panner15_6 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, panner15_6);
  tex2DNode1_5 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = ((_MainColor.w * xlv_COLOR.w) * tex2DNode1_5.w);
  aseOutAlpha_4 = tmpvar_11;
  mediump float x_12;
  x_12 = (aseOutAlpha_4 - _MotionVectorsAlphaCutoff);
  if ((x_12 < 0.0)) {
    discard;
  };
  highp vec2 tmpvar_13;
  tmpvar_13 = (((
    (xlv_TEXCOORD3.xyz / xlv_TEXCOORD3.w)
  .xy + 1.0) / 2.0) - ((
    (xlv_TEXCOORD4.xyz / xlv_TEXCOORD4.w)
  .xy + 1.0) / 2.0));
  uvDiff_3 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 1.0);
  tmpvar_14.xy = uvDiff_3;
  velocity_2.xy = tmpvar_14.xy;
  velocity_2.zw = vec2(0.0, 0.0);
  tmpvar_1 = velocity_2;
  gl_FragData[0] = tmpvar_1;
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
CustomEditor "MiHoYoASEMaterialInspector"
}