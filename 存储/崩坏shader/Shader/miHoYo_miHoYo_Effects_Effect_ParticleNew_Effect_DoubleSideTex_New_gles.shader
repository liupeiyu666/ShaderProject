//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_DoubleSideTex_New" {
Properties {
_FrontTex ("FrontTex", 2D) = "white" { }
_FrontColor ("FrontColor", Color) = (1,1,1,0)
_FrontIntensity ("FrontIntensity", Float) = 1
_BackTex ("BackTex", 2D) = "white" { }
_BackColor ("BackColor", Color) = (1,1,1,0)
_BackIntensity ("BackIntensity", Float) = 1
[Enum(r, 0, a, 1)] _Channel ("AlphaChannel", Float) = 0
[Enum(Add, 1, AlphaBlend,5)] _SrcBlend ("Src Blend Mode", Float) = 1
[Enum(Add, 1, AlphaBlend, 10)] _DstBlend ("Dst Blend Mode", Float) = 1
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 61273
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FrontTex;
uniform highp vec4 _FrontTex_ST;
uniform highp float _FrontIntensity;
uniform highp vec4 _FrontColor;
uniform sampler2D _BackTex;
uniform highp vec4 _BackTex_ST;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Channel;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _BackTex_ST.xy) + _BackTex_ST.zw);
  highp vec4 tmpvar_6;
  if ((tmpvar_1 > 0.0)) {
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_FrontTex, tmpvar_4);
    tmpvar_6 = ((tmpvar_7 * _FrontIntensity) * _FrontColor);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_BackTex, tmpvar_5);
    tmpvar_6 = ((tmpvar_8 * _BackColor) * _BackIntensity);
  };
  aseOutAlpha_3 = 0.0;
  if ((_Channel == 0.0)) {
    aseOutAlpha_3 = (tmpvar_6.x * xlv_COLOR.w);
  } else {
    if ((_Channel == 1.0)) {
      aseOutAlpha_3 = (tmpvar_6.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyz * xlv_COLOR.xyz);
  aseOutColor_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = aseOutColor_2;
  tmpvar_10.w = aseOutAlpha_3;
  gl_FragData[0] = tmpvar_10;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FrontTex;
uniform highp vec4 _FrontTex_ST;
uniform highp float _FrontIntensity;
uniform highp vec4 _FrontColor;
uniform sampler2D _BackTex;
uniform highp vec4 _BackTex_ST;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Channel;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _BackTex_ST.xy) + _BackTex_ST.zw);
  highp vec4 tmpvar_6;
  if ((tmpvar_1 > 0.0)) {
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_FrontTex, tmpvar_4);
    tmpvar_6 = ((tmpvar_7 * _FrontIntensity) * _FrontColor);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_BackTex, tmpvar_5);
    tmpvar_6 = ((tmpvar_8 * _BackColor) * _BackIntensity);
  };
  aseOutAlpha_3 = 0.0;
  if ((_Channel == 0.0)) {
    aseOutAlpha_3 = (tmpvar_6.x * xlv_COLOR.w);
  } else {
    if ((_Channel == 1.0)) {
      aseOutAlpha_3 = (tmpvar_6.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyz * xlv_COLOR.xyz);
  aseOutColor_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = aseOutColor_2;
  tmpvar_10.w = aseOutAlpha_3;
  gl_FragData[0] = tmpvar_10;
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
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _FrontTex;
uniform highp vec4 _FrontTex_ST;
uniform highp float _FrontIntensity;
uniform highp vec4 _FrontColor;
uniform sampler2D _BackTex;
uniform highp vec4 _BackTex_ST;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Channel;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump float tmpvar_1;
  if (gl_FrontFacing) {
    tmpvar_1 = 1.0;
  } else {
    tmpvar_1 = -1.0;
  };
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _FrontTex_ST.xy) + _FrontTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _BackTex_ST.xy) + _BackTex_ST.zw);
  highp vec4 tmpvar_6;
  if ((tmpvar_1 > 0.0)) {
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_FrontTex, tmpvar_4);
    tmpvar_6 = ((tmpvar_7 * _FrontIntensity) * _FrontColor);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_BackTex, tmpvar_5);
    tmpvar_6 = ((tmpvar_8 * _BackColor) * _BackIntensity);
  };
  aseOutAlpha_3 = 0.0;
  if ((_Channel == 0.0)) {
    aseOutAlpha_3 = (tmpvar_6.x * xlv_COLOR.w);
  } else {
    if ((_Channel == 1.0)) {
      aseOutAlpha_3 = (tmpvar_6.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_6.xyz * xlv_COLOR.xyz);
  aseOutColor_2 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = aseOutColor_2;
  tmpvar_10.w = aseOutAlpha_3;
  gl_FragData[0] = tmpvar_10;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}