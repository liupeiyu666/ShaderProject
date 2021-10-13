//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/SceneMatcap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 41069
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec4 v_5;
  v_5.x = unity_WorldToObject[0].x;
  v_5.y = unity_WorldToObject[1].x;
  v_5.z = unity_WorldToObject[2].x;
  v_5.w = unity_WorldToObject[3].x;
  highp vec4 v_6;
  v_6.x = unity_WorldToObject[0].y;
  v_6.y = unity_WorldToObject[1].y;
  v_6.z = unity_WorldToObject[2].y;
  v_6.w = unity_WorldToObject[3].y;
  highp vec4 v_7;
  v_7.x = unity_WorldToObject[0].z;
  v_7.y = unity_WorldToObject[1].z;
  v_7.z = unity_WorldToObject[2].z;
  v_7.w = unity_WorldToObject[3].z;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_MatrixV[0].xyz;
  tmpvar_8[1] = unity_MatrixV[1].xyz;
  tmpvar_8[2] = unity_MatrixV[2].xyz;
  tmpvar_3 = (((tmpvar_8 * 
    normalize((((v_5.xyz * _glesNormal.x) + (v_6.xyz * _glesNormal.y)) + (v_7.xyz * _glesNormal.z)))
  ).xy * 0.5) + 0.5);
  highp float fogTune_9;
  fogTune_9 = _FogTune;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_13))
       * 
        (_FogIntensity * tmpvar_13)
      ) * fogTune_9)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_9)), _FogEffectLimit);
    highp vec3 tmpvar_20;
    tmpvar_20 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, ((_FogEndDistance * fogTune_9) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_20;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 mc_1;
  mediump vec4 tex_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MatCap, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = ((tmpvar_4 * tex_2) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_1.w = tmpvar_5.w;
  mc_1.xyz = mix (tmpvar_5.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  gl_FragData[0] = mc_1;
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
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
Fallback "VertexLit"
}