//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/AirEffect_LightMap_Water" {
Properties {
_WaterColor ("Water Color", Color) = (1,0,0,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Speed ("Speed", Range(0.001, 2)) = 0.5
_Frequency ("Frequency", Range(1, 100)) = 20
_Delta1 ("Delta1", Range(0, 0.1)) = 0.01
_Delta2 ("Delta2", Range(0, 0.1)) = 0.01
_WaterScale ("WaterScale", Range(0, 10)) = 3
_MainIntensity ("MainIntensity", Range(0, 5)) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
}
SubShader {
 LOD 200
 Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "DrawDepth" = "FrontFace" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 40664
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _LightMapIntensity;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = mix (colorBlendLightMap_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" "_UNDERWATER_FOG" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
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
uniform highp float _UWFogColorNFIntensity;
uniform highp float _UWFogDensity;
uniform highp float _UWFogEffectStart;
uniform highp float _UWFogEffectLimit;
uniform highp float _UWFogDistStart;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec4 xlv_COLOR2;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_4 = _glesMultiTexCoord1.xy;
  mediump vec4 tmpvar_6;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_7;
    highp vec3 tmpvar_8;
    tmpvar_8 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_9;
    tmpvar_9 = max (0.0, (sqrt(
      dot (tmpvar_8, tmpvar_8)
    ) - _FogStartDistance));
    highp float tmpvar_10;
    tmpvar_10 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_9)
      ) * (_FogIntensity * tmpvar_9))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_11;
    tmpvar_11 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_9)) * (_FogColorIntensity * tmpvar_9))
    ), 0.0, 1.0)));
    fogColor_7.xyz = tmpvar_11;
    fogColor_7.w = tmpvar_10;
    tmpvar_6 = fogColor_7;
  } else {
    mediump vec4 fogColor_12;
    highp vec3 tmpvar_13;
    tmpvar_13 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_14;
    tmpvar_14 = max (0.0, (sqrt(
      dot (tmpvar_13, tmpvar_13)
    ) - _FogStartDistance));
    highp float tmpvar_15;
    highp float tmpvar_16;
    tmpvar_16 = (_FogEndDistance - _FogStartDistance);
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_17;
    tmpvar_17 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, tmpvar_16))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_17;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  mediump vec3 fogParam_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_ObjectToWorld * _glesVertex);
  highp vec2 tmpvar_20;
  tmpvar_20 = (tmpvar_19.xz - _WorldSpaceCameraPos.xz);
  highp float tmpvar_21;
  tmpvar_21 = max (0.0, (sqrt(
    dot (tmpvar_20, tmpvar_20)
  ) - _UWFogDistStart));
  highp float tmpvar_22;
  tmpvar_22 = min (max ((
    (1.0 - exp((-(
      (_UWFogDensity * tmpvar_21)
    ) * (_UWFogDensity * tmpvar_21))))
   * _UWFogEffectLimit), _UWFogEffectStart), _UWFogEffectLimit);
  highp float tmpvar_23;
  tmpvar_23 = clamp (exp((
    -((_UWFogColorNFIntensity * tmpvar_21))
   * 
    (_UWFogColorNFIntensity * tmpvar_21)
  )), 0.0, 1.0);
  fogParam_18.x = tmpvar_23;
  fogParam_18.y = tmpvar_22;
  fogParam_18.z = tmpvar_19.y;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
  xlv_COLOR2 = tmpvar_1;
  xlv_TEXCOORD2 = fogParam_18;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
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
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
uniform highp float _Speed;
uniform highp float _Frequency;
uniform highp float _Delta1;
uniform highp float _WaterScale;
uniform highp float _MainIntensity;
uniform highp vec4 _WaterColor;
uniform mediump float _LumiFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump float dy_4;
  mediump float dx_5;
  mediump vec4 outColor_6;
  outColor_6.w = 0.0;
  highp float coord_7;
  coord_7 = xlv_TEXCOORD0.x;
  highp float tmpvar_8;
  tmpvar_8 = (_Time.y * _Speed);
  coord_7 = (coord_7 + tmpvar_8);
  highp float tmpvar_9;
  tmpvar_9 = (cos((coord_7 * _Frequency)) * _Delta1);
  dx_5 = tmpvar_9;
  highp float coord_10;
  coord_10 = xlv_TEXCOORD0.y;
  coord_10 = (coord_10 + tmpvar_8);
  highp float tmpvar_11;
  tmpvar_11 = (cos((coord_10 * _Frequency)) * _Delta1);
  dy_4 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = dx_5;
  tmpvar_12.y = dy_4;
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD0 + tmpvar_12) * _WaterScale);
  tmpvar_13 = texture2D (_MainTex, P_14);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_13 * _MainIntensity);
  tex_C_Color_3 = tmpvar_15;
  tex_C_Color_3.xyz = (tex_C_Color_3.xyz * _WaterColor.xyz);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_16;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * (
    (((2.0 * tex_S_Color_2.xyz) * tex_S_Color_2.w) + 1.0)
   - tex_S_Color_2.w)) * _LightMapIntensity);
  outColor_6.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD2.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_17;
    xlat_varinput_17 = xlv_TEXCOORD2;
    mediump vec3 fogParam_18;
    highp float tmpvar_19;
    tmpvar_19 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD2.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_20;
    tmpvar_20 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_19))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_21;
    tmpvar_21 = clamp ((_UWFogColorHLIntensity * tmpvar_19), 0.0, 1.0);
    fogParam_18.z = 0.0;
    fogParam_18.y = tmpvar_20;
    fogParam_18.x = tmpvar_21;
    if ((xlv_TEXCOORD2.y > 0.99)) {
      xlat_varinput_17.y = (xlv_TEXCOORD2.y * (1.0 - (tmpvar_19 * _UWHeightRatio)));
      highp float tmpvar_22;
      tmpvar_22 = clamp (xlat_varinput_17.y, _UWCriticalRange, 1.0);
      xlat_varinput_17.y = tmpvar_22;
    };
    fogParam_18.z = (1.0 - xlat_varinput_17.y);
    mediump vec4 tmpvar_23;
    tmpvar_23.w = 0.0;
    tmpvar_23.xyz = outColor_6.xyz;
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD2.xxxx), tmpvar_23, fogParam_18.zzzz).xyz;
    outColor_6.xyz = tmpvar_24;
    mediump vec4 tmpvar_25;
    tmpvar_25.w = 0.0;
    tmpvar_25.xyz = outColor_6.xyz;
    highp vec3 tmpvar_26;
    tmpvar_26 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_18.xxxx), tmpvar_25, fogParam_18.yyyy).xyz;
    outColor_6.xyz = tmpvar_26;
  };
  outColor_6.w = _WaterColor.w;
  outColor_6.xyz = mix (outColor_6.xyz, vec3(dot (outColor_6.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  outColor_6.w = clamp (outColor_6.w, 0.0, 1.0);
  gl_FragData[0] = outColor_6;
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
}
}
}
Fallback "Diffuse"
}