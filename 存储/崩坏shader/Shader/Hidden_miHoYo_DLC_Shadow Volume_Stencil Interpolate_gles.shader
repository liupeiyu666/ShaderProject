//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Shadow Volume/Stencil Interpolate" {
Properties {
}
SubShader {
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 29565
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp float _ShadowTransparency;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(_ShadowTransparency);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp float _ShadowTransparency;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(_ShadowTransparency);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.zw = vec2(0.0, 1.0);
  tmpvar_1.xy = _glesVertex.xy;
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesVertex.xy + 1.0) * 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp float _ShadowTransparency;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = vec4(_ShadowTransparency);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
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