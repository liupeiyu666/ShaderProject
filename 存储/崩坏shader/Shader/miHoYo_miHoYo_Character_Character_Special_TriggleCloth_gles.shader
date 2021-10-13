//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Special/TriggleCloth" {
Properties {
_NormalCloth ("NormalClothTexture", 2D) = "bump" { }
_BackColor ("BackColor", Color) = (0,0,0,0)
_NormalGloss ("NormalGloss", Range(0, 6)) = 1
_NormalIntensity ("NormalIntensity", Range(0.99, 1.01)) = 0.4
_NormalColor ("NormalColor", Color) = (0,0,0,0)
_NormalColorIntensity ("NormalColorIntensity", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 29423
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _NormalCloth;
uniform highp vec4 _NormalCloth_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalGloss;
uniform highp vec4 _NormalColor;
uniform highp float _NormalColorIntensity;
uniform highp vec4 _BackColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _NormalCloth_ST.xy) + _NormalCloth_ST.zw);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalCloth, tmpvar_2).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_4;
  tmpvar_4 = (((
    pow (dot (normalize((
      (_WorldSpaceLightPos0.xyz - (xlv_TEXCOORD3.xyz * _WorldSpaceLightPos0.w))
     + 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), (tmpvar_3 * _NormalIntensity)), (_NormalGloss * 100.0))
   * _NormalColor) * (_NormalColorIntensity * 0.1)) + _BackColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _NormalCloth;
uniform highp vec4 _NormalCloth_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalGloss;
uniform highp vec4 _NormalColor;
uniform highp float _NormalColorIntensity;
uniform highp vec4 _BackColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _NormalCloth_ST.xy) + _NormalCloth_ST.zw);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalCloth, tmpvar_2).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_4;
  tmpvar_4 = (((
    pow (dot (normalize((
      (_WorldSpaceLightPos0.xyz - (xlv_TEXCOORD3.xyz * _WorldSpaceLightPos0.w))
     + 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), (tmpvar_3 * _NormalIntensity)), (_NormalGloss * 100.0))
   * _NormalColor) * (_NormalColorIntensity * 0.1)) + _BackColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _NormalCloth;
uniform highp vec4 _NormalCloth_ST;
uniform highp float _NormalIntensity;
uniform highp float _NormalGloss;
uniform highp vec4 _NormalColor;
uniform highp float _NormalColorIntensity;
uniform highp vec4 _BackColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((xlv_TEXCOORD0.xy * _NormalCloth_ST.xy) + _NormalCloth_ST.zw);
  lowp vec3 tmpvar_3;
  tmpvar_3 = ((texture2D (_NormalCloth, tmpvar_2).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_4;
  tmpvar_4 = (((
    pow (dot (normalize((
      (_WorldSpaceLightPos0.xyz - (xlv_TEXCOORD3.xyz * _WorldSpaceLightPos0.w))
     + 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), (tmpvar_3 * _NormalIntensity)), (_NormalGloss * 100.0))
   * _NormalColor) * (_NormalColorIntensity * 0.1)) + _BackColor).xyz;
  aseOutColor_1 = tmpvar_4;
  mediump vec4 tmpvar_5;
  tmpvar_5.xyz = aseOutColor_1;
  tmpvar_5.w = 1.0;
  gl_FragData[0] = tmpvar_5;
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
CustomEditor "ASEMaterialInspector"
}