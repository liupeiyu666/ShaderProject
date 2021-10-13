//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/StarStreakEx" {
Properties {
_MainTex ("Level0", 2D) = "" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 29232
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float stepSizeX;
uniform highp float stepSizeY;
uniform highp float Stride;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4.x = stepSizeX;
  tmpvar_4.y = stepSizeY;
  highp vec2 tmpvar_5;
  tmpvar_5.x = stepSizeX;
  tmpvar_5.y = stepSizeY;
  highp vec2 tmpvar_6;
  tmpvar_6.x = stepSizeX;
  tmpvar_6.y = stepSizeY;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + (tmpvar_4 * Stride));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + ((tmpvar_5 * 2.0) * Stride));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + ((tmpvar_6 * 3.0) * Stride));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 colorCoeff0;
uniform mediump vec4 colorCoeff1;
uniform mediump vec4 colorCoeff2;
uniform mediump vec4 colorCoeff3;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD3);
  gl_FragData[0] = (((
    (tmpvar_1 * colorCoeff0)
   + 
    (tmpvar_2 * colorCoeff1)
  ) + (tmpvar_3 * colorCoeff2)) + (tmpvar_4 * colorCoeff3));
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
uniform highp float stepSizeX;
uniform highp float stepSizeY;
uniform highp float Stride;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4.x = stepSizeX;
  tmpvar_4.y = stepSizeY;
  highp vec2 tmpvar_5;
  tmpvar_5.x = stepSizeX;
  tmpvar_5.y = stepSizeY;
  highp vec2 tmpvar_6;
  tmpvar_6.x = stepSizeX;
  tmpvar_6.y = stepSizeY;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + (tmpvar_4 * Stride));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + ((tmpvar_5 * 2.0) * Stride));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + ((tmpvar_6 * 3.0) * Stride));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 colorCoeff0;
uniform mediump vec4 colorCoeff1;
uniform mediump vec4 colorCoeff2;
uniform mediump vec4 colorCoeff3;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD3);
  gl_FragData[0] = (((
    (tmpvar_1 * colorCoeff0)
   + 
    (tmpvar_2 * colorCoeff1)
  ) + (tmpvar_3 * colorCoeff2)) + (tmpvar_4 * colorCoeff3));
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
uniform highp float stepSizeX;
uniform highp float stepSizeY;
uniform highp float Stride;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1;
  highp vec2 tmpvar_4;
  tmpvar_4.x = stepSizeX;
  tmpvar_4.y = stepSizeY;
  highp vec2 tmpvar_5;
  tmpvar_5.x = stepSizeX;
  tmpvar_5.y = stepSizeY;
  highp vec2 tmpvar_6;
  tmpvar_6.x = stepSizeX;
  tmpvar_6.y = stepSizeY;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + (tmpvar_4 * Stride));
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + ((tmpvar_5 * 2.0) * Stride));
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + ((tmpvar_6 * 3.0) * Stride));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 colorCoeff0;
uniform mediump vec4 colorCoeff1;
uniform mediump vec4 colorCoeff2;
uniform mediump vec4 colorCoeff3;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD3);
  gl_FragData[0] = (((
    (tmpvar_1 * colorCoeff0)
   + 
    (tmpvar_2 * colorCoeff1)
  ) + (tmpvar_3 * colorCoeff2)) + (tmpvar_4 * colorCoeff3));
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
}