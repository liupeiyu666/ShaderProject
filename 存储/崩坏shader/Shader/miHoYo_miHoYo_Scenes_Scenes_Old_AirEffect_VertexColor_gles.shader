//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/AirEffect_VertexColor" {
Properties {
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 8718
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
uniform mediump vec4 _MainTex_ST;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = _glesColor;
  highp float fogTune_5;
  fogTune_5 = _FogTune;
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
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_9))
       * 
        (_FogIntensity * tmpvar_9)
      ) * fogTune_5)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
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
    tmpvar_15 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_5)), _FogEffectLimit);
    highp vec3 tmpvar_16;
    tmpvar_16 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_14) / max (0.1, ((_FogEndDistance * fogTune_5) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_12.xyz = tmpvar_16;
    fogColor_12.w = tmpvar_15;
    tmpvar_6 = fogColor_12;
  };
  gl_Position = tmpvar_1;
  xlv_COLOR0 = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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