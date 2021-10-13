//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "AVProVideo/Helper/Transition" {
Properties {
_MainTex ("Texture To", 2D) = "white" { }
_FromTex ("Texture From", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 47713
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "LERP_NONE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_NONE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_NONE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(_Fade));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(_Fade));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(_Fade));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_BLACK" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(0.0, 0.0, 0.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(0.0, 0.0, 0.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_BLACK" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(0.0, 0.0, 0.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(0.0, 0.0, 0.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_BLACK" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(0.0, 0.0, 0.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(0.0, 0.0, 0.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_WHITE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(1.0, 1.0, 1.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_WHITE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(1.0, 1.0, 1.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_WHITE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = mix (tmpvar_2, vec4(1.0, 1.0, 1.0, 1.0), vec4((_Fade * 2.0)));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = mix (vec4(1.0, 1.0, 1.0, 1.0), tmpvar_4, vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_TRANSP" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = (tmpvar_2 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4((_Fade * 2.0))));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = (tmpvar_4 * vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_TRANSP" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = (tmpvar_2 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4((_Fade * 2.0))));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = (tmpvar_4 * vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_TRANSP" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  if ((_Fade < 0.5)) {
    lowp vec4 tmpvar_2;
    tmpvar_2 = texture2D (_FromTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_3;
    tmpvar_3 = (tmpvar_2 * (vec4(1.0, 1.0, 1.0, 1.0) - vec4((_Fade * 2.0))));
    tmpvar_1 = tmpvar_3;
  } else {
    lowp vec4 tmpvar_4;
    tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
    highp vec4 tmpvar_5;
    tmpvar_5 = (tmpvar_4 * vec4((2.0 * (_Fade - 0.5))));
    tmpvar_1 = tmpvar_5;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.x))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.x))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.x))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_HORIZ_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.y))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.y))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= xlv_TEXCOORD0.y))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_VERT_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_VERT_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_VERT_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - 0.5))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAG" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    ((xlv_TEXCOORD0.y + xlv_TEXCOORD0.x) * 0.5)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAG" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    ((xlv_TEXCOORD0.y + xlv_TEXCOORD0.x) * 0.5)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAG" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    ((xlv_TEXCOORD0.y + xlv_TEXCOORD0.x) * 0.5)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAG_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - xlv_TEXCOORD0.x))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAG_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - xlv_TEXCOORD0.x))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAG_MIRROR" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    abs((xlv_TEXCOORD0.y - xlv_TEXCOORD0.x))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_CIRCLE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = (xlv_TEXCOORD0.x * 1.777);
  tmpvar_4.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - vec2(0.88885, 0.5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((
    (_Fade * 2.1)
   >= 
    sqrt(dot (tmpvar_5, tmpvar_5))
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_CIRCLE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = (xlv_TEXCOORD0.x * 1.777);
  tmpvar_4.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - vec2(0.88885, 0.5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((
    (_Fade * 2.1)
   >= 
    sqrt(dot (tmpvar_5, tmpvar_5))
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_CIRCLE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = (xlv_TEXCOORD0.x * 1.777);
  tmpvar_4.y = xlv_TEXCOORD0.y;
  highp vec2 tmpvar_5;
  tmpvar_5 = (tmpvar_4 - vec2(0.88885, 0.5));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((
    (_Fade * 2.1)
   >= 
    sqrt(dot (tmpvar_5, tmpvar_5))
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SCROLL_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.x = xlv_TEXCOORD0.x;
  uv1_4.y = (xlv_TEXCOORD0.y + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.y)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SCROLL_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.x = xlv_TEXCOORD0.x;
  uv1_4.y = (xlv_TEXCOORD0.y + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.y)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SCROLL_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.x = xlv_TEXCOORD0.x;
  uv1_4.y = (xlv_TEXCOORD0.y + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.y)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.y = xlv_TEXCOORD0.y;
  uv1_4.x = (xlv_TEXCOORD0.x + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.x)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.y = xlv_TEXCOORD0.y;
  uv1_4.x = (xlv_TEXCOORD0.x + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.x)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SCROLL_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv1_4;
  uv1_4.y = xlv_TEXCOORD0.y;
  uv1_4.x = (xlv_TEXCOORD0.x + _Fade);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_FromTex, uv1_4);
  cola_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_4.x)
  ))));
  tmpvar_1 = tmpvar_7;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAMOND" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float t_4;
  t_4 = (abs((
    (xlv_TEXCOORD0.x * 1.7777)
   - 0.88885)) + abs((xlv_TEXCOORD0.y - 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = float(((_Fade * 1.4) >= t_4));
  t_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(tmpvar_5));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAMOND" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float t_4;
  t_4 = (abs((
    (xlv_TEXCOORD0.x * 1.7777)
   - 0.88885)) + abs((xlv_TEXCOORD0.y - 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = float(((_Fade * 1.4) >= t_4));
  t_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(tmpvar_5));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAMOND" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float t_4;
  t_4 = (abs((
    (xlv_TEXCOORD0.x * 1.7777)
   - 0.88885)) + abs((xlv_TEXCOORD0.y - 0.5)));
  highp float tmpvar_5;
  tmpvar_5 = float(((_Fade * 1.4) >= t_4));
  t_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(tmpvar_5));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_BLINDS" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    fract((xlv_TEXCOORD0.x * 4.0))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_BLINDS" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    fract((xlv_TEXCOORD0.x * 4.0))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_BLINDS" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((_Fade >= 
    fract((xlv_TEXCOORD0.x * 4.0))
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_RECTS_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float bf_4;
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.y * 8.0);
  bf_4 = fract(tmpvar_5);
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / 8.0);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * 8.0);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  bf_4 = float(int(tmpvar_8));
  bf_4 += 1.0;
  bf_4 = (bf_4 * (_Fade / 2.0));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (cola_3, colb_2, vec4(float((bf_4 >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_RECTS_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float bf_4;
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.y * 8.0);
  bf_4 = fract(tmpvar_5);
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / 8.0);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * 8.0);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  bf_4 = float(int(tmpvar_8));
  bf_4 += 1.0;
  bf_4 = (bf_4 * (_Fade / 2.0));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (cola_3, colb_2, vec4(float((bf_4 >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_RECTS_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp float bf_4;
  highp float tmpvar_5;
  tmpvar_5 = (xlv_TEXCOORD0.y * 8.0);
  bf_4 = fract(tmpvar_5);
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_5 / 8.0);
  highp float tmpvar_7;
  tmpvar_7 = (fract(abs(tmpvar_6)) * 8.0);
  highp float tmpvar_8;
  if ((tmpvar_6 >= 0.0)) {
    tmpvar_8 = tmpvar_7;
  } else {
    tmpvar_8 = -(tmpvar_7);
  };
  bf_4 = float(int(tmpvar_8));
  bf_4 += 1.0;
  bf_4 = (bf_4 * (_Fade / 2.0));
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (cola_3, colb_2, vec4(float((bf_4 >= 
    abs((xlv_TEXCOORD0.x - 0.5))
  ))));
  tmpvar_1 = tmpvar_11;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_ARROW" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((
    ((abs((xlv_TEXCOORD0.y - 0.5)) * 0.5) + _Fade)
   >= 
    mix (0.5, 1.0, xlv_TEXCOORD0.x)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_ARROW" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((
    ((abs((xlv_TEXCOORD0.y - 0.5)) * 0.5) + _Fade)
   >= 
    mix (0.5, 1.0, xlv_TEXCOORD0.x)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_ARROW" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_FromTex, xlv_TEXCOORD0);
  cola_3 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  colb_2 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (cola_3, colb_2, vec4(float((
    ((abs((xlv_TEXCOORD0.y - 0.5)) * 0.5) + _Fade)
   >= 
    mix (0.5, 1.0, xlv_TEXCOORD0.x)
  ))));
  tmpvar_1 = tmpvar_6;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.y = xlv_TEXCOORD0.y;
  uv2_4.y = xlv_TEXCOORD0.y;
  uv1_5.x = (xlv_TEXCOORD0.x + _Fade);
  uv2_4.x = (xlv_TEXCOORD0.x - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.x)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.y = xlv_TEXCOORD0.y;
  uv2_4.y = xlv_TEXCOORD0.y;
  uv1_5.x = (xlv_TEXCOORD0.x + _Fade);
  uv2_4.x = (xlv_TEXCOORD0.x - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.x)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SLIDE_HORIZ" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.y = xlv_TEXCOORD0.y;
  uv2_4.y = xlv_TEXCOORD0.y;
  uv1_5.x = (xlv_TEXCOORD0.x + _Fade);
  uv2_4.x = (xlv_TEXCOORD0.x - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.x)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SLIDE_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.x = xlv_TEXCOORD0.x;
  uv2_4.x = xlv_TEXCOORD0.x;
  uv1_5.y = (xlv_TEXCOORD0.y + _Fade);
  uv2_4.y = (xlv_TEXCOORD0.y - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.y)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SLIDE_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.x = xlv_TEXCOORD0.x;
  uv2_4.x = xlv_TEXCOORD0.x;
  uv1_5.y = (xlv_TEXCOORD0.y + _Fade);
  uv2_4.y = (xlv_TEXCOORD0.y - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.y)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SLIDE_VERT" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  uv1_5.x = xlv_TEXCOORD0.x;
  uv2_4.x = xlv_TEXCOORD0.x;
  uv1_5.y = (xlv_TEXCOORD0.y + _Fade);
  uv2_4.y = (xlv_TEXCOORD0.y - (1.0 - _Fade));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (cola_3, colb_2, vec4(float((0.0 >= 
    (1.0 - uv1_5.y)
  ))));
  tmpvar_1 = tmpvar_8;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_ZOOM_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  uv1_5 = (tmpvar_6 * mix (1.0, 0.15, _Fade));
  uv2_4 = (tmpvar_6 * mix (1.0, 0.15, (1.0 - _Fade)));
  uv1_5 = (uv1_5 + 0.5);
  uv2_4 = (uv2_4 + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_Fade - 0.5) / 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (cola_3, colb_2, vec4((tmpvar_7 * (tmpvar_7 * 
    (3.0 - (2.0 * tmpvar_7))
  ))));
  tmpvar_1 = tmpvar_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_ZOOM_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  uv1_5 = (tmpvar_6 * mix (1.0, 0.15, _Fade));
  uv2_4 = (tmpvar_6 * mix (1.0, 0.15, (1.0 - _Fade)));
  uv1_5 = (uv1_5 + 0.5);
  uv2_4 = (uv2_4 + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_Fade - 0.5) / 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (cola_3, colb_2, vec4((tmpvar_7 * (tmpvar_7 * 
    (3.0 - (2.0 * tmpvar_7))
  ))));
  tmpvar_1 = tmpvar_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_ZOOM_FADE" }
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
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _FromTex;
uniform highp float _Fade;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec4 colb_2;
  highp vec4 cola_3;
  highp vec2 uv2_4;
  highp vec2 uv1_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD0 - 0.5);
  uv1_5 = (tmpvar_6 * mix (1.0, 0.15, _Fade));
  uv2_4 = (tmpvar_6 * mix (1.0, 0.15, (1.0 - _Fade)));
  uv1_5 = (uv1_5 + 0.5);
  uv2_4 = (uv2_4 + 0.5);
  highp float tmpvar_7;
  tmpvar_7 = clamp (((_Fade - 0.5) / 0.5), 0.0, 1.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_FromTex, uv1_5);
  cola_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv2_4);
  colb_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (cola_3, colb_2, vec4((tmpvar_7 * (tmpvar_7 * 
    (3.0 - (2.0 * tmpvar_7))
  ))));
  tmpvar_1 = tmpvar_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_NONE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_FADE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_BLACK" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_WHITE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_TRANSP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_HORIZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_HORIZ_MIRROR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_VERT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_VERT_MIRROR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAG_MIRROR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_CIRCLE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SCROLL_VERT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SCROLL_HORIZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_DIAMOND" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_BLINDS" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_RECTS_VERT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_ARROW" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SLIDE_HORIZ" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_SLIDE_VERT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LERP_ZOOM_FADE" }
""
}
}
}
}
}