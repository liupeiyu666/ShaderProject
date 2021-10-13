//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_TrailShadow" {
Properties {
_mainColor ("mainColor", Color) = (0.5566038,0.5566038,0.5566038,0)
_Opacity ("Opacity", Float) = 1
_mainTex ("mainTex", 2D) = "white" { }
_MainIntensity ("MainIntensity", Float) = 0
_OffsetDir ("OffsetDir", Vector) = (0,0,0,0)
_OffsetTexture ("OffsetTexture", 2D) = "white" { }
_OffsetIntensity ("OffsetIntensity", Float) = 1
_OffsetNoiseTex ("OffsetNoiseTex", 2D) = "white" { }
_OffsetNoiseSpeed ("OffsetNoiseSpeed", Vector) = (0,0,0,0)
_MaskTex ("MaskTex", 2D) = "white" { }
_MaskSpeed ("MaskSpeed", Vector) = (0,0,0,0)
_DistortionMap ("DistortionMap", 2D) = "bump" { }
_Distortion ("Distortion", Range(0, 1)) = 0.292
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 20624
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _OffsetTexture;
uniform highp vec4 _OffsetTexture_ST;
uniform highp vec3 _OffsetDir;
uniform sampler2D _OffsetNoiseTex;
uniform highp vec2 _OffsetNoiseSpeed;
uniform highp float _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * _OffsetTexture_ST.xy) + _OffsetTexture_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DLod (_OffsetTexture, tmpvar_8.xy, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _OffsetDir;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = ((_Time.y * _OffsetNoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_OffsetNoiseTex, tmpvar_11.xy, 0.0);
  tmpvar_2.xyz = (_glesVertex.xyz + ((
    ((tmpvar_9 * vec4(1.0, 1.0, 1.0, 0.0)) / vec4(1.0, 1.0, 1.0, 0.0))
   * 
    ((unity_WorldToObject * tmpvar_10) * tmpvar_12)
  ) * _OffsetIntensity).xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp float _Opacity;
uniform sampler2D _MaskTex;
uniform highp vec2 _MaskSpeed;
uniform highp vec4 _mainColor;
uniform sampler2D _mainTex;
uniform highp vec4 _mainTex_ST;
uniform highp float _MainIntensity;
uniform sampler2D _DistortionMap;
uniform highp vec4 _DistortionMap_ST;
uniform highp float _Distortion;
uniform sampler2D _BeforeAlphaTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor55_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _MaskSpeed) + xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex_ST.xy) + _mainTex_ST.zw);
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _DistortionMap_ST.xy) + _DistortionMap_ST.zw);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_DistortionMap, tmpvar_7).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((o_6 / xlv_TEXCOORD3.w).xy + (tmpvar_8 * _Distortion).xy);
  tmpvar_9 = texture2D (_BeforeAlphaTexture, P_10);
  screenColor55_3 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_4);
  highp float tmpvar_12;
  tmpvar_12 = (_Opacity * tmpvar_11).x;
  aseOutAlpha_2 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_mainTex, tmpvar_5);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((_mainColor * tmpvar_13) + _MainIntensity) * screenColor55_3).xyz;
  aseOutColor_1 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = aseOutColor_1;
  tmpvar_16.w = tmpvar_15;
  gl_FragData[0] = tmpvar_16;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _OffsetTexture;
