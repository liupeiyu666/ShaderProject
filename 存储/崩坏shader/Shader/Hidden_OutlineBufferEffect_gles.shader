//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/OutlineBufferEffect" {
Properties {
_MainTex ("Sprite Texture", 2D) = "white" { }
_Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
}
SubShader {
 LOD 200
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 11107
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  mediump vec3 normal_8;
  normal_8 = tmpvar_7;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
  xlv_TEXCOORD2 = max (vec3(0.0, 0.0, 0.0), tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  mediump vec3 normal_8;
  normal_8 = tmpvar_7;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
  xlv_TEXCOORD2 = max (vec3(0.0, 0.0, 0.0), tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  mediump vec3 normal_8;
  normal_8 = tmpvar_7;
  mediump vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = normal_8;
  mediump vec3 res_10;
  mediump vec3 x_11;
  x_11.x = dot (unity_SHAr, tmpvar_9);
  x_11.y = dot (unity_SHAg, tmpvar_9);
  x_11.z = dot (unity_SHAb, tmpvar_9);
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_8.xyzz * normal_8.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  res_10 = (x_11 + (x1_12 + (unity_SHC.xyz * 
    ((normal_8.x * normal_8.x) - (normal_8.y * normal_8.y))
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = max (((1.055 * 
    pow (max (res_10, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_10 = tmpvar_14;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
  xlv_TEXCOORD2 = max (vec3(0.0, 0.0, 0.0), tmpvar_14);
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp float diff_10;
  mediump float tmpvar_11;
  tmpvar_11 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_10 = tmpvar_11;
  c_9.xyz = ((tmpvar_7 * tmpvar_1) * diff_10);
  c_9.w = 1.0;
  c_3.xyz = (c_9.xyz + tmpvar_7);
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 95219
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_10).xy).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_8 * tmpvar_1) * diff_14);
  c_13.w = 1.0;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_10).xy).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_8 * tmpvar_1) * diff_14);
  c_13.w = 1.0;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  lowp vec3 tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  tmpvar_5 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_8 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = xlv_TEXCOORD1;
  highp float tmpvar_11;
  tmpvar_11 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_10).xy).w;
  atten_4 = tmpvar_11;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_12;
  lowp vec4 c_13;
  lowp float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (0.0, dot (tmpvar_5, tmpvar_2));
  diff_14 = tmpvar_15;
  c_13.xyz = ((tmpvar_8 * tmpvar_1) * diff_14);
  c_13.w = 1.0;
  c_12.w = c_13.w;
  c_12.xyz = c_13.xyz;
  c_3.xyz = c_12.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 1.0;
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_3.xyz = c_9.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 1.0;
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_3.xyz = c_9.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp vec3 tmpvar_4;
  lowp vec3 lightDir_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  lightDir_5 = tmpvar_6;
  tmpvar_4 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _Color.xyz;
  tmpvar_7 = tmpvar_8;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_5;
  lowp vec4 c_9;
  lowp vec4 c_10;
  lowp float diff_11;
  mediump float tmpvar_12;
  tmpvar_12 = max (0.0, dot (tmpvar_4, tmpvar_2));
  diff_11 = tmpvar_12;
  c_10.xyz = ((tmpvar_7 * tmpvar_1) * diff_11);
  c_10.w = 1.0;
  c_9.w = c_10.w;
  c_9.xyz = c_10.xyz;
  c_3.xyz = c_9.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11);
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_12 = tmpvar_13.w;
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_14 = tmpvar_15.w;
  highp float tmpvar_16;
  tmpvar_16 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_12) * tmpvar_14);
  atten_4 = tmpvar_16;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_9 * tmpvar_1) * diff_19);
  c_18.w = 1.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.xyz = c_17.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11);
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_12 = tmpvar_13.w;
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_14 = tmpvar_15.w;
  highp float tmpvar_16;
  tmpvar_16 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_12) * tmpvar_14);
  atten_4 = tmpvar_16;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_9 * tmpvar_1) * diff_19);
  c_18.w = 1.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.xyz = c_17.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11);
  lowp float tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_12 = tmpvar_13.w;
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_14 = tmpvar_15.w;
  highp float tmpvar_16;
  tmpvar_16 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_12) * tmpvar_14);
  atten_4 = tmpvar_16;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_17;
  lowp vec4 c_18;
  lowp float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_19 = tmpvar_20;
  c_18.xyz = ((tmpvar_9 * tmpvar_1) * diff_19);
  c_18.w = 1.0;
  c_17.w = c_18.w;
  c_17.xyz = c_18.xyz;
  c_3.xyz = c_17.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  lowp vec3 tmpvar_6;
  lowp vec3 lightDir_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_7 = tmpvar_8;
  tmpvar_6 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _Color.xyz;
  tmpvar_9 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_11).xyz;
  highp float tmpvar_12;
  tmpvar_12 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec4 c_13;
  lowp vec4 c_14;
  lowp float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = max (0.0, dot (tmpvar_6, tmpvar_2));
  diff_15 = tmpvar_16;
  c_14.xyz = ((tmpvar_9 * tmpvar_1) * diff_15);
  c_14.w = 1.0;
  c_13.w = c_14.w;
  c_13.xyz = c_14.xyz;
  c_3.xyz = c_13.xyz;
  c_3.w = 1.0;
  gl_FragData[0] = c_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
 Pass {
  Name "PREPASS"
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 139541
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_3;
    pos_3.zw = tmpvar_1.zw;
    highp vec2 tmpvar_4;
    tmpvar_4 = (_ScreenParams.xy * 0.5);
    pos_3.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_4) + vec2(0.5, 0.5))
    ) / tmpvar_4) * _glesVertex.w);
    tmpvar_2 = pos_3;
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_2.xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_6));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_2).xyz;
}


