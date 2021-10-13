//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_LightMap_Swing" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_ObjectHeight ("Object Height", Float) = 1
_ObjectMoveScale ("Object MoveScale", Range(0, 1)) = 0.4
_ObjectPivot ("Object MoveScale", Vector) = (0,0,0,0)
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "DisableBatching" = "true" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DisableBatching" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 22000
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _miHoYo_WindParams3;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _ObjectMoveScale;
uniform mediump vec4 _ObjPivot;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp float tmpvar_5;
  tmpvar_5 = (sin((
    (_miHoYo_WindParams3.x + tmpvar_4.x)
   + 
    (tmpvar_4.y + tmpvar_4.z)
  )) * _ObjectMoveScale);
  highp vec3 vert_6;
  highp vec3 pivot_7;
  pivot_7 = _ObjPivot.xyz;
  highp float tmpvar_8;
  tmpvar_8 = sqrt((1.0 - (tmpvar_5 * tmpvar_5)));
  vert_6 = (_glesVertex.xyz - pivot_7);
  highp float tmpvar_9;
  tmpvar_9 = ((-(tmpvar_5) * vert_6.x) + (tmpvar_8 * vert_6.y));
  vert_6.x = ((tmpvar_8 * vert_6.x) + (tmpvar_5 * vert_6.y));
  vert_6.y = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.xyz = (vert_6 + pivot_7);
  tmpvar_10.w = _glesVertex.w;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_10.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_12;
  fogTune_12 = _FogTune;
  mediump vec4 tmpvar_13;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_14;
    highp vec3 tmpvar_15;
    tmpvar_15 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_16;
    tmpvar_16 = max (0.0, (sqrt(
      dot (tmpvar_15, tmpvar_15)
    ) - _FogStartDistance));
    highp float tmpvar_17;
    tmpvar_17 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_16))
       * 
        (_FogIntensity * tmpvar_16)
      ) * fogTune_12)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_18;
    tmpvar_18 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_16)) * (_FogColorIntensity * tmpvar_16))
    ), 0.0, 1.0)));
    fogColor_14.xyz = tmpvar_18;
    fogColor_14.w = tmpvar_17;
    tmpvar_13 = fogColor_14;
  } else {
    mediump vec4 fogColor_19;
    highp vec3 tmpvar_20;
    tmpvar_20 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_21;
    tmpvar_21 = max (0.0, (sqrt(
      dot (tmpvar_20, tmpvar_20)
    ) - _FogStartDistance));
    highp float tmpvar_22;
    tmpvar_22 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_12)), _FogEffectLimit);
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_21) / max (0.1, ((_FogEndDistance * fogTune_12) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_19.xyz = tmpvar_23;
    fogColor_19.w = tmpvar_22;
    tmpvar_13 = fogColor_19;
  };
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_13;
}


#endif
#ifdef FRAGMENT
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
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