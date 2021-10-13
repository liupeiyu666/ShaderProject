//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Blind_Texture" {
Properties {
_MainTex ("Base (RGB)", 2D) = "white" { }
_Texture ("Texture", 2D) = "white" { }
[MaterialToggle] _TextureFill ("TextureFill", Float) = 1
_TextureAspectX ("Texture Aspect X", Float) = 1
_TextureAspectY ("Texture Aspect Y", Float) = 1
_Value ("Value", Float) = 0
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  GpuProgramID 39679
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  gl_FragData[0] = xlat_varoutput_2;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  gl_FragData[0] = xlat_varoutput_2;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  gl_FragData[0] = xlat_varoutput_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  xlat_varoutput_2.xyz = mix (xlat_varoutput_2.xyz, vec3(dot (xlat_varoutput_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_varoutput_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  xlat_varoutput_2.xyz = mix (xlat_varoutput_2.xyz, vec3(dot (xlat_varoutput_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_varoutput_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD01 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD01;
void main ()
{
  mediump float g_1;
  mediump vec4 xlat_varoutput_2;
  lowp vec3 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  xlat_varoutput_2.xyz = tmpvar_3;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_4;
    tmpvar_4.x = xlv_TEXCOORD01.x;
    tmpvar_4.y = (1.0 - xlv_TEXCOORD01.y);
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_Texture, tmpvar_4);
    g_1 = tmpvar_5.y;
  } else {
    mediump vec2 tmpvar_6;
    tmpvar_6.x = xlv_TEXCOORD01.x;
    tmpvar_6.y = (1.0 - xlv_TEXCOORD01.y);
    highp vec2 tmpvar_7;
    tmpvar_7.x = _TextureAspectX;
    tmpvar_7.y = _TextureAspectY;
    lowp vec4 tmpvar_8;
    highp vec2 P_9;
    P_9 = (tmpvar_6 * tmpvar_7);
    tmpvar_8 = texture2D (_Texture, P_9);
    g_1 = tmpvar_8.y;
  };
  if ((g_1 <= _Value)) {
    discard;
  };
  xlat_varoutput_2.w = 1.0;
  xlat_varoutput_2.xyz = mix (xlat_varoutput_2.xyz, vec3(dot (xlat_varoutput_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_varoutput_2;
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
}
}
}
}