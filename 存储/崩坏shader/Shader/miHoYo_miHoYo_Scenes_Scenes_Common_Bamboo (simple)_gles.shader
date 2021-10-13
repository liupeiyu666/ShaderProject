//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Bamboo (simple)" {
Properties {
_MayaScale ("Scale Compared to Maya", Float) = 0.01
_Scale ("Scale", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_Width ("Width", Range(0.0001, 1)) = 0.0001
_Ambient ("Ambient", Range(0.01, 10)) = 1
_AmbientRimIndex ("Ambient Rim Index", Range(0.01, 100)) = 10
_AmbientRimScale ("Ambient Rim Scale", Range(0.01, 10)) = 0
_Diffuse ("Diffuse", Range(0.01, 10)) = 1
_Specular ("Specular", Range(0.01, 10)) = 1
_Shininess ("Shininess", Range(0.01, 100)) = 10
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_LightDir ("Light Dir", Vector) = (0,0,1,0)
_LightUp ("Light Up", Vector) = (0,1,0,0)
_LightRight ("Light Right", Vector) = (1,0,0,0)
_ShadowTex ("Shadow Tex (R)", 2D) = "white" { }
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend InTensity", Range(0, 1)) = 0
_BendSpeed ("Bend Speed", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 34252
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
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
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform highp float _Width;
varying highp vec4 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 posInW_1;
  highp float dirSign_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = _glesColor;
  mediump float tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_2 = tmpvar_6;
  highp vec4 v_7;
  v_7.x = unity_MatrixV[0].z;
  v_7.y = unity_MatrixV[1].z;
  v_7.z = unity_MatrixV[2].z;
  v_7.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize(v_7.xyz);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9 * _glesNormal);
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_ObjectToWorld * _glesVertex);
  posInW_1.w = tmpvar_11.w;
  posInW_1.xyz = (tmpvar_11.xyz + ((
    (((dirSign_2 * _Width) * _MayaScale) * normalize(((tmpvar_8.yzx * tmpvar_10.zxy) - (tmpvar_8.zxy * tmpvar_10.yzx))))
   * _glesColor.x) * _Scale));
  tmpvar_3 = (unity_MatrixVP * posInW_1);
  mediump vec4 tmpvar_12;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_13;
    highp vec3 tmpvar_14;
    tmpvar_14 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_15;
    tmpvar_15 = max (0.0, (sqrt(
      dot (tmpvar_14, tmpvar_14)
    ) - _FogStartDistance));
    highp float tmpvar_16;
    tmpvar_16 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_15)
      ) * (_FogIntensity * tmpvar_15))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_15)) * (_FogColorIntensity * tmpvar_15))
    ), 0.0, 1.0)));
    fogColor_13.xyz = tmpvar_17;
    fogColor_13.w = tmpvar_16;
    tmpvar_12 = fogColor_13;
  } else {
    mediump vec4 fogColor_18;
    highp vec3 tmpvar_19;
    tmpvar_19 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_20;
    tmpvar_20 = max (0.0, (sqrt(
      dot (tmpvar_19, tmpvar_19)
    ) - _FogStartDistance));
    highp float tmpvar_21;
    highp float tmpvar_22;
    tmpvar_22 = (_FogEndDistance - _FogStartDistance);
    tmpvar_21 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_20) / max (0.1, tmpvar_22))
    , 0.0, 1.0))));
    fogColor_18.xyz = tmpvar_23;
    fogColor_18.w = tmpvar_21;
    tmpvar_12 = fogColor_18;
  };
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_12;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 diffTex_1;
  mediump vec4 color_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_1 = tmpvar_3;
  color_2 = (diffTex_1 * _Ambient);
  color_2.xyz = mix (color_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_2.w = _BloomFactor;
  color_2.xyz = mix (color_2.xyz, vec3(dot (color_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_2;
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
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
Fallback "Diffuse"
}