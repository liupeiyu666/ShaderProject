//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_ConeOfVision" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_MainColor ("MainColor", Color) = (0.8962264,0.8962264,0.8962264,0)
_Emitter_Scaler ("Emitter_Scaler", Float) = 1
_Opaqueness ("Opacity", Float) = 1
_OpacityTex ("OpacityTex", 2D) = "white" { }
_DepthTexture ("DepthTexture", 2D) = "white" { }
_DepthColor ("DepthColor", Color) = (0,0.5862069,1,0)
_DepthTextureColor ("DepthTextureColor", Color) = (0,0.1310344,1,0)
_DepthRange ("DepthRange", Float) = 0
_DepthTextureIntensity ("DepthTextureIntensity", Float) = 1
_DepthColorIntensity ("DepthColorIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 13717
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _OpacityTex;
uniform highp vec4 _OpacityTex_ST;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _DepthTexture;
uniform highp vec4 _DepthTexture_ST;
uniform highp vec4 _DepthTextureColor;
uniform highp float _DepthTextureIntensity;
uniform highp vec4 _DepthColor;
uniform highp float _DepthColorIntensity;
uniform highp vec4 _MainColor;
uniform highp float _Emitter_Scaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthRange;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 ase_screenPosNorm_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _OpacityTex_ST.xy) + _OpacityTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode2_4 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _DepthTexture_ST.xy) + _DepthTexture_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_3.xyw = tmpvar_9.xyw;
  ase_screenPosNorm_3.z = ((tmpvar_9.z * 0.5) + 0.5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_11;
  z_11 = tmpvar_10.x;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DepthTexture, tmpvar_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_OpacityTex, tmpvar_5);
  highp float tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * _Opaqueness) * (tex2DNode2_4.x * tex2DNode2_4.w)).x;
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (((
    (tmpvar_12 * _DepthTextureColor)
   * _DepthTextureIntensity) + (_DepthColor * _DepthColorIntensity)), (tex2DNode2_4 * (_MainColor * _Emitter_Scaler)), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_11)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_3.z)
     + _ZBufferParams.w)))) / _DepthRange)
  ), 0.0, 1.0))).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _OpacityTex;
uniform highp vec4 _OpacityTex_ST;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _DepthTexture;
uniform highp vec4 _DepthTexture_ST;
uniform highp vec4 _DepthTextureColor;
uniform highp float _DepthTextureIntensity;
uniform highp vec4 _DepthColor;
uniform highp float _DepthColorIntensity;
uniform highp vec4 _MainColor;
uniform highp float _Emitter_Scaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthRange;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 ase_screenPosNorm_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _OpacityTex_ST.xy) + _OpacityTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode2_4 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _DepthTexture_ST.xy) + _DepthTexture_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_3.xyw = tmpvar_9.xyw;
  ase_screenPosNorm_3.z = ((tmpvar_9.z * 0.5) + 0.5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_11;
  z_11 = tmpvar_10.x;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DepthTexture, tmpvar_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_OpacityTex, tmpvar_5);
  highp float tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * _Opaqueness) * (tex2DNode2_4.x * tex2DNode2_4.w)).x;
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (((
    (tmpvar_12 * _DepthTextureColor)
   * _DepthTextureIntensity) + (_DepthColor * _DepthColorIntensity)), (tex2DNode2_4 * (_MainColor * _Emitter_Scaler)), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_11)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_3.z)
     + _ZBufferParams.w)))) / _DepthRange)
  ), 0.0, 1.0))).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _OpacityTex;
uniform highp vec4 _OpacityTex_ST;
uniform highp float _Opaqueness;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _DepthTexture;
uniform highp vec4 _DepthTexture_ST;
uniform highp vec4 _DepthTextureColor;
uniform highp float _DepthTextureIntensity;
uniform highp vec4 _DepthColor;
uniform highp float _DepthColorIntensity;
uniform highp vec4 _MainColor;
uniform highp float _Emitter_Scaler;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthRange;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 ase_screenPosNorm_3;
  highp vec4 tex2DNode2_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _OpacityTex_ST.xy) + _OpacityTex_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode2_4 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD0.xy * _DepthTexture_ST.xy) + _DepthTexture_ST.zw);
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm_3.xyw = tmpvar_9.xyw;
  ase_screenPosNorm_3.z = ((tmpvar_9.z * 0.5) + 0.5);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_11;
  z_11 = tmpvar_10.x;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_DepthTexture, tmpvar_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_OpacityTex, tmpvar_5);
  highp float tmpvar_14;
  tmpvar_14 = ((tmpvar_13 * _Opaqueness) * (tex2DNode2_4.x * tex2DNode2_4.w)).x;
  aseOutAlpha_2 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (((
    (tmpvar_12 * _DepthTextureColor)
   * _DepthTextureIntensity) + (_DepthColor * _DepthColorIntensity)), (tex2DNode2_4 * (_MainColor * _Emitter_Scaler)), vec4(clamp (abs(
    (((1.0/((
      (_ZBufferParams.z * z_11)
     + _ZBufferParams.w))) - (1.0/((
      (_ZBufferParams.z * ase_screenPosNorm_3.z)
     + _ZBufferParams.w)))) / _DepthRange)
  ), 0.0, 1.0))).xyz;
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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