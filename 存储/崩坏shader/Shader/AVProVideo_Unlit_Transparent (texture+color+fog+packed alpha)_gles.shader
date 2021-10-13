//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Unlit/Transparent (texture+color+fog+packed alpha)" {
Properties {
_MainTex ("Base (RGB) Trans (A)", 2D) = "black" { }
_Color ("Main Color", Color) = (1,1,1,1)
_ChromaTex ("Chroma", 2D) = "gray" { }
[KeywordEnum(None, Top_Bottom, Left_Right)] AlphaPack ("Alpha Pack", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 39580
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4 = tmpvar_1.xyxy;
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.xzw = tmpvar_1.xxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.y * 1.5);
  result_4.y = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.y);
  result_4.w = (result_4.y + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - result_4.yw);
    result_4.yw = result_4.wy;
  } else {
    result_4.yw = result_4.wy;
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1.xyz = tmpvar_3.xyz;
  mediump float alpha_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_6;
  tmpvar_6 = tmpvar_5.xyz;
  alpha_4 = (((tmpvar_6.x + tmpvar_6.y) + tmpvar_6.z) / 3.0);
  col_1.w = alpha_4;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  rgba_2.w = tmpvar_4.w;
  rgba_2.xyz = (tmpvar_4.xyz * ((tmpvar_4.xyz * 
    ((tmpvar_4.xyz * 0.305306) + 0.6821711)
  ) + 0.01252288));
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  mediump vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * ((tmpvar_7 * 
    ((tmpvar_7 * 0.305306) + 0.6821711)
  ) + 0.01252288));
  alpha_5 = (((tmpvar_8.x + tmpvar_8.y) + tmpvar_8.z) / 3.0);
  col_1.w = alpha_5;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if ((_MainTex_ST.y < 0.0)) {
    tmpvar_1.y = (1.0 - tmpvar_1.y);
  };
  highp vec4 result_4;
  result_4.yzw = tmpvar_1.yxy;
  highp float tmpvar_5;
  tmpvar_5 = (_MainTex_TexelSize.x * 1.5);
  result_4.x = mix (tmpvar_5, (0.5 - tmpvar_5), tmpvar_1.x);
  result_4.z = (result_4.x + 0.5);
  if ((_MainTex_ST.y < 0.0)) {
    result_4.yw = (1.0 - tmpvar_1.yy);
  };
  tmpvar_1 = result_4;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = result_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
uniform lowp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  mediump vec4 rgba_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ChromaTex, xlv_TEXCOORD0.xy);
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
  col_1.xyz = rgba_2.xyz;
  mediump float alpha_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0.zw);
  alpha_9 = ((tmpvar_10.x - 0.0625) * 1.164384);
  col_1.w = alpha_9;
  col_1 = (col_1 * _Color);
  gl_FragData[0] = col_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
""
}
}
}
}
}