#endif
#ifdef FRAGMENT
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  res_1.xyz = ((tmpvar_2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
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
  Name "PREPASS"
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "PREPASSFINAL" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 246213
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  light_3 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  lowp vec4 c_7;
  c_7.xyz = (tmpvar_4 * light_3.xyz);
  c_7.w = 1.0;
  c_2 = c_7;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = (tmpvar_4 * tmpvar_7.xyz);
  c_8.w = 1.0;
  c_2 = c_8;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = (tmpvar_4 * tmpvar_7.xyz);
  c_8.w = 1.0;
  c_2 = c_8;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_3.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD1 = o_8;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3 = tmpvar_7;
  lowp vec4 c_8;
  c_8.xyz = (tmpvar_4 * tmpvar_7.xyz);
  c_8.w = 1.0;
  c_2 = c_8;
  c_2.xyz = (c_2.xyz + tmpvar_4);
  c_2.w = 1.0;
  tmpvar_1 = c_2;
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
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "DEFERRED"
  LOD 200
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 278707
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_7));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outEmission_1;
  lowp vec3 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_3 = tmpvar_4;
  mediump vec4 emission_5;
  mediump vec3 tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_6 = tmpvar_3;
  tmpvar_7 = tmpvar_2;
  mediump vec4 outGBuffer2_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = tmpvar_6;
  tmpvar_9.w = 1.0;
  mediump vec4 tmpvar_10;
  tmpvar_10.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = ((tmpvar_7 * 0.5) + 0.5);
  outGBuffer2_8 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_3;
  emission_5 = tmpvar_12;
  emission_5.xyz = emission_5.xyz;
  outEmission_1.w = emission_5.w;
  outEmission_1.xyz = exp2(-(emission_5.xyz));
  gl_FragData[0] = tmpvar_9;
  gl_FragData[1] = tmpvar_10;
  gl_FragData[2] = outGBuffer2_8;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_2;
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_2;
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp float PixelSnap;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = tmpvar_1;
  if ((PixelSnap > 0.0)) {
    highp vec4 pos_4;
    pos_4.zw = tmpvar_1.zw;
    highp vec2 tmpvar_5;
    tmpvar_5 = (_ScreenParams.xy * 0.5);
    pos_4.xy = ((floor(
      (((_glesVertex.xy / _glesVertex.w) * tmpvar_5) + vec2(0.5, 0.5))
    ) / tmpvar_5) * _glesVertex.w);
    tmpvar_3 = pos_4;
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_3.xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = vec2(0.0, 0.0);
  mediump vec3 normal_9;
  normal_9 = tmpvar_8;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = normal_9;
  mediump vec3 res_11;
  mediump vec3 x_12;
  x_12.x = dot (unity_SHAr, tmpvar_10);
  x_12.y = dot (unity_SHAg, tmpvar_10);
  x_12.z = dot (unity_SHAb, tmpvar_10);
  mediump vec3 x1_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (normal_9.xyzz * normal_9.yzzx);
  x1_13.x = dot (unity_SHBr, tmpvar_14);
  x1_13.y = dot (unity_SHBg, tmpvar_14);
  x1_13.z = dot (unity_SHBb, tmpvar_14);
  res_11 = (x_12 + (x1_13 + (unity_SHC.xyz * 
    ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y))
  )));
  mediump vec3 tmpvar_15;
  tmpvar_15 = max (((1.055 * 
    pow (max (res_11, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_11 = tmpvar_15;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_8;
  xlv_TEXCOORD1 = (unity_ObjectToWorld * tmpvar_3).xyz;
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = max (vec3(0.0, 0.0, 0.0), tmpvar_15);
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform mediump vec4 _Color;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  tmpvar_3 = _Color.xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 emission_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_1;
  mediump vec4 outGBuffer2_7;
  mediump vec4 tmpvar_8;
  tmpvar_8.xyz = tmpvar_5;
  tmpvar_8.w = 1.0;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_9.w = 0.0;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = ((tmpvar_6 * 0.5) + 0.5);
  outGBuffer2_7 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_2;
  emission_4 = tmpvar_11;
  emission_4.xyz = emission_4.xyz;
  gl_FragData[0] = tmpvar_8;
  gl_FragData[1] = tmpvar_9;
  gl_FragData[2] = outGBuffer2_7;
  gl_FragData[3] = emission_4;
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
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
}
}
}
Fallback "Transparent/VertexLit"
}