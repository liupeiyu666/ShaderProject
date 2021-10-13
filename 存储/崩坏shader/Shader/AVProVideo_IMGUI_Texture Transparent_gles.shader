//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/IMGUI/Texture Transparent" {
Properties {
_MainTex ("Texture", any) = "" { }
_ChromaTex ("Chroma", any) = "" { }
_VertScale ("Vertical Scale", Range(-1, 1)) = 1
[KeywordEnum(None, Top_Bottom, Left_Right)] AlphaPack ("Alpha Pack", Float) = 0
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 Tags { "ForceSupported" = "true" "RenderType" = "Overlay" }
 Pass {
  Tags { "ForceSupported" = "true" "RenderType" = "Overlay" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 59941
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  col_1 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_5;
  tmpvar_5 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_NONE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5 = uv_4.xyxy;
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_TOP_BOTTOM" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.xzw = uv_4.xxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.y * 1.5);
  result_5.y = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.y);
  result_5.w = (result_5.y + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - result_5.yw);
    result_5.yw = result_5.wy;
  } else {
    result_5.yw = result_5.wy;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_7;
  tmpvar_7 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_7;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_9;
  tmpvar_9 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" "ALPHAPACK_LEFT_RIGHT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _VertScale;
varying lowp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec2 uv_4;
  uv_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 result_5;
  result_5.yzw = uv_4.yxy;
  highp float tmpvar_6;
  tmpvar_6 = (_MainTex_TexelSize.x * 1.5);
  result_5.x = mix (tmpvar_6, (0.5 - tmpvar_6), uv_4.x);
  result_5.z = (result_5.x + 0.5);
  if ((_VertScale < 0.0)) {
    result_5.yw = (1.0 - uv_4.yy);
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = result_5;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _ChromaTex;
uniform highp mat4 _YpCbCrTransform;
varying lowp vec4 xlv_COLOR;
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
  lowp vec4 tmpvar_11;
  tmpvar_11 = (col_1 * xlv_COLOR);
  gl_FragData[0] = tmpvar_11;
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