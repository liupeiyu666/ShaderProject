//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/UI/Stereo" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_ChromaTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
_StencilComp ("Stencil Comparison", Float) = 8
_Stencil ("Stencil ID", Float) = 0
_StencilOp ("Stencil Operation", Float) = 0
_StencilWriteMask ("Stencil Write Mask", Float) = 255
_StencilReadMask ("Stencil Read Mask", Float) = 255
_ColorMask ("Color Mask", Float) = 15
[KeywordEnum(None, Top_Bottom, Left_Right)] Stereo ("Stereo Mode", Float) = 0
[Toggle(STEREO_DEBUG)] _StereoDebug ("Stereo Debug Tinting", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 65258
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = tmpvar_1;
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  bool isYFlipped_12;
  isYFlipped_12 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_13;
  offset_13.x = 0.0;
  offset_13.y = 0.0;
  if (!(tmpvar_7)) {
    offset_13.y = 0.5;
  };
  if (!(isYFlipped_12)) {
    offset_13.y = (0.5 - offset_13.y);
  };
  tmpvar_3 = (tmpvar_3 * vec2(1.0, 0.5));
  tmpvar_3 = (tmpvar_3 + offset_13);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].x;
  v_14.y = unity_MatrixV[1].x;
  v_14.z = unity_MatrixV[2].x;
  v_14.w = unity_MatrixV[3].x;
  bool tmpvar_15;
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition + v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = ((_cameraPosition - v_14.xyz) - _WorldSpaceCameraPos);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  tmpvar_15 = (tmpvar_16 > tmpvar_18);
  highp vec4 tint_20;
  tint_20 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_15) {
    tint_20 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_20 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_20);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  col_1 = tmpvar_4;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  rgba_3.w = tmpvar_5.w;
  rgba_3.xyz = (tmpvar_5.xyz * ((tmpvar_5.xyz * 
    ((tmpvar_5.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform lowp vec4 _Color;
uniform highp vec3 _cameraPosition;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  lowp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = tmpvar_1;
  highp vec4 v_6;
  v_6.x = unity_MatrixV[0].x;
  v_6.y = unity_MatrixV[1].x;
  v_6.z = unity_MatrixV[2].x;
  v_6.w = unity_MatrixV[3].x;
  bool tmpvar_7;
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition + v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = ((_cameraPosition - v_6.xyz) - _WorldSpaceCameraPos);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  tmpvar_7 = (tmpvar_8 > tmpvar_10);
  highp vec2 offset_12;
  offset_12.y = 0.0;
  offset_12.x = 0.0;
  if (!(tmpvar_7)) {
    offset_12.x = 0.5;
  };
  tmpvar_3 = (tmpvar_3 * vec2(0.5, 1.0));
  tmpvar_3 = (tmpvar_3 + offset_12);
  tmpvar_2 = (_glesColor * _Color);
  highp vec4 v_13;
  v_13.x = unity_MatrixV[0].x;
  v_13.y = unity_MatrixV[1].x;
  v_13.z = unity_MatrixV[2].x;
  v_13.w = unity_MatrixV[3].x;
  bool tmpvar_14;
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition + v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  highp float tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = ((_cameraPosition - v_13.xyz) - _WorldSpaceCameraPos);
  tmpvar_17 = sqrt(dot (tmpvar_18, tmpvar_18));
  tmpvar_14 = (tmpvar_15 > tmpvar_17);
  highp vec4 tint_19;
  tint_19 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_14) {
    tint_19 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_19 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  tmpvar_2 = (tmpvar_2 * tint_19);
  gl_Position = tmpvar_4;
  xlv_COLOR = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  highp vec2 uv_2;
  uv_2 = xlv_TEXCOORD0;
  mediump vec4 rgba_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_ChromaTex, uv_2);
  highp vec3 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.yz = tmpvar_5.xy;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _YpCbCrTransform[0].xyz;
  tmpvar_7[1] = _YpCbCrTransform[1].xyz;
  tmpvar_7[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_8;
  v_8.x = _YpCbCrTransform[0].w;
  v_8.y = _YpCbCrTransform[1].w;
  v_8.z = _YpCbCrTransform[2].w;
  v_8.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_7 * (tmpvar_6 + v_8.xyz));
  rgba_3 = tmpvar_9;
  rgba_3.xyz = (rgba_3.xyz * ((rgba_3.xyz * 
    ((rgba_3.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_3;
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "MONOSCOPIC" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_TOP_BOTTOM" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_LEFT_RIGHT" "STEREO_DEBUG" }
""
}
}
}
}
}