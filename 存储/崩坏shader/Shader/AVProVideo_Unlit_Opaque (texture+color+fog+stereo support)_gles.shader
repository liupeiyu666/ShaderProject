//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Unlit/Opaque (texture+color+fog+stereo support)" {
Properties {
_MainTex ("Base (RGB)", 2D) = "black" { }
_ChromaTex ("Chroma", 2D) = "gray" { }
_Color ("Main Color", Color) = (1,1,1,1)
[KeywordEnum(None, Top_Bottom, Left_Right, Custom_UV)] Stereo ("Stereo Mode", Float) = 0
[Toggle(STEREO_DEBUG)] _StereoDebug ("Stereo Debug Tinting", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 18399
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "MONOSCOPIC" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  bool isYFlipped_10;
  isYFlipped_10 = (_MainTex_ST.y < 0.0);
  highp vec2 offset_11;
  offset_11.x = 0.0;
  offset_11.y = 0.0;
  if (!(tmpvar_5)) {
    offset_11.y = 0.5;
  };
  if (!(isYFlipped_10)) {
    offset_11.y = (0.5 - offset_11.y);
  };
  tmpvar_1 = (tmpvar_1 * vec2(1.0, 0.5));
  tmpvar_1 = (tmpvar_1 + offset_11);
  highp vec4 v_12;
  v_12.x = unity_MatrixV[0].x;
  v_12.y = unity_MatrixV[1].x;
  v_12.z = unity_MatrixV[2].x;
  v_12.w = unity_MatrixV[3].x;
  bool tmpvar_13;
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition + v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = ((_cameraPosition - v_12.xyz) - _WorldSpaceCameraPos);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  tmpvar_13 = (tmpvar_14 > tmpvar_16);
  highp vec4 tint_18;
  tint_18 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_13) {
    tint_18 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_18 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_18;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  highp vec2 offset_10;
  offset_10.y = 0.0;
  offset_10.x = 0.0;
  if (!(tmpvar_5)) {
    offset_10.x = 0.5;
  };
  tmpvar_1 = (tmpvar_1 * vec2(0.5, 1.0));
  tmpvar_1 = (tmpvar_1 + offset_10);
  highp vec4 v_11;
  v_11.x = unity_MatrixV[0].x;
  v_11.y = unity_MatrixV[1].x;
  v_11.z = unity_MatrixV[2].x;
  v_11.w = unity_MatrixV[3].x;
  bool tmpvar_12;
  highp float tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = ((_cameraPosition + v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_13 = sqrt(dot (tmpvar_14, tmpvar_14));
  highp float tmpvar_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = ((_cameraPosition - v_11.xyz) - _WorldSpaceCameraPos);
  tmpvar_15 = sqrt(dot (tmpvar_16, tmpvar_16));
  tmpvar_12 = (tmpvar_13 > tmpvar_15);
  highp vec4 tint_17;
  tint_17 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_12) {
    tint_17 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_17 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_17;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
  col_1 = (col_1 * xlv_COLOR);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec3 _cameraPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_4;
  v_4.x = unity_MatrixV[0].x;
  v_4.y = unity_MatrixV[1].x;
  v_4.z = unity_MatrixV[2].x;
  v_4.w = unity_MatrixV[3].x;
  bool tmpvar_5;
  highp float tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((_cameraPosition + v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_6 = sqrt(dot (tmpvar_7, tmpvar_7));
  highp float tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = ((_cameraPosition - v_4.xyz) - _WorldSpaceCameraPos);
  tmpvar_8 = sqrt(dot (tmpvar_9, tmpvar_9));
  tmpvar_5 = (tmpvar_6 > tmpvar_8);
  if (!(tmpvar_5)) {
    tmpvar_1 = ((_glesMultiTexCoord1.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  };
  highp vec4 v_10;
  v_10.x = unity_MatrixV[0].x;
  v_10.y = unity_MatrixV[1].x;
  v_10.z = unity_MatrixV[2].x;
  v_10.w = unity_MatrixV[3].x;
  bool tmpvar_11;
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = ((_cameraPosition + v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_cameraPosition - v_10.xyz) - _WorldSpaceCameraPos);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  tmpvar_11 = (tmpvar_12 > tmpvar_14);
  highp vec4 tint_16;
  tint_16 = vec4(1.0, 1.0, 1.0, 1.0);
  if (tmpvar_11) {
    tint_16 = vec4(0.0, 1.0, 0.0, 1.0);
  } else {
    tint_16 = vec4(1.0, 0.0, 0.0, 1.0);
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR = tint_16;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0);
  highp vec3 tmpvar_5;
  tmpvar_5.x = tmpvar_3.x;
  tmpvar_5.yz = tmpvar_4.xy;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _YpCbCrTransform[0].xyz;
  tmpvar_6[1] = _YpCbCrTransform[1].xyz;
  tmpvar_6[2] = _YpCbCrTransform[2].xyz;
  highp vec4 v_7;
  v_7.x = _YpCbCrTransform[0].w;
  v_7.y = _YpCbCrTransform[1].w;
  v_7.z = _YpCbCrTransform[2].w;
  v_7.w = _YpCbCrTransform[3].w;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_6 * (tmpvar_5 + v_7.xyz));
  rgba_2 = tmpvar_8;
  rgba_2.xyz = (rgba_2.xyz * ((rgba_2.xyz * 
    ((rgba_2.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1 = rgba_2;
  col_1 = (col_1 * _Color);
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
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "STEREO_CUSTOM_UV" "STEREO_DEBUG" }
""
}
}
}
}
}