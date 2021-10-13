//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/SceneMatcapNormal" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB)", 2D) = "white" { }
_BumpMap ("Normal Map", 2D) = "bump" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
[Toggle(MATCAP_ACCURATE)] _MatCapAccurate ("Accurate Calculation", Float) = 0
_MetalRef ("MetalRef", Range(0, 1)) = 0
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 Tags { "RenderType" = "Opaque" }
 Pass {
  Tags { "RenderType" = "Opaque" }
  GpuProgramID 64922
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  highp vec2 tmpvar_7;
  highp vec2 tmpvar_8;
  highp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = _glesVertex.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_8 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(_glesNormal);
  highp vec4 tmpvar_14;
  tmpvar_14 = normalize(_glesTANGENT);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(tmpvar_14.xyz);
  highp vec3 tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_17 = tmpvar_14.xyz;
  tmpvar_18 = (((tmpvar_15.yzx * tmpvar_16.zxy) - (tmpvar_15.zxy * tmpvar_16.yzx)) * tmpvar_14.w);
  highp mat3 tmpvar_19;
  tmpvar_19[0].x = tmpvar_17.x;
  tmpvar_19[0].y = tmpvar_18.x;
  tmpvar_19[0].z = tmpvar_13.x;
  tmpvar_19[1].x = tmpvar_17.y;
  tmpvar_19[1].y = tmpvar_18.y;
  tmpvar_19[1].z = tmpvar_13.y;
  tmpvar_19[2].x = tmpvar_17.z;
  tmpvar_19[2].y = tmpvar_18.z;
  tmpvar_19[2].z = tmpvar_13.z;
  highp vec4 v_20;
  v_20.x = tmpvar_2.x;
  v_20.y = tmpvar_3.x;
  v_20.z = tmpvar_4.x;
  v_20.w = tmpvar_5.x;
  tmpvar_9 = (tmpvar_19 * normalize(v_20.xyz));
  highp vec4 v_21;
  v_21.x = tmpvar_2.y;
  v_21.y = tmpvar_3.y;
  v_21.z = tmpvar_4.y;
  v_21.w = tmpvar_5.y;
  tmpvar_10 = (tmpvar_19 * normalize(v_21.xyz));
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = _WorldSpaceCameraPos;
  tmpvar_11 = normalize((tmpvar_19 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_22)
  .xyz)));
  highp float fogTune_23;
  fogTune_23 = _FogTune;
  mediump vec4 tmpvar_24;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_27))
       * 
        (_FogIntensity * tmpvar_27)
      ) * fogTune_23)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_27)) * (_FogColorIntensity * tmpvar_27))
    ), 0.0, 1.0)));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_24 = fogColor_25;
  } else {
    mediump vec4 fogColor_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_32;
    tmpvar_32 = max (0.0, (sqrt(
      dot (tmpvar_31, tmpvar_31)
    ) - _FogStartDistance));
    highp float tmpvar_33;
    tmpvar_33 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_23)), _FogEffectLimit);
    highp vec3 tmpvar_34;
    tmpvar_34 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_32) / max (0.1, ((_FogEndDistance * fogTune_23) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_30.xyz = tmpvar_34;
    fogColor_30.w = tmpvar_33;
    tmpvar_24 = fogColor_30;
  };
  gl_Position = tmpvar_6;
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_TEXCOORD1 = tmpvar_8;
  xlv_COLOR1 = tmpvar_24;
  xlv_TEXCOORD2 = tmpvar_9;
  xlv_TEXCOORD3 = tmpvar_10;
  xlv_TEXCORRD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCORRD4;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  mediump vec2 capCoord_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (normals_4, normalize((xlv_TEXCORRD4 - 
    (2.0 * (dot (normals_4, xlv_TEXCORRD4) * normals_4))
  )), vec3(_MetalRef));
  normals_4 = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = dot (xlv_TEXCOORD2, normals_4);
  tmpvar_9.y = dot (xlv_TEXCOORD3, normals_4);
  capCoord_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  mediump vec2 P_11;
  P_11 = ((capCoord_3 * 0.5) + 0.5);
  tmpvar_10 = texture2D (_MatCap, P_11);
  mediump vec4 tmpvar_12;
  tmpvar_12 = ((tmpvar_10 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_12;
  mediump vec3 srcColor_13;
  srcColor_13 = mc_2.xyz;
  mediump vec3 tmpvar_14;
  tmpvar_14 = mix (srcColor_13, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_14;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
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
uniform highp vec4 _BumpMap_ST;
uniform mediump float _FogTune;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec3 worldBinormal_1;
  mediump vec3 worldTangent_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec2 tmpvar_5;
  highp vec2 tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = _glesVertex.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BumpMap_ST.xy) + _BumpMap_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  worldNormal_3 = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_11[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_11[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((tmpvar_11 * _glesTANGENT.xyz));
  worldTangent_2 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = ((worldNormal_3.yzx * worldTangent_2.zxy) - (worldNormal_3.zxy * worldTangent_2.yzx));
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13 * _glesTANGENT.w);
  worldBinormal_1 = tmpvar_14;
  mediump vec3 tmpvar_15;
  tmpvar_15.x = worldTangent_2.x;
  tmpvar_15.y = worldBinormal_1.x;
  tmpvar_15.z = worldNormal_3.x;
  mediump vec3 tmpvar_16;
  tmpvar_16.x = worldTangent_2.y;
  tmpvar_16.y = worldBinormal_1.y;
  tmpvar_16.z = worldNormal_3.y;
  mediump vec3 tmpvar_17;
  tmpvar_17.x = worldTangent_2.z;
  tmpvar_17.y = worldBinormal_1.z;
  tmpvar_17.z = worldNormal_3.z;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(_glesNormal);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_20;
  highp vec3 tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_20 = _glesTANGENT.xyz;
  tmpvar_21 = (((tmpvar_18.yzx * tmpvar_19.zxy) - (tmpvar_18.zxy * tmpvar_19.yzx)) * _glesTANGENT.w);
  tmpvar_22 = _glesNormal;
  highp mat3 tmpvar_23;
  tmpvar_23[0].x = tmpvar_20.x;
  tmpvar_23[0].y = tmpvar_21.x;
  tmpvar_23[0].z = tmpvar_22.x;
  tmpvar_23[1].x = tmpvar_20.y;
  tmpvar_23[1].y = tmpvar_21.y;
  tmpvar_23[1].z = tmpvar_22.y;
  tmpvar_23[2].x = tmpvar_20.z;
  tmpvar_23[2].y = tmpvar_21.z;
  tmpvar_23[2].z = tmpvar_22.z;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = _WorldSpaceCameraPos;
  tmpvar_7 = normalize((tmpvar_23 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_24)
  .xyz)));
  highp float fogTune_25;
  fogTune_25 = _FogTune;
  mediump vec4 tmpvar_26;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_27;
    highp vec3 tmpvar_28;
    tmpvar_28 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_29;
    tmpvar_29 = max (0.0, (sqrt(
      dot (tmpvar_28, tmpvar_28)
    ) - _FogStartDistance));
    highp float tmpvar_30;
    tmpvar_30 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_29))
       * 
        (_FogIntensity * tmpvar_29)
      ) * fogTune_25)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_31;
    tmpvar_31 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_29)) * (_FogColorIntensity * tmpvar_29))
    ), 0.0, 1.0)));
    fogColor_27.xyz = tmpvar_31;
    fogColor_27.w = tmpvar_30;
    tmpvar_26 = fogColor_27;
  } else {
    mediump vec4 fogColor_32;
    highp vec3 tmpvar_33;
    tmpvar_33 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_34;
    tmpvar_34 = max (0.0, (sqrt(
      dot (tmpvar_33, tmpvar_33)
    ) - _FogStartDistance));
    highp float tmpvar_35;
    tmpvar_35 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_25)), _FogEffectLimit);
    highp vec3 tmpvar_36;
    tmpvar_36 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_34) / max (0.1, ((_FogEndDistance * fogTune_25) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_32.xyz = tmpvar_36;
    fogColor_32.w = tmpvar_35;
    tmpvar_26 = fogColor_32;
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = tmpvar_6;
  xlv_COLOR1 = tmpvar_26;
  xlv_TEXCOORD2 = tmpvar_15;
  xlv_TEXCOORD3 = tmpvar_16;
  xlv_TEXCOORD4 = tmpvar_17;
  xlv_TEXCORRD5 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform sampler2D _MainTex;
uniform sampler2D _BumpMap;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec3 xlv_TEXCORRD5;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 mc_2;
  highp vec3 worldNorm_3;
  mediump vec3 normals_4;
  mediump vec4 tex_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  normals_4 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD2, normals_4);
  worldNorm_3.x = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD3, normals_4);
  worldNorm_3.y = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = dot (xlv_TEXCOORD4, normals_4);
  worldNorm_3.z = tmpvar_10;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_MatrixV[0].xyz;
  tmpvar_11[1] = unity_MatrixV[1].xyz;
  tmpvar_11[2] = unity_MatrixV[2].xyz;
  worldNorm_3 = (tmpvar_11 * worldNorm_3);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (worldNorm_3, normalize((xlv_TEXCORRD5 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCORRD5) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((tmpvar_12.xy * 0.5) + 0.5);
  tmpvar_13 = texture2D (_MatCap, P_14);
  mediump vec4 tmpvar_15;
  tmpvar_15 = ((tmpvar_13 * tex_5) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  mc_2 = tmpvar_15;
  mediump vec3 srcColor_16;
  srcColor_16 = mc_2.xyz;
  mediump vec3 tmpvar_17;
  tmpvar_17 = mix (srcColor_16, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mc_2.xyz = tmpvar_17;
  tmpvar_1 = mc_2;
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
Keywords { "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "MATCAP_ACCURATE" }
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
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "MATCAP_ACCURATE" }
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
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "MATCAP_ACCURATE" }
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "MATCAP_ACCURATE" }
""
}
}
}
}
Fallback "VertexLit"
}