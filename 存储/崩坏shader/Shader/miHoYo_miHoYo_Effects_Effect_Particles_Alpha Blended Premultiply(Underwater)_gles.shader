//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Alpha Blended Premultiply(Underwater)" {
Properties {
_MainTex ("Particle Texture", 2D) = "white" { }
_InvFade ("Soft Particles Factor", Range(0.01, 3)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 41994
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((xlv_COLOR * tmpvar_1) * xlv_COLOR.w);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  highp float tmpvar_2;
  tmpvar_2 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_2);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = ((tmpvar_1 * tmpvar_3) * tmpvar_1.w);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  mediump vec3 fogParam_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _UWFogDistStart));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_5)
    ) * (_UWFogDensity * tmpvar_5))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_7;
  tmpvar_7 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_5))
   * 
    (_UWFogColorNFIntensity * tmpvar_5)
  )), 0.0, 1.0);
  fogParam_2.x = tmpvar_7;
  fogParam_2.y = tmpvar_6;
  fogParam_2.z = tmpvar_3.y;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = fogParam_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((xlv_COLOR * tmpvar_2) * xlv_COLOR.w);
  outColor_1.w = tmpvar_3.w;
  outColor_1.xyz = mix (tmpvar_3.xyz, vec3(dot (tmpvar_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform highp vec4 _MainTex_ST;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
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
  tmpvar_2.xyw = o_5.xyw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_8)).z);
  mediump vec3 fogParam_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_11;
  tmpvar_11 = (tmpvar_10.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_12;
  tmpvar_12 = max (0.0, (sqrt(
    dot (tmpvar_11, tmpvar_11)
  ) - _UWFogDistStart));
  highp float tmpvar_13;
  tmpvar_13 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_12)
    ) * (_UWFogDensity * tmpvar_12))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_14;
  tmpvar_14 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_12))
   * 
    (_UWFogColorNFIntensity * tmpvar_12)
  )), 0.0, 1.0);
  fogParam_9.x = tmpvar_14;
  fogParam_9.y = tmpvar_13;
  fogParam_9.z = tmpvar_10.y;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = fogParam_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform mediump float _LumiFactor;
uniform highp sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1.xyz = xlv_COLOR.xyz;
  mediump vec4 outColor_2;
  highp float tmpvar_3;
  tmpvar_3 = clamp ((_InvFade * (
    (1.0/(((_ZBufferParams.z * texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1).x) + _ZBufferParams.w)))
   - xlv_TEXCOORD1.z)), 0.0, 1.0);
  tmpvar_1.w = (xlv_COLOR.w * tmpvar_3);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_1 * tmpvar_4) * tmpvar_1.w);
  outColor_2.w = tmpvar_5.w;
  outColor_2.xyz = mix (tmpvar_5.xyz, vec3(dot (tmpvar_5.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SOFTPARTICLES_ON" "LUMINANCE" "_UNDERWATER_FOG" }
""
}
}
}
}
}