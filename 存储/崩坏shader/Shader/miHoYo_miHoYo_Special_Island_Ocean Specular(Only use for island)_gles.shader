//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Island/Ocean Specular(Only use for island)" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_NormalMap1 ("Normal Map 1", 2D) = "white" { }
_NormalMap2 ("Normal Map 2", 2D) = "white" { }
_BumpVelocity1 ("Bump Velocity 1", Vector) = (0,0,0,0)
_BumpVelocity2 ("Bump Velocity 2", Vector) = (0,0,0,0)
_LightDir1 ("Light Dir 1", Vector) = (0,1,-1,0)
_LightDir2 ("Light Dir 2", Vector) = (0,1,-1,0)
_Shininess1 ("Specular Shininess 1", Float) = 10
_Shininess2 ("Specular Shininess 2", Float) = 10
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 60297
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NormalMap1_ST;
uniform highp vec4 _NormalMap2_ST;
uniform highp vec2 _BumpVelocity1;
uniform highp vec2 _BumpVelocity2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 wTangent_1;
  mediump vec3 wNormal_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  wNormal_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesTANGENT.xyz));
  wTangent_1.xyz = tmpvar_8;
  wTangent_1.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (((wNormal_2.yzx * wTangent_1.zxy) - (wNormal_2.zxy * wTangent_1.yzx)) * wTangent_1.w);
  mediump vec3 tmpvar_10;
  tmpvar_10.x = wTangent_1.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = wNormal_2.x;
  mediump vec3 tmpvar_11;
  tmpvar_11.x = wTangent_1.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = wNormal_2.y;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = wTangent_1.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = wNormal_2.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _NormalMap1_ST.xy) + _NormalMap1_ST.zw) + fract((_BumpVelocity1 * _Time.y)));
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _NormalMap2_ST.xy) + _NormalMap2_ST.zw) + fract((_BumpVelocity2 * _Time.y)));
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD7 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap1;
uniform sampler2D _NormalMap2;
uniform mediump vec3 _LightDir1;
uniform mediump vec3 _LightDir2;
uniform mediump float _Shininess1;
uniform mediump float _Shininess2;
uniform mediump vec3 _SpecularColor;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N2_2;
  mediump vec3 N1_3;
  mediump vec3 NInT_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = normalize(((texture2D (_NormalMap1, xlv_TEXCOORD1).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_7;
  N1_3.x = dot (xlv_TEXCOORD3, NInT_4);
  N1_3.y = dot (xlv_TEXCOORD4, NInT_4);
  N1_3.z = dot (xlv_TEXCOORD5, NInT_4);
  lowp vec3 tmpvar_8;
  tmpvar_8 = normalize(((texture2D (_NormalMap2, xlv_TEXCOORD2).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_8;
  N2_2.x = dot (xlv_TEXCOORD3, NInT_4);
  N2_2.y = dot (xlv_TEXCOORD4, NInT_4);
  N2_2.z = dot (xlv_TEXCOORD5, NInT_4);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize((N1_3 + N2_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_1 = tmpvar_10;
  outColor_5.xyz = (outColor_5.xyz + ((
    ((max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir1)
       + V_1))), 0.001)
    , _Shininess1)) + max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir2)
       + V_1))), 0.001)
    , _Shininess2))) * _SpecularColor)
   * 2.0) * (1.0 - outColor_5.w)));
  outColor_5.w = _BloomFactor;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NormalMap1_ST;
