//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_PlaneClip" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
[Toggle(CLIP_PLANE_WORLD)] _ClipPlaneWorld ("Clip Plane In World Space", Float) = 0
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 33912
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = 0.0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_5;
  vertex_5 = tmpvar_1;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_7 < (_ClipPlane.w - 0.01))) {
    vertex_5.xyz = (_glesVertex.xyz - ((tmpvar_7 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_6 = 0.0;
  } else {
    tmpvar_6 = 1.0;
  };
  tmpvar_1 = vertex_5;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vertex_5.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_8 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_8.zw;
    tmpvar_4.xyw = o_10.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((tmpvar_2.xyz * _EnvColor.xyz) * xlv_COLOR.xyz);
  outColor_1.w = _BloomFactor;
  mediump float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD2;
    mediump float a_5;
    a_5 = xlv_TEXCOORD2.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = 0.0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_5;
  vertex_5 = tmpvar_1;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_7 < (_ClipPlane.w - 0.01))) {
    vertex_5.xyz = (_glesVertex.xyz - ((tmpvar_7 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_6 = 0.0;
  } else {
    tmpvar_6 = 1.0;
  };
  tmpvar_1 = vertex_5;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vertex_5.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_8 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_8.zw;
    tmpvar_4.xyw = o_10.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((tmpvar_2.xyz * _EnvColor.xyz) * xlv_COLOR.xyz);
  outColor_1.w = _BloomFactor;
  mediump float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD2;
    mediump float a_5;
    a_5 = xlv_TEXCOORD2.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump vec4 _MainColor;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec2 tmpvar_2;
  mediump float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_2 = vec2(0.0, 0.0);
  tmpvar_3 = 0.0;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_5;
  vertex_5 = tmpvar_1;
  highp float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_7 < (_ClipPlane.w - 0.01))) {
    vertex_5.xyz = (_glesVertex.xyz - ((tmpvar_7 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_6 = 0.0;
  } else {
    tmpvar_6 = 1.0;
  };
  tmpvar_1 = vertex_5;
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = vertex_5.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_10;
    highp vec4 tmpvar_11;
    tmpvar_11 = (tmpvar_8 * 0.5);
    highp vec2 tmpvar_12;
    tmpvar_12.x = tmpvar_11.x;
    tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
    o_10.xy = (tmpvar_12 + tmpvar_11.w);
    o_10.zw = tmpvar_8.zw;
    tmpvar_4.xyw = o_10.xyw;
    tmpvar_4.z = _DitherAlpha;
  };
  gl_Position = tmpvar_8;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _MainColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform highp float _UsingDitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
varying mediump float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((tmpvar_2.xyz * _EnvColor.xyz) * xlv_COLOR.xyz);
  outColor_1.w = _BloomFactor;
  mediump float x_3;
  x_3 = (xlv_TEXCOORD1 - 0.001);
  if ((x_3 < 0.0)) {
    discard;
  };
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_4;
    scrpos_4 = xlv_TEXCOORD2;
    mediump float a_5;
    a_5 = xlv_TEXCOORD2.z;
    if ((a_5 < 0.95)) {
      scrpos_4.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_5 = (a_5 * 17.0);
      highp float tmpvar_6;
      tmpvar_6 = (scrpos_4.y / 4.0);
      highp float tmpvar_7;
      tmpvar_7 = (fract(abs(tmpvar_6)) * 4.0);
      highp float tmpvar_8;
      if ((tmpvar_6 >= 0.0)) {
        tmpvar_8 = tmpvar_7;
      } else {
        tmpvar_8 = -(tmpvar_7);
      };
      highp float tmpvar_9;
      tmpvar_9 = (scrpos_4.x / 4.0);
      highp float tmpvar_10;
      tmpvar_10 = (fract(abs(tmpvar_9)) * 4.0);
      highp float tmpvar_11;
      if ((tmpvar_9 >= 0.0)) {
        tmpvar_11 = tmpvar_10;
      } else {
        tmpvar_11 = -(tmpvar_10);
      };
      highp float x_12;
      x_12 = ((a_5 - _DITHERMATRIX[
        int(tmpvar_8)
      ][
        int(tmpvar_11)
      ]) - 0.01);
      if ((x_12 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_1;
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
CustomEditor "MoleMole.PropShaderEditorBase"
}