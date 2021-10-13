//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Air_LightMap" {
Properties {
_LightMapIntensity ("Light Map Intensity", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_ShadowTex ("LightMap (RGB)", 2D) = "grey" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
[Toggle(LUMINANCE)] _Luminance ("Luminance", Float) = 0
_LumiFactor ("Luminance Factor", Float) = 0
_Transparent ("_Trans", Range(0, 1)) = 1
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 22235
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
uniform highp float _LightMapIntensity;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _ShadowTex;
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
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
uniform highp vec4 _ScreenParams;
uniform highp float _Transparent;
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
varying highp vec4 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 colorBlendLightMap_1;
  mediump vec4 tex_S_Color_2;
  mediump vec4 tex_C_Color_3;
  mediump vec4 outColor_4;
  highp float THRESHOLDS_MATRIX_5[16];
  THRESHOLDS_MATRIX_5[0] = 0.05882353;
  THRESHOLDS_MATRIX_5[1] = 0.5294118;
  THRESHOLDS_MATRIX_5[2] = 0.1764706;
  THRESHOLDS_MATRIX_5[3] = 0.6470588;
  THRESHOLDS_MATRIX_5[4] = 0.7647059;
  THRESHOLDS_MATRIX_5[5] = 0.2941177;
  THRESHOLDS_MATRIX_5[6] = 0.8823529;
  THRESHOLDS_MATRIX_5[7] = 0.4117647;
  THRESHOLDS_MATRIX_5[8] = 0.2352941;
  THRESHOLDS_MATRIX_5[9] = 0.7058824;
  THRESHOLDS_MATRIX_5[10] = 0.1176471;
  THRESHOLDS_MATRIX_5[11] = 0.5882353;
  THRESHOLDS_MATRIX_5[12] = 0.9411765;
  THRESHOLDS_MATRIX_5[13] = 0.4705882;
  THRESHOLDS_MATRIX_5[14] = 0.8235294;
  THRESHOLDS_MATRIX_5[15] = 0.3529412;
  if ((_Transparent < 0.95)) {
    highp vec2 tmpvar_6;
    tmpvar_6 = ((xlv_TEXCOORD2 / xlv_TEXCOORD2.w).xy * _ScreenParams.xy);
    highp float tmpvar_7;
    tmpvar_7 = (tmpvar_6.x / 4.0);
    highp float tmpvar_8;
    tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
    highp float tmpvar_9;
    if ((tmpvar_7 >= 0.0)) {
      tmpvar_9 = tmpvar_8;
    } else {
      tmpvar_9 = -(tmpvar_8);
    };
    highp float tmpvar_10;
    tmpvar_10 = (tmpvar_6.y / 4.0);
    highp float tmpvar_11;
    tmpvar_11 = (fract(abs(tmpvar_10)) * 4.0);
    highp float tmpvar_12;
    if ((tmpvar_10 >= 0.0)) {
      tmpvar_12 = tmpvar_11;
    } else {
      tmpvar_12 = -(tmpvar_11);
    };
    highp float x_13;
    x_13 = (_Transparent - THRESHOLDS_MATRIX_5[int((
      (tmpvar_9 * 4.0)
     + tmpvar_12))]);
    if ((x_13 < 0.0)) {
      discard;
    };
  };
  outColor_4.w = 0.0;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_3 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  tex_S_Color_2 = tmpvar_15;
  colorBlendLightMap_1 = ((tex_C_Color_3.xyz * tex_S_Color_2.xyz) * _LightMapIntensity);
  outColor_4.xyz = colorBlendLightMap_1;
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_16;
    xlat_varinput_16 = xlv_TEXCOORD3;
    mediump vec3 fogParam_17;
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_19;
    tmpvar_19 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_18))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_20;
    tmpvar_20 = clamp ((_UWFogColorHLIntensity * tmpvar_18), 0.0, 1.0);
    fogParam_17.z = 0.0;
    fogParam_17.y = tmpvar_19;
    fogParam_17.x = tmpvar_20;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_16.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_18 * _UWHeightRatio)));
      highp float tmpvar_21;
      tmpvar_21 = clamp (xlat_varinput_16.y, _UWCriticalRange, 1.0);
      xlat_varinput_16.y = tmpvar_21;
    };
    fogParam_17.z = (1.0 - xlat_varinput_16.y);
    mediump vec4 tmpvar_22;
    tmpvar_22.w = 0.0;
    tmpvar_22.xyz = outColor_4.xyz;
    highp vec3 tmpvar_23;
    tmpvar_23 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_22, fogParam_17.zzzz).xyz;
    outColor_4.xyz = tmpvar_23;
    mediump vec4 tmpvar_24;
    tmpvar_24.w = 0.0;
    tmpvar_24.xyz = outColor_4.xyz;
    highp vec3 tmpvar_25;
    tmpvar_25 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_17.xxxx), tmpvar_24, fogParam_17.yyyy).xyz;
    outColor_4.xyz = tmpvar_25;
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
}