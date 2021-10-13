//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_DLC/Debug" {
Properties {
[MHYHeaderBox(MAPS)] [MHYHeader(Main Maps)] [MHYSingleLineTextureNoScaleOffset] _LightMap ("Light Map |R (sepcular intensity) G (diffuse threshold) B (specular threshold) A (material id)", 2D) = "grey" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(DEBUG)] [Toggle(_DEBUG_MATERIAL_ID)] _DebugMaterialId ("Debug Material ID", Float) = 0
[MHYInt(0, 7)] _MaterialID ("Material ID", Float) = 0
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 49828
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
void main ()
{
  gl_FragData[0] = vec4(1.0, 1.0, 1.0, 1.0);
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DEBUG_MATERIAL_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _LightMap;
uniform highp float _MaterialID;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 lightmap_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMap, xlv_TEXCOORD0.xy);
  lightmap_2 = tmpvar_3;
  mediump float inputId_4;
  inputId_4 = floor(((lightmap_2.w * 8.0) + 0.5));
  mediump float comparedId_5;
  comparedId_5 = _MaterialID;
  bool tmpvar_6;
  if ((((comparedId_5 - 0.5) < inputId_4) && (inputId_4 < (comparedId_5 + 0.5)))) {
    tmpvar_6 = bool(1);
  } else {
    tmpvar_6 = bool(0);
  };
  if (tmpvar_6) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DEBUG_MATERIAL_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _LightMap;
uniform highp float _MaterialID;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 lightmap_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMap, xlv_TEXCOORD0.xy);
  lightmap_2 = tmpvar_3;
  mediump float inputId_4;
  inputId_4 = floor(((lightmap_2.w * 8.0) + 0.5));
  mediump float comparedId_5;
  comparedId_5 = _MaterialID;
  bool tmpvar_6;
  if ((((comparedId_5 - 0.5) < inputId_4) && (inputId_4 < (comparedId_5 + 0.5)))) {
    tmpvar_6 = bool(1);
  } else {
    tmpvar_6 = bool(0);
  };
  if (tmpvar_6) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DEBUG_MATERIAL_ID" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = _glesColor;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _LightMap;
uniform highp float _MaterialID;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec4 lightmap_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_LightMap, xlv_TEXCOORD0.xy);
  lightmap_2 = tmpvar_3;
  mediump float inputId_4;
  inputId_4 = floor(((lightmap_2.w * 8.0) + 0.5));
  mediump float comparedId_5;
  comparedId_5 = _MaterialID;
  bool tmpvar_6;
  if ((((comparedId_5 - 0.5) < inputId_4) && (inputId_4 < (comparedId_5 + 0.5)))) {
    tmpvar_6 = bool(1);
  } else {
    tmpvar_6 = bool(0);
  };
  if (tmpvar_6) {
    tmpvar_1 = vec4(1.0, 1.0, 1.0, 1.0);
  } else {
    tmpvar_1 = vec4(0.0, 0.0, 0.0, 1.0);
  };
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
Keywords { "_DEBUG_MATERIAL_ID" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DEBUG_MATERIAL_ID" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DEBUG_MATERIAL_ID" }
""
}
}
}
}
}