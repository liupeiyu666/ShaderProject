//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/BlackWhite_New" {
Properties {
_Desaturate ("Desaturate", Range(0, 1)) = 0
_MainColor ("MainColor", Color) = (1,1,1,0)
_Min ("Min", Float) = 0
_Max ("Max", Float) = 1
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 1
[Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
[Toggle(_ParticleCT)] _ParticleCT ("Custom Data", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 18729
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
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
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform mediump float _Min;
uniform mediump float _Max;
uniform mediump float _ParticleCT;
uniform sampler2D _BeforeAlphaTexture;
uniform mediump float _Desaturate;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor2_3;
  mediump vec3 temp_cast_1_4;
  mediump vec3 temp_cast_0_5;
  temp_cast_0_5 = vec3(0.0, 0.0, 0.0);
  temp_cast_1_4 = vec3(0.0, 0.0, 0.0);
  if ((_ParticleCT == 1.0)) {
    temp_cast_0_5 = (vec3(_Min) + xlv_TEXCOORD1.x);
    temp_cast_1_4 = (vec3(_Max) + xlv_TEXCOORD1.y);
  } else {
    if ((_ParticleCT == 0.0)) {
      temp_cast_0_5 = vec3(_Min);
      temp_cast_1_4 = vec3(_Max);
    };
  };
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_BeforeAlphaTexture, o_6);
  screenColor2_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = clamp (((
    mix (screenColor2_3.xyz, vec3(dot (screenColor2_3.xyz, vec3(0.299, 0.587, 0.114))), vec3((_Desaturate + xlv_TEXCOORD1.z)))
   - temp_cast_0_5) / (temp_cast_1_4 - temp_cast_0_5)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = xlv_COLOR.w;
  aseOutAlpha_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * _MainColor).xyz * xlv_COLOR.xyz);
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
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
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform mediump float _Min;
uniform mediump float _Max;
uniform mediump float _ParticleCT;
uniform sampler2D _BeforeAlphaTexture;
uniform mediump float _Desaturate;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor2_3;
  mediump vec3 temp_cast_1_4;
  mediump vec3 temp_cast_0_5;
  temp_cast_0_5 = vec3(0.0, 0.0, 0.0);
  temp_cast_1_4 = vec3(0.0, 0.0, 0.0);
  if ((_ParticleCT == 1.0)) {
    temp_cast_0_5 = (vec3(_Min) + xlv_TEXCOORD1.x);
    temp_cast_1_4 = (vec3(_Max) + xlv_TEXCOORD1.y);
  } else {
    if ((_ParticleCT == 0.0)) {
      temp_cast_0_5 = vec3(_Min);
      temp_cast_1_4 = vec3(_Max);
    };
  };
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_BeforeAlphaTexture, o_6);
  screenColor2_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = clamp (((
    mix (screenColor2_3.xyz, vec3(dot (screenColor2_3.xyz, vec3(0.299, 0.587, 0.114))), vec3((_Desaturate + xlv_TEXCOORD1.z)))
   - temp_cast_0_5) / (temp_cast_1_4 - temp_cast_0_5)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = xlv_COLOR.w;
  aseOutAlpha_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * _MainColor).xyz * xlv_COLOR.xyz);
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
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
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ProjectionParams;
uniform mediump float _Min;
uniform mediump float _Max;
uniform mediump float _ParticleCT;
uniform sampler2D _BeforeAlphaTexture;
uniform mediump float _Desaturate;
uniform mediump vec4 _MainColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 screenColor2_3;
  mediump vec3 temp_cast_1_4;
  mediump vec3 temp_cast_0_5;
  temp_cast_0_5 = vec3(0.0, 0.0, 0.0);
  temp_cast_1_4 = vec3(0.0, 0.0, 0.0);
  if ((_ParticleCT == 1.0)) {
    temp_cast_0_5 = (vec3(_Min) + xlv_TEXCOORD1.x);
    temp_cast_1_4 = (vec3(_Max) + xlv_TEXCOORD1.y);
  } else {
    if ((_ParticleCT == 0.0)) {
      temp_cast_0_5 = vec3(_Min);
      temp_cast_1_4 = vec3(_Max);
    };
  };
  highp vec4 o_6;
  o_6.xzw = xlv_TEXCOORD3.xzw;
  o_6.y = (xlv_TEXCOORD3.w * 0.5);
  o_6.y = (((xlv_TEXCOORD3.y - o_6.y) * _ProjectionParams.x) + o_6.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_BeforeAlphaTexture, o_6);
  screenColor2_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = clamp (((
    mix (screenColor2_3.xyz, vec3(dot (screenColor2_3.xyz, vec3(0.299, 0.587, 0.114))), vec3((_Desaturate + xlv_TEXCOORD1.z)))
   - temp_cast_0_5) / (temp_cast_1_4 - temp_cast_0_5)), 0.0, 1.0);
  highp float tmpvar_9;
  tmpvar_9 = xlv_COLOR.w;
  aseOutAlpha_2 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = (tmpvar_8 * (tmpvar_8 * (3.0 - 
    (2.0 * tmpvar_8)
  )));
  highp vec3 tmpvar_11;
  tmpvar_11 = ((tmpvar_10 * _MainColor).xyz * xlv_COLOR.xyz);
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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