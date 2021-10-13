//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Cloud3D" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_TileSize ("Tile Size", Vector) = (1,1,0,1)
_EmitterWidth ("Emitter Width", Float) = 1
_AspectRatio ("Aspect Ratio", Float) = 1
_BrightColor ("Bright Color", Color) = (1,1,1,1)
_DarkColor ("Dark Color", Color) = (1,1,1,1)
_SecondDarkColor ("Second Dark Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_RimShininess ("Rim Shininess", Range(0, 10)) = 1
_RimThreshold ("Rim Threshold", Range(0, 2)) = 0.1
_RimIntensity ("Rim Intensity", Range(0, 2)) = 0
_FlashColor ("Flash Color", Color) = (1,1,1,1)
_FlashAttenFactors ("Flash Attenuation Factors", Vector) = (1,0,0,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 36828
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
varying mediump vec3 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  tmpvar_2 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_MatrixMV[0].xyz;
  tmpvar_5[1] = unity_MatrixMV[1].xyz;
  tmpvar_5[2] = unity_MatrixMV[2].xyz;
  tmpvar_1 = (tmpvar_5 * _glesNormal);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump float _EmissionScaler;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD2);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.w = 1.0;
  outColor_1.xyz = mix (outColor_1.xyz, vec3(dot (outColor_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
}