//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_DefendShield_New" {
Properties {
_PointCirclePosition ("PointCirclePosition", Vector) = (0.2,0.39,0,0)
_PointCircleShieldPosition ("PointCircleShieldPosition", Vector) = (0,0,0,0)
_MainTex ("MainTex", 2D) = "white" { }
_MainTexIntensity ("MainTexIntensity", Float) = 1
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainTexTilling ("MainTexTilling", Float) = 0
_MainTexSpeed ("MainTexSpeed", Vector) = (0,0,0,0)
_MainTexFresnel ("MainTexFresnel", Vector) = (0,1,5,0)
_MainTexDis ("MainTexDis", 2D) = "white" { }
_MainTexDisIntensity ("MainTexDisIntensity", Float) = 0
_CrackTex ("CrackTex", 2D) = "white" { }
_CrackTexIntensity ("CrackTexIntensity", Float) = 1
_CrackTexColor ("CrackTexColor", Color) = (1,0.8092361,0.01415092,0)
_PointCircleMainClip ("PointCircleMainClip", Float) = -0.22
_PointCircleWidth ("PointCircleWidth", Float) = 0.2
_PointCircleIntensity ("PointCircleIntensity", Float) = 0
_PointCircleColor ("PointCircleColor", Color) = (0,0,0,0)
_PointStep ("PointStep", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 59311
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _MainTexFresnel;
uniform sampler2D _MainTex;
uniform highp vec2 _MainTexSpeed;
uniform highp float _MainTexTilling;
uniform sampler2D _MainTexDis;
uniform highp vec4 _MainTexDis_ST;
uniform highp float _MainTexDisIntensity;
uniform highp float _MainTexIntensity;
uniform highp float _PointCircleMainClip;
uniform highp vec3 _PointCirclePosition;
uniform highp vec3 _PointCircleShieldPosition;
uniform highp float _PointCircleWidth;
uniform highp vec4 _PointCircleColor;
uniform highp float _PointCircleIntensity;
uniform highp float _PointStep;
uniform sampler2D _CrackTex;
uniform highp vec4 _CrackTex_ST;
uniform highp float _CrackTexIntensity;
uniform highp vec4 _CrackTexColor;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTexDis_ST.xy) + _MainTexDis_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexDis, tmpvar_4);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _MainTexSpeed) + (xlv_TEXCOORD0.xy * vec2(_MainTexTilling))) + (tmpvar_5.x * _MainTexDisIntensity));
  tmpvar_6 = texture2D (_MainTex, P_7);
  tex2DNode1_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (2.0 + (_PointCircleMainClip * -4.5));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 + 0.2);
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((_PointCirclePosition - _PointCircleShieldPosition)), normalize(xlv_TEXCOORD4.xyz));
  highp float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_10 - tmpvar_8) / (tmpvar_9 - tmpvar_8)), 0.0, 1.0);
  highp float edge0_12;
  edge0_12 = (tmpvar_8 + _PointCircleWidth);
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_10 - edge0_12) / (
    (tmpvar_9 + _PointCircleWidth)
   - edge0_12)), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
   - 
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
  ) * _PointCircleColor) * _PointCircleIntensity);
  highp float tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp (tex2DNode1_3.x, 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_15 / _PointStep), 0.0, 1.0);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_CrackTex, tmpvar_18);
  highp vec4 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * _CrackTexIntensity) * _CrackTexColor);
  highp float tmpvar_21;
  tmpvar_21 = (((
    ((_MainTexFresnel.x + (_MainTexFresnel.y * pow (
      (1.0 - dot (xlv_TEXCOORD4.xyz, normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))))
    , _MainTexFresnel.z))) * tex2DNode1_3.x)
   * _MainTexIntensity) + (tmpvar_14 * 
    (tmpvar_17 * (tmpvar_17 * (3.0 - (2.0 * tmpvar_17))))
  )) + tmpvar_20).x;
  aseOutAlpha_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (((
    (clamp (tmpvar_15, 0.0, 1.0) * _MainColor)
   * _MainTexIntensity) + tmpvar_14) + tmpvar_20).xyz;
  aseOutColor_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = aseOutColor_1;
  tmpvar_24.w = tmpvar_23;
  gl_FragData[0] = tmpvar_24;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _MainTexFresnel;
