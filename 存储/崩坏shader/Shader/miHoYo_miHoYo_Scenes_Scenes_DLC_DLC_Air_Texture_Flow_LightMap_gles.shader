//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Air_Texture_Flow_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Mask Threshold", Float) = 1
_FlowMask ("Flow Mask(R)", 2D) = "white" { }
_MainTex ("Base (RGB) Trans (A) 0", 2D) = "white" { }
_RotateCt ("RotateCt", Float) = 1.55
_MainTex2 ("Texture2", 2D) = "black" { }
_MainColor2 ("MainColor2", Color) = (1,1,1,1)
_Opacity2 ("Opacity2", Range(0, 1)) = 1
_ScrollXSpeed2 ("ScrollXSpeed2", Float) = 0
_ScrollYSpeed2 ("ScrollYSpeed2", Float) = 0
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 19319
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec3 colorBlendLightMap_2;
  mediump vec3 fcc_3;
  mediump vec4 lmtex_4;
  mediump vec4 colAll_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  mediump float maskValue_8;
  highp vec4 tex2_9;
  mediump float yScrollValue2_10;
  mediump float xScrollValue2_11;
  highp float tmpvar_12;
  tmpvar_12 = cos(_RotateCt);
  highp float tmpvar_13;
  tmpvar_13 = sin(_RotateCt);
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_12;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_12;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_11 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_10 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xScrollValue2_11;
  tmpvar_18.y = yScrollValue2_10;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_18);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex2, tmpvar_1);
  tex2_9 = tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_20 = texture2D (_FlowMask, tmpvar_15).x;
  maskValue_8 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_22;
  tmpvar_22.x = xlv_TEXCOORD0.x;
  tmpvar_22.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_7 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_8 < _EmissionScaler)) {
    lowp vec4 tmpvar_23;
    tmpvar_23 = texture2D (_MainTex, tmpvar_21);
    col1_7 = tmpvar_23;
  } else {
    lowp vec4 tmpvar_24;
    tmpvar_24 = texture2D (_MainTex, tmpvar_22);
    col1_7 = tmpvar_24;
  };
  highp vec4 tmpvar_25;
  tmpvar_25 = (tex2_9 * _MainColor2);
  col2_6.xyz = tmpvar_25.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_7.w * col1_7.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_26;
  tmpvar_26 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_26.w;
  lowp vec4 color_27;
  color_27 = tmpvar_26;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_27.xyz);
  highp vec3 tmpvar_28;
  tmpvar_28 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_28;
  mediump vec3 tmpvar_29;
  tmpvar_29 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_29;
  mediump vec3 srcColor_30;
  srcColor_30 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_30, xlv_COLOR1.xyz, xlv_COLOR1.www);
  colAll_5.w = _BloomFactor;
  gl_FragData[0] = colAll_5;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
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
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _MainTex2_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  highp vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex2_ST.xy) + _MainTex2_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  gl_Position = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = fogParam_18;
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
uniform sampler2D _MainTex;
uniform sampler2D _FlowMask;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionScaler;
uniform highp float _RotateCt;
uniform sampler2D _MainTex2;
uniform highp vec4 _MainColor2;
uniform highp float _Opacity2;
uniform mediump float _ScrollXSpeed2;
uniform mediump float _ScrollYSpeed2;
varying mediump vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 colAll_2;
  mediump vec4 col2_3;
  mediump vec4 col1_4;
  mediump float maskValue_5;
  highp vec4 tex2_6;
  mediump float yScrollValue2_7;
  mediump float xScrollValue2_8;
  highp float tmpvar_9;
  tmpvar_9 = cos(_RotateCt);
  highp float tmpvar_10;
  tmpvar_10 = sin(_RotateCt);
  highp mat2 tmpvar_11;
  tmpvar_11[0].x = tmpvar_9;
  tmpvar_11[0].y = tmpvar_10;
  tmpvar_11[1].x = -(tmpvar_10);
  tmpvar_11[1].y = tmpvar_9;
  highp vec2 tmpvar_12;
  tmpvar_12 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_11) + vec2(0.5, 0.5));
  highp float tmpvar_13;
  tmpvar_13 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_8 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_7 = tmpvar_14;
  mediump vec2 tmpvar_15;
  tmpvar_15.x = xScrollValue2_8;
  tmpvar_15.y = yScrollValue2_7;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_15);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex2, tmpvar_1);
  tex2_6 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = texture2D (_FlowMask, tmpvar_12).x;
  maskValue_5 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18.x = xlv_TEXCOORD0.x;
  tmpvar_18.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_19;
  tmpvar_19.x = xlv_TEXCOORD0.x;
  tmpvar_19.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  col1_4 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((maskValue_5 < _EmissionScaler)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_MainTex, tmpvar_18);
    col1_4 = tmpvar_20;
  } else {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, tmpvar_19);
    col1_4 = tmpvar_21;
  };
  highp vec4 tmpvar_22;
  tmpvar_22 = (tex2_6 * _MainColor2);
  col2_3.xyz = tmpvar_22.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_4.w * col1_4.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_23;
    xlat_varinput_23 = xlv_TEXCOORD3;
    mediump vec3 fogParam_24;
    highp float tmpvar_25;
    tmpvar_25 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_26;
    tmpvar_26 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_25))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_27;
    tmpvar_27 = clamp ((_UWFogColorHLIntensity * tmpvar_25), 0.0, 1.0);
    fogParam_24.z = 0.0;
    fogParam_24.y = tmpvar_26;
    fogParam_24.x = tmpvar_27;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_23.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_25 * _UWHeightRatio)));
      highp float tmpvar_28;
      tmpvar_28 = clamp (xlat_varinput_23.y, _UWCriticalRange, 1.0);
      xlat_varinput_23.y = tmpvar_28;
    };
    fogParam_24.z = (1.0 - xlat_varinput_23.y);
    mediump vec4 tmpvar_29;
    tmpvar_29.w = 0.0;
    tmpvar_29.xyz = colAll_2.xyz;
    highp vec3 tmpvar_30;
    tmpvar_30 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_29, fogParam_24.zzzz).xyz;
    colAll_2.xyz = tmpvar_30;
    mediump vec4 tmpvar_31;
    tmpvar_31.w = 0.0;
    tmpvar_31.xyz = colAll_2.xyz;
    highp vec3 tmpvar_32;
    tmpvar_32 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_24.xxxx), tmpvar_31, fogParam_24.yyyy).xyz;
    colAll_2.xyz = tmpvar_32;
  };
  colAll_2.w = _BloomFactor;
  gl_FragData[0] = colAll_2;
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
}
}
}
}