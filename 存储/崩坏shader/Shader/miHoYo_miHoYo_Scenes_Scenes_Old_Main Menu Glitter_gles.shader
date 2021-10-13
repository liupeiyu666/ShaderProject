//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Main Menu Glitter" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_GlitterTex ("Glitter Tex (R: Ocean Glitter, G: Ground Lighting Mask)", 2D) = "white" { }
_ReflectionTex ("Reflection Tex (RGB)", 2D) = "white" { }
_CarLightingTex ("Car Lighting Tex", 2D) = "white" { }
_ReflectionShift ("Reflection Shift (A)", 2D) = "black" { }
_NoiseTex ("Noise Tex (A)", 2D) = "white" { }
[Header(Ocean Glitter)] _OceanScintillationScaleLayer1 ("Glitter Scintillation Scale Layer 1", Range(0, 50)) = 5
_OceanScintillationSpeedLayer1 ("Glitter Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_OceanScintillationScaleLayer2 ("Glitter Scintillation Scale Layer 2", Range(0, 50)) = 5
_OceanScintillationSpeedLayer2 ("Glitter Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_OceanGlitterDensity ("Glitter Density", Range(0, 1)) = 0.5
_OceanGlitterBrightness ("Glitter Brightness", Range(0, 10)) = 1
_OceanGlitterColor ("Glitter Color", Color) = (1,1,1,1)
[Header(Building Lighting)] _BuildingLightingScintillationScaleLayer1 ("Lighting Scintillation Scale Layer 1", Range(0, 50)) = 5
_BuildingLightingScintillationSpeedLayer1 ("Lighting Scintillation Speed Layer 1", Range(0, 1)) = 0.3
_BuildingLightingScintillationScaleLayer2 ("Lighting Scintillation Scale Layer 2", Range(0, 50)) = 5
_BuildingLightingScintillationSpeedLayer2 ("Lighting Scintillation Speed Layer 2", Range(0, 1)) = 0.3
_BuildingLightingBrightness ("Lighting Brightness", Range(0, 5)) = 1
[Header(Car Lighting)] _CarLeftMovingSpeed ("Car Left Moving Speed", Range(0, 0.5)) = 0.1
_CarRightMovingSpeed ("Car Right Moving Speed", Range(0, 0.5)) = 0.1
_CarLightingBrightness ("Car Brightness", Range(0, 5)) = 1
[Header(Reflection)] _ReflectionBoundaryRatio ("Reflection Boundary Ratio", Range(-0.5, 0.5)) = 0
_ReflectionDistortion ("Reflection Distortion", Range(0, 1)) = 0.1
_ReflectionBrightness ("Reflection Brightness", Range(0, 5)) = 1
_ReflectionScintillation ("Reflection Scintillation", Range(0, 0.3)) = 0.1
_GroundLightingReflectionTex ("Ground Lighting ReflectionTex (RGB)", 2D) = "black" { }
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 11138
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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
uniform highp vec4 _ReflectionShift_ST;
uniform mediump float _OceanScintillationScaleLayer1;
uniform mediump float _OceanScintillationSpeedLayer1;
uniform mediump float _OceanScintillationScaleLayer2;
uniform mediump float _OceanScintillationSpeedLayer2;
uniform mediump float _ReflectionScintillation;
uniform highp float _ReflectionBoundaryRatio;
uniform highp vec2 _GameTime;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = (_GameTime.y * _OceanScintillationSpeedLayer1);
  tmpvar_4.x = (tmpvar_5 * 0.4);
  tmpvar_4.y = (tmpvar_5 * 0.2);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer1) + tmpvar_4);
  highp vec2 tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (_GameTime.y * _OceanScintillationSpeedLayer2);
  tmpvar_6.x = (tmpvar_7 * 0.2);
  tmpvar_6.y = (tmpvar_7 * 0.4);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _OceanScintillationScaleLayer2) + tmpvar_6);
  highp vec2 tmpvar_8;
  highp float tmpvar_9;
  tmpvar_9 = (_GameTime.x * _ReflectionScintillation);
  tmpvar_8.x = (tmpvar_9 * 0.2);
  tmpvar_8.y = (tmpvar_9 * 0.4);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _ReflectionShift_ST.xy) + tmpvar_8);
  highp vec2 tmpvar_10;
  tmpvar_10.x = 0.0;
  tmpvar_10.y = (1.0 - (2.0 * _ReflectionBoundaryRatio));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * vec2(1.0, -1.0)) + tmpvar_10);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _GlitterTex;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectionShift;
uniform sampler2D _NoiseTex;
uniform mediump float _OceanGlitterDensity;
uniform mediump float _OceanGlitterBrightness;
uniform mediump vec3 _OceanGlitterColor;
uniform mediump float _ReflectionDistortion;
uniform mediump float _ReflectionBrightness;
uniform sampler2D _GroundLightingReflectionTex;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 reflection_1;
  mediump float oceanGiltterScintillation_2;
  mediump vec4 col_3;
  mediump vec3 glitterTex_4;
  mediump vec4 mainTex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainTex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_GlitterTex, xlv_TEXCOORD0).xyz;
  glitterTex_4 = tmpvar_7;
  col_3.w = mainTex_5.w;
  lowp float tmpvar_8;
  tmpvar_8 = ((texture2D (_NoiseTex, xlv_TEXCOORD1.xy).w * texture2D (_NoiseTex, xlv_TEXCOORD1.zw).w) * 3.0);
  oceanGiltterScintillation_2 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (xlv_TEXCOORD0 * 10.0);
  tmpvar_9 = texture2D (_NoiseTex, P_10);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_9.w - _OceanGlitterDensity) / (1.0 - _OceanGlitterDensity)), 0.0, 1.0);
  col_3.xyz = (mainTex_5.xyz + ((
    ((glitterTex_4.x * _OceanGlitterColor) * _OceanGlitterBrightness)
   * 
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  ) * oceanGiltterScintillation_2));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_GroundLightingReflectionTex, xlv_TEXCOORD0);
  col_3.xyz = (col_3.xyz + tmpvar_12.xyz);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectionShift, xlv_TEXCOORD2.xy);
  mediump float tmpvar_14;
  tmpvar_14 = ((tmpvar_13.w * _ReflectionDistortion) - (_ReflectionDistortion * 0.5));
  mediump vec2 tmpvar_15;
  tmpvar_15.y = 0.0;
  tmpvar_15.x = tmpvar_14;
  highp vec2 P_16;
  P_16 = (xlv_TEXCOORD0 + tmpvar_15);
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_14;
  highp vec2 P_18;
  P_18 = (xlv_TEXCOORD2.zw + tmpvar_17);
  lowp vec3 tmpvar_19;
  tmpvar_19 = (texture2D (_ReflectionTex, P_16).xyz + texture2D (_GroundLightingReflectionTex, P_18).xyz);
  reflection_1 = tmpvar_19;
  col_3.xyz = (col_3.xyz + ((reflection_1 * reflection_1) * _ReflectionBrightness));
  col_3.w = _BloomFactor;
  col_3.xyz = mix (col_3.xyz, vec3(dot (col_3.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_3;
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