uniform sampler2D _MainTex;
uniform highp vec2 _MainTexSpeed;
uniform highp float _MainTexTilling;
uniform sampler2D _MainTexDis;
uniform highp vec4 _MainTexDis_ST;
uniform highp float _MainTexDisIntensity;
uniform highp float _MainTexIntensity;
uniform highp float _PointCircleMainClip;
uniform highp vec3 _PointCirclePosition;
uniform highp vec3 _PointCircleShieldPosition;
uniform highp float _PointCircleWidth;
uniform highp vec4 _PointCircleColor;
uniform highp float _PointCircleIntensity;
uniform highp float _PointStep;
uniform sampler2D _CrackTex;
uniform highp vec4 _CrackTex_ST;
uniform highp float _CrackTexIntensity;
uniform highp vec4 _CrackTexColor;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTexDis_ST.xy) + _MainTexDis_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexDis, tmpvar_4);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _MainTexSpeed) + (xlv_TEXCOORD0.xy * vec2(_MainTexTilling))) + (tmpvar_5.x * _MainTexDisIntensity));
  tmpvar_6 = texture2D (_MainTex, P_7);
  tex2DNode1_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (2.0 + (_PointCircleMainClip * -4.5));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 + 0.2);
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((_PointCirclePosition - _PointCircleShieldPosition)), normalize(xlv_TEXCOORD4.xyz));
  highp float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_10 - tmpvar_8) / (tmpvar_9 - tmpvar_8)), 0.0, 1.0);
  highp float edge0_12;
  edge0_12 = (tmpvar_8 + _PointCircleWidth);
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_10 - edge0_12) / (
    (tmpvar_9 + _PointCircleWidth)
   - edge0_12)), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
   - 
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
  ) * _PointCircleColor) * _PointCircleIntensity);
  highp float tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp (tex2DNode1_3.x, 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_15 / _PointStep), 0.0, 1.0);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_CrackTex, tmpvar_18);
  highp vec4 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * _CrackTexIntensity) * _CrackTexColor);
  highp float tmpvar_21;
  tmpvar_21 = (((
    ((_MainTexFresnel.x + (_MainTexFresnel.y * pow (
      (1.0 - dot (xlv_TEXCOORD4.xyz, normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))))
    , _MainTexFresnel.z))) * tex2DNode1_3.x)
   * _MainTexIntensity) + (tmpvar_14 * 
    (tmpvar_17 * (tmpvar_17 * (3.0 - (2.0 * tmpvar_17))))
  )) + tmpvar_20).x;
  aseOutAlpha_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (((
    (clamp (tmpvar_15, 0.0, 1.0) * _MainColor)
   * _MainTexIntensity) + tmpvar_14) + tmpvar_20).xyz;
  aseOutColor_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = aseOutColor_1;
  tmpvar_24.w = tmpvar_23;
  gl_FragData[0] = tmpvar_24;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _MainTexFresnel;
uniform sampler2D _MainTex;
uniform highp vec2 _MainTexSpeed;
uniform highp float _MainTexTilling;
uniform sampler2D _MainTexDis;
uniform highp vec4 _MainTexDis_ST;
uniform highp float _MainTexDisIntensity;
uniform highp float _MainTexIntensity;
uniform highp float _PointCircleMainClip;
uniform highp vec3 _PointCirclePosition;
uniform highp vec3 _PointCircleShieldPosition;
uniform highp float _PointCircleWidth;
uniform highp vec4 _PointCircleColor;
uniform highp float _PointCircleIntensity;
uniform highp float _PointStep;
uniform sampler2D _CrackTex;
uniform highp vec4 _CrackTex_ST;
uniform highp float _CrackTexIntensity;
uniform highp vec4 _CrackTexColor;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTexDis_ST.xy) + _MainTexDis_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexDis, tmpvar_4);
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _MainTexSpeed) + (xlv_TEXCOORD0.xy * vec2(_MainTexTilling))) + (tmpvar_5.x * _MainTexDisIntensity));
  tmpvar_6 = texture2D (_MainTex, P_7);
  tex2DNode1_3 = tmpvar_6;
  highp float tmpvar_8;
  tmpvar_8 = (2.0 + (_PointCircleMainClip * -4.5));
  highp float tmpvar_9;
  tmpvar_9 = (tmpvar_8 + 0.2);
  highp float tmpvar_10;
  tmpvar_10 = dot (normalize((_PointCirclePosition - _PointCircleShieldPosition)), normalize(xlv_TEXCOORD4.xyz));
  highp float tmpvar_11;
  tmpvar_11 = clamp (((tmpvar_10 - tmpvar_8) / (tmpvar_9 - tmpvar_8)), 0.0, 1.0);
  highp float edge0_12;
  edge0_12 = (tmpvar_8 + _PointCircleWidth);
  highp float tmpvar_13;
  tmpvar_13 = clamp (((tmpvar_10 - edge0_12) / (
    (tmpvar_9 + _PointCircleWidth)
   - edge0_12)), 0.0, 1.0);
  highp vec4 tmpvar_14;
  tmpvar_14 = (((
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
   - 
    (tmpvar_13 * (tmpvar_13 * (3.0 - (2.0 * tmpvar_13))))
  ) * _PointCircleColor) * _PointCircleIntensity);
  highp float tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = clamp (tex2DNode1_3.x, 0.0, 1.0);
  tmpvar_15 = (tmpvar_16 * (tmpvar_16 * (3.0 - 
    (2.0 * tmpvar_16)
  )));
  highp float tmpvar_17;
  tmpvar_17 = clamp ((tmpvar_15 / _PointStep), 0.0, 1.0);
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0.xy * _CrackTex_ST.xy) + _CrackTex_ST.zw);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_CrackTex, tmpvar_18);
  highp vec4 tmpvar_20;
  tmpvar_20 = ((tmpvar_19 * _CrackTexIntensity) * _CrackTexColor);
  highp float tmpvar_21;
  tmpvar_21 = (((
    ((_MainTexFresnel.x + (_MainTexFresnel.y * pow (
      (1.0 - dot (xlv_TEXCOORD4.xyz, normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))))
    , _MainTexFresnel.z))) * tex2DNode1_3.x)
   * _MainTexIntensity) + (tmpvar_14 * 
    (tmpvar_17 * (tmpvar_17 * (3.0 - (2.0 * tmpvar_17))))
  )) + tmpvar_20).x;
  aseOutAlpha_2 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (((
    (clamp (tmpvar_15, 0.0, 1.0) * _MainColor)
   * _MainTexIntensity) + tmpvar_14) + tmpvar_20).xyz;
  aseOutColor_1 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_23;
  mediump vec4 tmpvar_24;
  tmpvar_24.xyz = aseOutColor_1;
  tmpvar_24.w = tmpvar_23;
  gl_FragData[0] = tmpvar_24;
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