uniform highp vec4 _OffsetTexture_ST;
uniform highp vec3 _OffsetDir;
uniform sampler2D _OffsetNoiseTex;
uniform highp vec2 _OffsetNoiseSpeed;
uniform highp float _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * _OffsetTexture_ST.xy) + _OffsetTexture_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DLod (_OffsetTexture, tmpvar_8.xy, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _OffsetDir;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = ((_Time.y * _OffsetNoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_OffsetNoiseTex, tmpvar_11.xy, 0.0);
  tmpvar_2.xyz = (_glesVertex.xyz + ((
    ((tmpvar_9 * vec4(1.0, 1.0, 1.0, 0.0)) / vec4(1.0, 1.0, 1.0, 0.0))
   * 
    ((unity_WorldToObject * tmpvar_10) * tmpvar_12)
  ) * _OffsetIntensity).xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp float _Opacity;
uniform sampler2D _MaskTex;
uniform highp vec2 _MaskSpeed;
uniform highp vec4 _mainColor;
uniform sampler2D _mainTex;
uniform highp vec4 _mainTex_ST;
uniform highp float _MainIntensity;
uniform sampler2D _DistortionMap;
uniform highp vec4 _DistortionMap_ST;
uniform highp float _Distortion;
uniform sampler2D _BeforeAlphaTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor55_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _MaskSpeed) + xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex_ST.xy) + _mainTex_ST.zw);
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _DistortionMap_ST.xy) + _DistortionMap_ST.zw);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_DistortionMap, tmpvar_7).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((o_6 / xlv_TEXCOORD3.w).xy + (tmpvar_8 * _Distortion).xy);
  tmpvar_9 = texture2D (_BeforeAlphaTexture, P_10);
  screenColor55_3 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_4);
  highp float tmpvar_12;
  tmpvar_12 = (_Opacity * tmpvar_11).x;
  aseOutAlpha_2 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_mainTex, tmpvar_5);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((_mainColor * tmpvar_13) + _MainIntensity) * screenColor55_3).xyz;
  aseOutColor_1 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = aseOutColor_1;
  tmpvar_16.w = tmpvar_15;
  gl_FragData[0] = tmpvar_16;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _OffsetTexture;
uniform highp vec4 _OffsetTexture_ST;
uniform highp vec3 _OffsetDir;
uniform sampler2D _OffsetNoiseTex;
uniform highp vec2 _OffsetNoiseSpeed;
uniform highp float _OffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = ((_glesMultiTexCoord0.xy * _OffsetTexture_ST.xy) + _OffsetTexture_ST.zw);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DLod (_OffsetTexture, tmpvar_8.xy, 0.0);
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = _OffsetDir;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = ((_Time.y * _OffsetNoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DLod (_OffsetNoiseTex, tmpvar_11.xy, 0.0);
  tmpvar_2.xyz = (_glesVertex.xyz + ((
    ((tmpvar_9 * vec4(1.0, 1.0, 1.0, 0.0)) / vec4(1.0, 1.0, 1.0, 0.0))
   * 
    ((unity_WorldToObject * tmpvar_10) * tmpvar_12)
  ) * _OffsetIntensity).xyz);
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp float _Opacity;
uniform sampler2D _MaskTex;
uniform highp vec2 _MaskSpeed;
uniform highp vec4 _mainColor;
uniform sampler2D _mainTex;
uniform highp vec4 _mainTex_ST;
uniform highp float _MainIntensity;
uniform sampler2D _DistortionMap;
uniform highp vec4 _DistortionMap_ST;
uniform highp float _Distortion;
uniform sampler2D _BeforeAlphaTexture;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor55_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _MaskSpeed) + xlv_TEXCOORD0.xy);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD0.xy * _mainTex_ST.xy) + _mainTex_ST.zw);
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _DistortionMap_ST.xy) + _DistortionMap_ST.zw);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_DistortionMap, tmpvar_7).xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((o_6 / xlv_TEXCOORD3.w).xy + (tmpvar_8 * _Distortion).xy);
  tmpvar_9 = texture2D (_BeforeAlphaTexture, P_10);
  screenColor55_3 = tmpvar_9;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskTex, tmpvar_4);
  highp float tmpvar_12;
  tmpvar_12 = (_Opacity * tmpvar_11).x;
  aseOutAlpha_2 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_mainTex, tmpvar_5);
  highp vec3 tmpvar_14;
  tmpvar_14 = (((_mainColor * tmpvar_13) + _MainIntensity) * screenColor55_3).xyz;
  aseOutColor_1 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16.xyz = aseOutColor_1;
  tmpvar_16.w = tmpvar_15;
  gl_FragData[0] = tmpvar_16;
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