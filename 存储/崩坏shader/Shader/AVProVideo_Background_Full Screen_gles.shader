//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Background/Full Screen" {
Properties {
_MainTex ("Texture", 2D) = "black" { }
_ChromaTex ("Chroma", 2D) = "gray" { }
_Color ("Main Color", Color) = (1,1,1,1)
[Toggle(APPLY_GAMMA)] _ApplyGamma ("Apply Gamma", Float) = 0
[Toggle(USE_YPCBCR)] _UseYpCbCr ("Use YpCbCr", Float) = 0
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Background" "RenderType" = "Opaque" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 13164
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  highp vec2 scale_2;
  highp float tmpvar_3;
  tmpvar_3 = (_ScreenParams.y / _ScreenParams.x);
  highp float tmpvar_4;
  tmpvar_4 = (_MainTex_TexelSize.w / _MainTex_TexelSize.z);
  highp vec2 tmpvar_5;
  tmpvar_5.x = 1.0;
  tmpvar_5.y = (tmpvar_4 / tmpvar_3);
  scale_2 = tmpvar_5;
  if ((tmpvar_3 < tmpvar_4)) {
    highp vec2 tmpvar_6;
    tmpvar_6.y = 1.0;
    tmpvar_6.x = (tmpvar_3 / tmpvar_4);
    scale_2 = tmpvar_6;
  };
  highp vec2 tmpvar_7;
  tmpvar_7 = ((_glesVertex.xy * scale_2) * 2.0);
  pos_1 = tmpvar_7;
  if ((_ProjectionParams.x < 0.0)) {
    pos_1.y = ((1.0 - tmpvar_7.y) - 1.0);
  };
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(-1.0, 1.0);
  tmpvar_8.xy = pos_1;
  gl_Position = tmpvar_8;
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
  lowp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = col_1.xyz;
  gl_FragData[0] = tmpvar_9;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA_OFF" "USE_YPCBCR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR_OFF" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "APPLY_GAMMA" "USE_YPCBCR" }
""
}
}
}
}
}