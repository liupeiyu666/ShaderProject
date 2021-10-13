//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Air_LightMap_UI" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_ShadowIntegration ("Shadow Integration", Range(0, 1)) = 0.2
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  ZTest Off
  Cull Off
  GpuProgramID 13986
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
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
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
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
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_7;
    xlat_varinput_7 = xlv_TEXCOORD3;
    mediump vec3 fogParam_8;
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_9))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_11;
    tmpvar_11 = clamp ((_UWFogColorHLIntensity * tmpvar_9), 0.0, 1.0);
    fogParam_8.z = 0.0;
    fogParam_8.y = tmpvar_10;
    fogParam_8.x = tmpvar_11;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_7.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_9 * _UWHeightRatio)));
      highp float tmpvar_12;
      tmpvar_12 = clamp (xlat_varinput_7.y, _UWCriticalRange, 1.0);
      xlat_varinput_7.y = tmpvar_12;
    };
    fogParam_8.z = (1.0 - xlat_varinput_7.y);
    mediump vec4 tmpvar_13;
    tmpvar_13.w = 0.0;
    tmpvar_13.xyz = outColor_4.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_13, fogParam_8.zzzz).xyz;
    outColor_4.xyz = tmpvar_14;
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 0.0;
    tmpvar_15.xyz = outColor_4.xyz;
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_8.xxxx), tmpvar_15, fogParam_8.yyyy).xyz;
    outColor_4.xyz = tmpvar_16;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
  outColor_4.w = _BloomFactor;
  outColor_4.xyz = mix (outColor_4.xyz, vec3(dot (outColor_4.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _ShadowTex_ST;
uniform mediump float _FogTune;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord1.xy * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  highp float fogTune_8;
  fogTune_8 = _FogTune;
  mediump vec4 tmpvar_9;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_10;
    highp vec3 tmpvar_11;
    tmpvar_11 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, (sqrt(
      dot (tmpvar_11, tmpvar_11)
    ) - _FogStartDistance));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_12))
       * 
        (_FogIntensity * tmpvar_12)
      ) * fogTune_8)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_14;
    tmpvar_14 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_12)) * (_FogColorIntensity * tmpvar_12))
    ), 0.0, 1.0)));
    fogColor_10.xyz = tmpvar_14;
    fogColor_10.w = tmpvar_13;
    tmpvar_9 = fogColor_10;
  } else {
    mediump vec4 fogColor_15;
    highp vec3 tmpvar_16;
    tmpvar_16 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_17;
    tmpvar_17 = max (0.0, (sqrt(
      dot (tmpvar_16, tmpvar_16)
    ) - _FogStartDistance));
    highp float tmpvar_18;
    tmpvar_18 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_8)), _FogEffectLimit);
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_17) / max (0.1, ((_FogEndDistance * fogTune_8) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_15.xyz = tmpvar_19;
    fogColor_15.w = tmpvar_18;
    tmpvar_9 = fogColor_15;
  };
  mediump vec3 fogParam_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_22;
  tmpvar_22 = (tmpvar_21.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_23;
  tmpvar_23 = max (0.0, (sqrt(
    dot (tmpvar_22, tmpvar_22)
  ) - _UWFogDistStart));
  highp float tmpvar_24;
  tmpvar_24 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_23)
    ) * (_UWFogDensity * tmpvar_23))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_25;
  tmpvar_25 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_23))
   * 
    (_UWFogColorNFIntensity * tmpvar_23)
  )), 0.0, 1.0);
  fogParam_20.x = tmpvar_25;
  fogParam_20.y = tmpvar_24;
  fogParam_20.z = tmpvar_21.y;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR1 = tmpvar_9;
  xlv_TEXCOORD2 = o_5;
  xlv_TEXCOORD3 = fogParam_20;
}


#endif
#ifdef FRAGMENT
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicSceneShadowVolumeBuffer;
uniform highp vec4 _UWFogColorNear;
uniform highp vec4 _UWFogColorFar;
uniform highp vec4 _UWFogColorHigh;
uniform highp vec4 _UWFogColorLow;
uniform highp float _UWFogColorHLIntensity;
uniform highp float _UWHeightFogDensity;
uniform highp float _UWHeightFogEffectStart;
uniform highp float _UWHeightFogEffectLimit;
uniform highp float _UWFogHeightEnd;
uniform highp float _WaterPlaneHeight;
uniform highp float _UWCriticalRange;
uniform highp float _UWHeightRatio;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform mediump float _ShadowIntegration;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_6;
  highp vec2 screenCoord_7;
  screenCoord_7 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_8;
  shadow_8 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_DynamicSceneShadowVolumeBuffer, screenCoord_7);
    shadow_8 = tmpvar_9.x;
  };
  colorBlendLightMap_1 = (((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * (1.0 - 
    (_ShadowIntegration * (1.0 - shadow_8))
  )) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_10;
    xlat_varinput_10 = xlv_TEXCOORD3;
    mediump vec3 fogParam_11;
    highp float tmpvar_12;
    tmpvar_12 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_13;
    tmpvar_13 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_12))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_14;
    tmpvar_14 = clamp ((_UWFogColorHLIntensity * tmpvar_12), 0.0, 1.0);
    fogParam_11.z = 0.0;
    fogParam_11.y = tmpvar_13;
    fogParam_11.x = tmpvar_14;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_10.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_12 * _UWHeightRatio)));
      highp float tmpvar_15;
      tmpvar_15 = clamp (xlat_varinput_10.y, _UWCriticalRange, 1.0);
      xlat_varinput_10.y = tmpvar_15;
    };
    fogParam_11.z = (1.0 - xlat_varinput_10.y);
    mediump vec4 tmpvar_16;
    tmpvar_16.w = 0.0;
    tmpvar_16.xyz = outColor_4.xyz;
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_16, fogParam_11.zzzz).xyz;
    outColor_4.xyz = tmpvar_17;
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = outColor_4.xyz;
    highp vec3 tmpvar_19;
    tmpvar_19 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_11.xxxx), tmpvar_18, fogParam_11.yyyy).xyz;
    outColor_4.xyz = tmpvar_19;
  };
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
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_DYNAMIC_SCENE_SHADOW_ON" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" "_UNDERWATER_FOG" "_DYNAMIC_SCENE_SHADOW_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
}