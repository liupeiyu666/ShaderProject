//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_VertexFire_New" {
Properties {
_MainOffsetTex ("MainOffsetTex", 2D) = "bump" { }
_MainOffsetIntensity ("MainOffsetIntensity", Float) = 1
_MainOffsetSpeed ("MainOffsetSpeed", Vector) = (0,0,0,0)
_DisTex ("DisTex", 2D) = "white" { }
_DisTexSpeed ("DisTexSpeed", Vector) = (0,0,0,0)
_DisTexClip ("DisTexClip", Float) = 0.47
_MainTex ("MainTex", 2D) = "white" { }
_MainLightColor ("MainLightColor", Color) = (0.259434,0.9920127,1,0)
_MainDarkColor ("MainDarkColor", Color) = (1,0.2889685,0,0)
_MainAddColor ("MainAddColor", Color) = (0.3410911,0.9112098,0.990566,0)
_MainAddColClip ("MainAddColClip", Float) = 0.77
_MainAddColorIntensity ("MainAddColorIntensity", Float) = 1
_texcoord ("", 2D) = "white" { }
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 63874
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _MainOffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec3 tex2DNode2_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_MainTex, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _MainOffsetSpeed) + ((_glesMultiTexCoord0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2DLod (_MainOffsetTex, tmpvar_6.xy, 0.0).xyz * 2.0) - 1.0);
  tex2DNode2_2 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((1.0 - tmpvar_5.x) * (
    (tex2DNode2_2 * _glesNormal)
   * _MainOffsetIntensity)));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _DisTexClip;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp vec2 _DisTexSpeed;
uniform highp float _MainAddColClip;
uniform highp vec4 _MainAddColor;
uniform highp float _MainAddColorIntensity;
uniform highp vec4 _MainLightColor;
uniform highp vec4 _MainDarkColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 tex2DNode2_3;
  highp vec4 tex2DNode49_4;
  highp vec4 tex2DNode15_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode15_5 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_DisTexClip * (1.0 - tex2DNode15_5.x));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_Time.y * _DisTexSpeed) + ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DisTex, tmpvar_9);
  tex2DNode49_4 = tmpvar_10;
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((tex2DNode49_4.x - tmpvar_8) / (
    (tmpvar_8 + 0.2)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _MainOffsetSpeed) + ((xlv_TEXCOORD0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_MainOffsetTex, tmpvar_13).xyz * 2.0) - 1.0);
  tex2DNode2_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((tex2DNode2_3.z - _MainAddColClip) / (
    (_MainAddColClip + 0.2)
   - _MainAddColClip)), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (1.0 - (tmpvar_15 * (tmpvar_15 * (3.0 - 
      (2.0 * tmpvar_15)
    ))))
   * _MainAddColor) * _MainAddColorIntensity) + ((tex2DNode15_5.x * _MainLightColor) + (_MainDarkColor * 
    (1.0 - tex2DNode15_5.x)
  ))).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _MainOffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec3 tex2DNode2_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_MainTex, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _MainOffsetSpeed) + ((_glesMultiTexCoord0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2DLod (_MainOffsetTex, tmpvar_6.xy, 0.0).xyz * 2.0) - 1.0);
  tex2DNode2_2 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((1.0 - tmpvar_5.x) * (
    (tex2DNode2_2 * _glesNormal)
   * _MainOffsetIntensity)));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _DisTexClip;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp vec2 _DisTexSpeed;
uniform highp float _MainAddColClip;
uniform highp vec4 _MainAddColor;
uniform highp float _MainAddColorIntensity;
uniform highp vec4 _MainLightColor;
uniform highp vec4 _MainDarkColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 tex2DNode2_3;
  highp vec4 tex2DNode49_4;
  highp vec4 tex2DNode15_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode15_5 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_DisTexClip * (1.0 - tex2DNode15_5.x));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_Time.y * _DisTexSpeed) + ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DisTex, tmpvar_9);
  tex2DNode49_4 = tmpvar_10;
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((tex2DNode49_4.x - tmpvar_8) / (
    (tmpvar_8 + 0.2)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _MainOffsetSpeed) + ((xlv_TEXCOORD0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_MainOffsetTex, tmpvar_13).xyz * 2.0) - 1.0);
  tex2DNode2_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((tex2DNode2_3.z - _MainAddColClip) / (
    (_MainAddColClip + 0.2)
   - _MainAddColClip)), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (1.0 - (tmpvar_15 * (tmpvar_15 * (3.0 - 
      (2.0 * tmpvar_15)
    ))))
   * _MainAddColor) * _MainAddColorIntensity) + ((tex2DNode15_5.x * _MainLightColor) + (_MainDarkColor * 
    (1.0 - tex2DNode15_5.x)
  ))).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _MainOffsetIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec3 tex2DNode2_2;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2DLod (_MainTex, tmpvar_3.xy, 0.0);
  highp vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _MainOffsetSpeed) + ((_glesMultiTexCoord0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2DLod (_MainOffsetTex, tmpvar_6.xy, 0.0).xyz * 2.0) - 1.0);
  tex2DNode2_2 = tmpvar_7;
  tmpvar_1.xyz = (_glesVertex.xyz + ((1.0 - tmpvar_5.x) * (
    (tex2DNode2_2 * _glesNormal)
   * _MainOffsetIntensity)));
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform sampler2D _MainOffsetTex;
uniform highp vec4 _MainOffsetTex_ST;
uniform highp vec2 _MainOffsetSpeed;
uniform highp float _DisTexClip;
uniform sampler2D _DisTex;
uniform highp vec4 _DisTex_ST;
uniform highp vec2 _DisTexSpeed;
uniform highp float _MainAddColClip;
uniform highp vec4 _MainAddColor;
uniform highp float _MainAddColorIntensity;
uniform highp vec4 _MainLightColor;
uniform highp vec4 _MainDarkColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec3 tex2DNode2_3;
  highp vec4 tex2DNode49_4;
  highp vec4 tex2DNode15_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, tmpvar_6);
  tex2DNode15_5 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (_DisTexClip * (1.0 - tex2DNode15_5.x));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((_Time.y * _DisTexSpeed) + ((xlv_TEXCOORD0.xy * _DisTex_ST.xy) + _DisTex_ST.zw));
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_DisTex, tmpvar_9);
  tex2DNode49_4 = tmpvar_10;
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = clamp (((tex2DNode49_4.x - tmpvar_8) / (
    (tmpvar_8 + 0.2)
   - tmpvar_8)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_12 * (tmpvar_12 * (3.0 - 
    (2.0 * tmpvar_12)
  )));
  highp vec2 tmpvar_13;
  tmpvar_13 = ((_Time.y * _MainOffsetSpeed) + ((xlv_TEXCOORD0.xy * _MainOffsetTex_ST.xy) + _MainOffsetTex_ST.zw));
  lowp vec3 tmpvar_14;
  tmpvar_14 = ((texture2D (_MainOffsetTex, tmpvar_13).xyz * 2.0) - 1.0);
  tex2DNode2_3 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = clamp (((tex2DNode2_3.z - _MainAddColClip) / (
    (_MainAddColClip + 0.2)
   - _MainAddColClip)), 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_11;
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (1.0 - (tmpvar_15 * (tmpvar_15 * (3.0 - 
      (2.0 * tmpvar_15)
    ))))
   * _MainAddColor) * _MainAddColorIntensity) + ((tex2DNode15_5.x * _MainLightColor) + (_MainDarkColor * 
    (1.0 - tex2DNode15_5.x)
  ))).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
  gl_FragData[0] = tmpvar_18;
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