//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/Scene/Main Menu Glitter Only Reflection" {
Properties {
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 24690
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  col_4 = mix (col_4, vec3(dot (col_4, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  col_4 = mix (col_4, vec3(dot (col_4, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
uniform mediump float _BuildingLightingScintillationScaleLayer1;
uniform mediump float _BuildingLightingScintillationSpeedLayer1;
uniform mediump float _BuildingLightingScintillationScaleLayer2;
uniform mediump float _BuildingLightingScintillationSpeedLayer2;
uniform mediump float _CarLeftMovingSpeed;
uniform mediump float _CarRightMovingSpeed;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer1);
  tmpvar_5.x = (tmpvar_6 * 0.4);
  tmpvar_5.y = (tmpvar_6 * 0.2);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer1) + tmpvar_5);
  highp vec2 tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_GameTime.y * _BuildingLightingScintillationSpeedLayer2);
  tmpvar_7.x = (tmpvar_8 * 0.2);
  tmpvar_7.y = (tmpvar_8 * 0.4);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _BuildingLightingScintillationScaleLayer2) + tmpvar_7);
  highp vec2 tmpvar_9;
  tmpvar_9.y = 0.0;
  tmpvar_9.x = (_GameTime.x * _CarLeftMovingSpeed);
  tmpvar_3.xy = (tmpvar_1 + tmpvar_9);
  highp vec2 tmpvar_10;
  tmpvar_10.y = 0.0;
  tmpvar_10.x = (-(_GameTime.x) * _CarRightMovingSpeed);
  tmpvar_3.zw = (tmpvar_1 + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _CarLightingTex;
uniform sampler2D _NoiseTex;
uniform mediump float _BuildingLightingBrightness;
uniform mediump float _CarLightingBrightness;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 carLighting_1;
  mediump float buildingLightingScintillationLayer2_2;
  mediump float buildingLightingScintillationLayer1_3;
  mediump vec3 col_4;
  mediump vec3 glitterTex_5;
  mediump vec4 mainTex_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_5 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w;
  buildingLightingScintillationLayer1_3 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w;
  buildingLightingScintillationLayer2_2 = tmpvar_10;
  col_4 = (((glitterTex_5.y * mainTex_6.xyz) * (_BuildingLightingBrightness * buildingLightingScintillationLayer1_3)) * (buildingLightingScintillationLayer2_2 * 3.0));
  lowp vec3 tmpvar_11;
  tmpvar_11 = (texture2D (_CarLightingTex, xlv_TEXCOORD2.xy).xyz + texture2D (_CarLightingTex, xlv_TEXCOORD2.zw).xyz);
  carLighting_1 = tmpvar_11;
  col_4 = (col_4 + ((carLighting_1 * _CarLightingBrightness) * buildingLightingScintillationLayer1_3));
  col_4 = mix (col_4, vec3(dot (col_4, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = col_4;
  gl_FragData[0] = tmpvar_12;
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
Fallback "Diffuse"
}