uniform highp vec4 _NormalMap2_ST;
uniform highp vec2 _BumpVelocity1;
uniform highp vec2 _BumpVelocity2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 wTangent_1;
  mediump vec3 wNormal_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  wNormal_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesTANGENT.xyz));
  wTangent_1.xyz = tmpvar_8;
  wTangent_1.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (((wNormal_2.yzx * wTangent_1.zxy) - (wNormal_2.zxy * wTangent_1.yzx)) * wTangent_1.w);
  mediump vec3 tmpvar_10;
  tmpvar_10.x = wTangent_1.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = wNormal_2.x;
  mediump vec3 tmpvar_11;
  tmpvar_11.x = wTangent_1.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = wNormal_2.y;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = wTangent_1.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = wNormal_2.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _NormalMap1_ST.xy) + _NormalMap1_ST.zw) + fract((_BumpVelocity1 * _Time.y)));
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _NormalMap2_ST.xy) + _NormalMap2_ST.zw) + fract((_BumpVelocity2 * _Time.y)));
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD7 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap1;
uniform sampler2D _NormalMap2;
uniform mediump vec3 _LightDir1;
uniform mediump vec3 _LightDir2;
uniform mediump float _Shininess1;
uniform mediump float _Shininess2;
uniform mediump vec3 _SpecularColor;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N2_2;
  mediump vec3 N1_3;
  mediump vec3 NInT_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = normalize(((texture2D (_NormalMap1, xlv_TEXCOORD1).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_7;
  N1_3.x = dot (xlv_TEXCOORD3, NInT_4);
  N1_3.y = dot (xlv_TEXCOORD4, NInT_4);
  N1_3.z = dot (xlv_TEXCOORD5, NInT_4);
  lowp vec3 tmpvar_8;
  tmpvar_8 = normalize(((texture2D (_NormalMap2, xlv_TEXCOORD2).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_8;
  N2_2.x = dot (xlv_TEXCOORD3, NInT_4);
  N2_2.y = dot (xlv_TEXCOORD4, NInT_4);
  N2_2.z = dot (xlv_TEXCOORD5, NInT_4);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize((N1_3 + N2_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_1 = tmpvar_10;
  outColor_5.xyz = (outColor_5.xyz + ((
    ((max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir1)
       + V_1))), 0.001)
    , _Shininess1)) + max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir2)
       + V_1))), 0.001)
    , _Shininess2))) * _SpecularColor)
   * 2.0) * (1.0 - outColor_5.w)));
  outColor_5.w = _BloomFactor;
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _NormalMap1_ST;
uniform highp vec4 _NormalMap2_ST;
uniform highp vec2 _BumpVelocity1;
uniform highp vec2 _BumpVelocity2;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec4 wTangent_1;
  mediump vec3 wNormal_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex);
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize((_glesNormal * tmpvar_5));
  wNormal_2 = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_7[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_7[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((tmpvar_7 * _glesTANGENT.xyz));
  wTangent_1.xyz = tmpvar_8;
  wTangent_1.w = (_glesTANGENT.w * unity_WorldTransformParams.w);
  mediump vec3 tmpvar_9;
  tmpvar_9 = (((wNormal_2.yzx * wTangent_1.zxy) - (wNormal_2.zxy * wTangent_1.yzx)) * wTangent_1.w);
  mediump vec3 tmpvar_10;
  tmpvar_10.x = wTangent_1.x;
  tmpvar_10.y = tmpvar_9.x;
  tmpvar_10.z = wNormal_2.x;
  mediump vec3 tmpvar_11;
  tmpvar_11.x = wTangent_1.y;
  tmpvar_11.y = tmpvar_9.y;
  tmpvar_11.z = wNormal_2.y;
  mediump vec3 tmpvar_12;
  tmpvar_12.x = wTangent_1.z;
  tmpvar_12.y = tmpvar_9.z;
  tmpvar_12.z = wNormal_2.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _NormalMap1_ST.xy) + _NormalMap1_ST.zw) + fract((_BumpVelocity1 * _Time.y)));
  xlv_TEXCOORD2 = (((_glesMultiTexCoord0.xy * _NormalMap2_ST.xy) + _NormalMap2_ST.zw) + fract((_BumpVelocity2 * _Time.y)));
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCOORD4 = tmpvar_11;
  xlv_TEXCOORD5 = tmpvar_12;
  xlv_TEXCOORD7 = (tmpvar_4.xyz / tmpvar_4.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform sampler2D _MainTex;
uniform sampler2D _NormalMap1;
uniform sampler2D _NormalMap2;
uniform mediump vec3 _LightDir1;
uniform mediump vec3 _LightDir2;
uniform mediump float _Shininess1;
uniform mediump float _Shininess2;
uniform mediump vec3 _SpecularColor;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD5;
varying highp vec3 xlv_TEXCOORD7;
void main ()
{
  mediump vec3 V_1;
  mediump vec3 N2_2;
  mediump vec3 N1_3;
  mediump vec3 NInT_4;
  mediump vec4 outColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = normalize(((texture2D (_NormalMap1, xlv_TEXCOORD1).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_7;
  N1_3.x = dot (xlv_TEXCOORD3, NInT_4);
  N1_3.y = dot (xlv_TEXCOORD4, NInT_4);
  N1_3.z = dot (xlv_TEXCOORD5, NInT_4);
  lowp vec3 tmpvar_8;
  tmpvar_8 = normalize(((texture2D (_NormalMap2, xlv_TEXCOORD2).xyz * 2.0) - 1.0));
  NInT_4 = tmpvar_8;
  N2_2.x = dot (xlv_TEXCOORD3, NInT_4);
  N2_2.y = dot (xlv_TEXCOORD4, NInT_4);
  N2_2.z = dot (xlv_TEXCOORD5, NInT_4);
  mediump vec3 tmpvar_9;
  tmpvar_9 = normalize((N1_3 + N2_2));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD7));
  V_1 = tmpvar_10;
  outColor_5.xyz = (outColor_5.xyz + ((
    ((max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir1)
       + V_1))), 0.001)
    , _Shininess1)) + max (0.0, pow (
      max (dot (tmpvar_9, normalize((
        normalize(_LightDir2)
       + V_1))), 0.001)
    , _Shininess2))) * _SpecularColor)
   * 2.0) * (1.0 - outColor_5.w)));
  outColor_5.w = _BloomFactor;
  gl_FragData[0] = outColor_5;
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
}