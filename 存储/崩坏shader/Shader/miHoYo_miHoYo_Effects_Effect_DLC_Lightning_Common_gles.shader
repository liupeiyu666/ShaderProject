//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Lightning_Common" {
Properties {
_Color ("Main Color", Color) = (0.5,0.15,1,1)
_ColorLgiht ("Light Color", Color) = (1,1,1,1)
_MainTex ("MainTex (RGBA)", 2D) = "white" { }
_TimeScale ("Time Scale", Range(0, 1)) = 0.5
_ShineLoop ("Shine Loop Time", Range(0, 0.2)) = 0.05
_DirLoop ("Change Dir Loop Time", Range(0, 1)) = 0.5
_DirStrength ("Dir Move Strength", Range(0, 2)) = 0.2
_ShineSpeed ("Shine Speed", Range(0, 40)) = 20
_MoveRange ("Move Range", Range(0, 2)) = 0.1
_LightSpeed ("Light Speed", Range(0, 40)) = 20
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 50443
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y * _TimeScale);
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_6 / _ShineLoop);
  highp float tmpvar_8;
  tmpvar_8 = (fract(abs(tmpvar_7)) * _ShineLoop);
  highp float tmpvar_9;
  if ((tmpvar_7 >= 0.0)) {
    tmpvar_9 = tmpvar_8;
  } else {
    tmpvar_9 = -(tmpvar_8);
  };
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_2.x;
  tmpvar_10.y = (tmpvar_6 - tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DLod (_MainTex, tmpvar_10, 0.0);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y / _DirLoop);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * _DirLoop);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_17;
  norm_17 = tmpvar_4;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (tmpvar_12.xyz * _MoveRange);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = ((tmpvar_16.w * (
    (float((tmpvar_15 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_17 * tmpvar_18)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_19)
  ) + tmpvar_20) + (tmpvar_21 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp vec4 _ColorLgiht;
uniform highp float _LightSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Time.y * _LightSpeed);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.x * 6.0);
  tmpvar_3 = clamp (((
    max (sin((tmpvar_4 + tmpvar_2)), sin((tmpvar_4 - tmpvar_2)))
   - 0.8) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (_Color, _ColorLgiht, vec4((tmpvar_3 * (tmpvar_3 * 
    (3.0 - (2.0 * tmpvar_3))
  ))));
  color_1.xyz = tmpvar_5.xyz;
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y * _TimeScale);
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_6 / _ShineLoop);
  highp float tmpvar_8;
  tmpvar_8 = (fract(abs(tmpvar_7)) * _ShineLoop);
  highp float tmpvar_9;
  if ((tmpvar_7 >= 0.0)) {
    tmpvar_9 = tmpvar_8;
  } else {
    tmpvar_9 = -(tmpvar_8);
  };
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_2.x;
  tmpvar_10.y = (tmpvar_6 - tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DLod (_MainTex, tmpvar_10, 0.0);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y / _DirLoop);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * _DirLoop);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_17;
  norm_17 = tmpvar_4;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (tmpvar_12.xyz * _MoveRange);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = ((tmpvar_16.w * (
    (float((tmpvar_15 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_17 * tmpvar_18)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_19)
  ) + tmpvar_20) + (tmpvar_21 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp vec4 _ColorLgiht;
uniform highp float _LightSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Time.y * _LightSpeed);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.x * 6.0);
  tmpvar_3 = clamp (((
    max (sin((tmpvar_4 + tmpvar_2)), sin((tmpvar_4 - tmpvar_2)))
   - 0.8) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (_Color, _ColorLgiht, vec4((tmpvar_3 * (tmpvar_3 * 
    (3.0 - (2.0 * tmpvar_3))
  ))));
  color_1.xyz = tmpvar_5.xyz;
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = _glesColor;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  highp float tmpvar_6;
  tmpvar_6 = (_Time.y * _TimeScale);
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_6 / _ShineLoop);
  highp float tmpvar_8;
  tmpvar_8 = (fract(abs(tmpvar_7)) * _ShineLoop);
  highp float tmpvar_9;
  if ((tmpvar_7 >= 0.0)) {
    tmpvar_9 = tmpvar_8;
  } else {
    tmpvar_9 = -(tmpvar_8);
  };
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_2.x;
  tmpvar_10.y = (tmpvar_6 - tmpvar_9);
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DLod (_MainTex, tmpvar_10, 0.0);
  highp vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_11 * 2.0) - 1.0);
  highp float tmpvar_13;
  tmpvar_13 = (_Time.y / _DirLoop);
  highp float tmpvar_14;
  tmpvar_14 = (fract(abs(tmpvar_13)) * _DirLoop);
  highp float tmpvar_15;
  if ((tmpvar_13 >= 0.0)) {
    tmpvar_15 = tmpvar_14;
  } else {
    tmpvar_15 = -(tmpvar_14);
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_17;
  norm_17 = tmpvar_4;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_WorldToObject[0].xyz;
  tmpvar_18[1] = unity_WorldToObject[1].xyz;
  tmpvar_18[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_19;
  tmpvar_19.w = 1.0;
  tmpvar_19.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (tmpvar_12.xyz * _MoveRange);
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = ((tmpvar_16.w * (
    (float((tmpvar_15 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_17 * tmpvar_18)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_19)
  ) + tmpvar_20) + (tmpvar_21 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _Color;
uniform highp vec4 _ColorLgiht;
uniform highp float _LightSpeed;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 color_1;
  highp float tmpvar_2;
  tmpvar_2 = (_Time.y * _LightSpeed);
  highp float tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = (xlv_TEXCOORD0.x * 6.0);
  tmpvar_3 = clamp (((
    max (sin((tmpvar_4 + tmpvar_2)), sin((tmpvar_4 - tmpvar_2)))
   - 0.8) / 0.2), 0.0, 1.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = mix (_Color, _ColorLgiht, vec4((tmpvar_3 * (tmpvar_3 * 
    (3.0 - (2.0 * tmpvar_3))
  ))));
  color_1.xyz = tmpvar_5.xyz;
  color_1.w = clamp (tmpvar_5.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 108844
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
uniform sampler2D _MainTex;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = tmpvar_2.w;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _TimeScale);
  highp float tmpvar_8;
  tmpvar_8 = (tmpvar_7 / _ShineLoop);
  highp float tmpvar_9;
  tmpvar_9 = (fract(abs(tmpvar_8)) * _ShineLoop);
  highp float tmpvar_10;
  if ((tmpvar_8 >= 0.0)) {
    tmpvar_10 = tmpvar_9;
  } else {
    tmpvar_10 = -(tmpvar_9);
  };
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3.x;
  tmpvar_11.y = (tmpvar_7 - tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_MainTex, tmpvar_11, 0.0);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * 2.0) - 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (_Time.y / _DirLoop);
  highp float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _DirLoop);
  highp float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_18;
  norm_18 = tmpvar_4;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = (tmpvar_13.xyz * _MoveRange);
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = ((tmpvar_17.w * (
    (float((tmpvar_16 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_18 * tmpvar_19)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_20)
  ) + tmpvar_21) + (tmpvar_22 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _BloomFactor;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
uniform sampler2D _MainTex;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = tmpvar_2.w;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _TimeScale);
  highp float tmpvar_8;
  tmpvar_8 = (tmpvar_7 / _ShineLoop);
  highp float tmpvar_9;
  tmpvar_9 = (fract(abs(tmpvar_8)) * _ShineLoop);
  highp float tmpvar_10;
  if ((tmpvar_8 >= 0.0)) {
    tmpvar_10 = tmpvar_9;
  } else {
    tmpvar_10 = -(tmpvar_9);
  };
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3.x;
  tmpvar_11.y = (tmpvar_7 - tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_MainTex, tmpvar_11, 0.0);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * 2.0) - 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (_Time.y / _DirLoop);
  highp float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _DirLoop);
  highp float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_18;
  norm_18 = tmpvar_4;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = (tmpvar_13.xyz * _MoveRange);
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = ((tmpvar_17.w * (
    (float((tmpvar_16 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_18 * tmpvar_19)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_20)
  ) + tmpvar_21) + (tmpvar_22 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _BloomFactor;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float _TimeScale;
uniform highp float _ShineLoop;
uniform highp float _DirLoop;
uniform highp float _MoveRange;
uniform highp float _DirStrength;
uniform sampler2D _MainTex;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _glesNormal;
  highp vec4 tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = tmpvar_2.w;
  highp float tmpvar_7;
  tmpvar_7 = (_Time.y * _TimeScale);
  highp float tmpvar_8;
  tmpvar_8 = (tmpvar_7 / _ShineLoop);
  highp float tmpvar_9;
  tmpvar_9 = (fract(abs(tmpvar_8)) * _ShineLoop);
  highp float tmpvar_10;
  if ((tmpvar_8 >= 0.0)) {
    tmpvar_10 = tmpvar_9;
  } else {
    tmpvar_10 = -(tmpvar_9);
  };
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_3.x;
  tmpvar_11.y = (tmpvar_7 - tmpvar_10);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_MainTex, tmpvar_11, 0.0);
  highp vec4 tmpvar_13;
  tmpvar_13 = ((tmpvar_12 * 2.0) - 1.0);
  highp float tmpvar_14;
  tmpvar_14 = (_Time.y / _DirLoop);
  highp float tmpvar_15;
  tmpvar_15 = (fract(abs(tmpvar_14)) * _DirLoop);
  highp float tmpvar_16;
  if ((tmpvar_14 >= 0.0)) {
    tmpvar_16 = tmpvar_15;
  } else {
    tmpvar_16 = -(tmpvar_15);
  };
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DLod (_MainTex, _glesMultiTexCoord0.xy, 0.0);
  highp vec3 norm_18;
  norm_18 = tmpvar_4;
  highp mat3 tmpvar_19;
  tmpvar_19[0] = unity_WorldToObject[0].xyz;
  tmpvar_19[1] = unity_WorldToObject[1].xyz;
  tmpvar_19[2] = unity_WorldToObject[2].xyz;
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 0.0;
  tmpvar_21.xyz = (tmpvar_13.xyz * _MoveRange);
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = ((tmpvar_17.w * (
    (float((tmpvar_16 >= -(
      (_DirLoop * -0.5)
    ))) * 2.0)
   - 1.0)) * normalize((norm_18 * tmpvar_19)));
  tmpvar_5 = (((unity_MatrixVP * 
    (unity_ObjectToWorld * tmpvar_20)
  ) + tmpvar_21) + (tmpvar_22 * _DirStrength));
  gl_Position = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp float _BloomFactor;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
}