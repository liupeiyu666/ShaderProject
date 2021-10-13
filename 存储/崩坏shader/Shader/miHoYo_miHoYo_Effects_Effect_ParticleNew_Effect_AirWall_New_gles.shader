//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AirWall_New" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_UvTilling ("UvTilling", Vector) = (200,25,0,0)
_MainIntensity ("MainIntensity", Float) = 1
_MainColor ("MainColor", Color) = (0,0,0,0)
_BackIntensity ("BackIntensity", Float) = 1
_BackColor ("BackColor", Color) = (0,0,0,0)
_Range ("Range", Range(-10, 0)) = -2.6
_RangeWidth ("RangeWidth", Range(0, 10)) = 5
_UVTexture ("UVTexture", 2D) = "white" { }
_Position ("Position", Vector) = (0.2,0.39,0,0)
_AirWallPosition ("AirWallPosition", Vector) = (0,0,0,0)
_Distance ("Distance", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 6411
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_ObjectToWorld;
uniform sampler2D _MainTex;
uniform highp vec3 _Position;
uniform highp float _UpOffset;
uniform highp vec3 _AirWallPosition;
uniform sampler2D _UVTexture;
uniform highp vec2 _UvTilling;
uniform highp float _Range;
uniform highp float _RangeWidth;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Distance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode200_4;
  highp vec4 tex2DNode56_5;
  highp vec4 tex2DNode95_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = xlv_TEXCOORD3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _Position;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _AirWallPosition;
  highp vec4 tmpvar_10;
  tmpvar_10 = (((tmpvar_8 - 
    (unity_ObjectToWorld * tmpvar_7)
  ) - vec4((_Position.y * _UpOffset))) - tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11.x = 0.0;
  tmpvar_11.y = tmpvar_10.y;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD1.xy + tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy * (_UvTilling / vec2(2.0, 2.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_UVTexture, tmpvar_13);
  tex2DNode95_6 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (float((0.5 >= tex2DNode95_6.y)) * float((0.5 >= tex2DNode95_6.x)));
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD0.xy * _UvTilling);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_UVTexture, tmpvar_16);
  tex2DNode56_5 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.zw = vec2(0.0, 0.0);
  tmpvar_18.xy = tex2DNode56_5.xy;
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - (sqrt(dot (tmpvar_10, tmpvar_10)) * _Distance))
   - _Range) / (
    (_Range + _RangeWidth)
   - _Range)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )), 0.0, 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_18, vec4(0.5, 0.5, 0.0, 0.0), vec4(clamp (tmpvar_20, 0.0, 1.0)));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_21.xy);
  tex2DNode200_4 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_12);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_23.z * ((
    (tmpvar_15 * tex2DNode200_4.x)
   + 
    ((1.0 - tmpvar_15) * tex2DNode200_4.y)
  ) * tmpvar_20));
  aseOutAlpha_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  if ((tmpvar_1 > 0.0)) {
    tmpvar_25 = (_MainColor * _MainIntensity);
  } else {
    tmpvar_25 = (_BackColor * _BackIntensity);
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = tmpvar_25.xyz;
  aseOutColor_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (aseOutAlpha_3, 0.0, 1.0);
  aseOutAlpha_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = aseOutColor_2;
  tmpvar_28.w = tmpvar_27;
  gl_FragData[0] = tmpvar_28;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_ObjectToWorld;
uniform sampler2D _MainTex;
uniform highp vec3 _Position;
uniform highp float _UpOffset;
uniform highp vec3 _AirWallPosition;
uniform sampler2D _UVTexture;
uniform highp vec2 _UvTilling;
uniform highp float _Range;
uniform highp float _RangeWidth;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Distance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode200_4;
  highp vec4 tex2DNode56_5;
  highp vec4 tex2DNode95_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = xlv_TEXCOORD3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _Position;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _AirWallPosition;
  highp vec4 tmpvar_10;
  tmpvar_10 = (((tmpvar_8 - 
    (unity_ObjectToWorld * tmpvar_7)
  ) - vec4((_Position.y * _UpOffset))) - tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11.x = 0.0;
  tmpvar_11.y = tmpvar_10.y;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD1.xy + tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy * (_UvTilling / vec2(2.0, 2.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_UVTexture, tmpvar_13);
  tex2DNode95_6 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (float((0.5 >= tex2DNode95_6.y)) * float((0.5 >= tex2DNode95_6.x)));
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD0.xy * _UvTilling);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_UVTexture, tmpvar_16);
  tex2DNode56_5 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.zw = vec2(0.0, 0.0);
  tmpvar_18.xy = tex2DNode56_5.xy;
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - (sqrt(dot (tmpvar_10, tmpvar_10)) * _Distance))
   - _Range) / (
    (_Range + _RangeWidth)
   - _Range)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )), 0.0, 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_18, vec4(0.5, 0.5, 0.0, 0.0), vec4(clamp (tmpvar_20, 0.0, 1.0)));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_21.xy);
  tex2DNode200_4 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_12);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_23.z * ((
    (tmpvar_15 * tex2DNode200_4.x)
   + 
    ((1.0 - tmpvar_15) * tex2DNode200_4.y)
  ) * tmpvar_20));
  aseOutAlpha_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  if ((tmpvar_1 > 0.0)) {
    tmpvar_25 = (_MainColor * _MainIntensity);
  } else {
    tmpvar_25 = (_BackColor * _BackIntensity);
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = tmpvar_25.xyz;
  aseOutColor_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (aseOutAlpha_3, 0.0, 1.0);
  aseOutAlpha_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = aseOutColor_2;
  tmpvar_28.w = tmpvar_27;
  gl_FragData[0] = tmpvar_28;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD3 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_ObjectToWorld;
uniform sampler2D _MainTex;
uniform highp vec3 _Position;
uniform highp float _UpOffset;
uniform highp vec3 _AirWallPosition;
uniform sampler2D _UVTexture;
uniform highp vec2 _UvTilling;
uniform highp float _Range;
uniform highp float _RangeWidth;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _BackColor;
uniform highp float _BackIntensity;
uniform highp float _Distance;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
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
  highp vec4 tex2DNode200_4;
  highp vec4 tex2DNode56_5;
  highp vec4 tex2DNode95_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 0.0;
  tmpvar_7.xyz = xlv_TEXCOORD3.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _Position;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 0.0;
  tmpvar_9.xyz = _AirWallPosition;
  highp vec4 tmpvar_10;
  tmpvar_10 = (((tmpvar_8 - 
    (unity_ObjectToWorld * tmpvar_7)
  ) - vec4((_Position.y * _UpOffset))) - tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11.x = 0.0;
  tmpvar_11.y = tmpvar_10.y;
  highp vec2 tmpvar_12;
  tmpvar_12 = (xlv_TEXCOORD1.xy + tmpvar_11);
  highp vec2 tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.xy * (_UvTilling / vec2(2.0, 2.0)));
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_UVTexture, tmpvar_13);
  tex2DNode95_6 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = (float((0.5 >= tex2DNode95_6.y)) * float((0.5 >= tex2DNode95_6.x)));
  highp vec2 tmpvar_16;
  tmpvar_16 = (xlv_TEXCOORD0.xy * _UvTilling);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_UVTexture, tmpvar_16);
  tex2DNode56_5 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.zw = vec2(0.0, 0.0);
  tmpvar_18.xy = tex2DNode56_5.xy;
  highp float tmpvar_19;
  tmpvar_19 = clamp (((
    (1.0 - (sqrt(dot (tmpvar_10, tmpvar_10)) * _Distance))
   - _Range) / (
    (_Range + _RangeWidth)
   - _Range)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )), 0.0, 1.0);
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (tmpvar_18, vec4(0.5, 0.5, 0.0, 0.0), vec4(clamp (tmpvar_20, 0.0, 1.0)));
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_21.xy);
  tex2DNode200_4 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_12);
  highp float tmpvar_24;
  tmpvar_24 = (tmpvar_23.z * ((
    (tmpvar_15 * tex2DNode200_4.x)
   + 
    ((1.0 - tmpvar_15) * tex2DNode200_4.y)
  ) * tmpvar_20));
  aseOutAlpha_3 = tmpvar_24;
  highp vec4 tmpvar_25;
  if ((tmpvar_1 > 0.0)) {
    tmpvar_25 = (_MainColor * _MainIntensity);
  } else {
    tmpvar_25 = (_BackColor * _BackIntensity);
  };
  highp vec3 tmpvar_26;
  tmpvar_26 = tmpvar_25.xyz;
  aseOutColor_2 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp (aseOutAlpha_3, 0.0, 1.0);
  aseOutAlpha_3 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = aseOutColor_2;
  tmpvar_28.w = tmpvar_27;
  gl_FragData[0] = tmpvar_28;
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