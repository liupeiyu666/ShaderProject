//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Air_Texture_Flow_Soft_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Mask Threshold", Float) = 1
_FlowMask ("Flow Mask(R)", 2D) = "white" { }
_MainTex ("Base (RGB) Trans (A) 0", 2D) = "white" { }
_RotateCt ("RotateCt", Float) = 1.57
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
 Tags { "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 20280
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_7;
  highp vec4 tex3_8;
  mediump vec4 col1_9;
  mediump float maskValue_10;
  highp vec4 tex2_11;
  mediump float yScrollValue2_12;
  mediump float xScrollValue2_13;
  highp float tmpvar_14;
  tmpvar_14 = cos(_RotateCt);
  highp float tmpvar_15;
  tmpvar_15 = sin(_RotateCt);
  highp mat2 tmpvar_16;
  tmpvar_16[0].x = tmpvar_14;
  tmpvar_16[0].y = tmpvar_15;
  tmpvar_16[1].x = -(tmpvar_15);
  tmpvar_16[1].y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_16) + vec2(0.5, 0.5));
  highp float tmpvar_18;
  tmpvar_18 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_13 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_12 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xScrollValue2_13;
  tmpvar_20.y = yScrollValue2_12;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_20);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex2, tmpvar_1);
  tex2_11 = tmpvar_21;
  lowp float tmpvar_22;
  tmpvar_22 = texture2D (_FlowMask, tmpvar_17).x;
  maskValue_10 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23.x = xlv_TEXCOORD0.x;
  tmpvar_23.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_23);
  tex3_8 = tmpvar_25;
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_24);
  tex4_7 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = clamp ((maskValue_10 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_28;
  tmpvar_28 = clamp ((tmpvar_27 * (tmpvar_27 * 
    (3.0 - (2.0 * tmpvar_27))
  )), 0.0, 1.0);
  highp vec4 tmpvar_29;
  tmpvar_29 = mix (tex3_8, tex4_7, vec4(tmpvar_28));
  col1_9 = tmpvar_29;
  highp vec4 tmpvar_30;
  tmpvar_30 = (tex2_11 * _MainColor2);
  col2_6.xyz = tmpvar_30.xyz;
  col2_6.w = _Opacity2;
  colAll_5.w = 0.0;
  colAll_5.xyz = ((col1_9.w * col1_9.xyz) + (col2_6.w * col2_6.xyz));
  mediump vec4 tmpvar_31;
  tmpvar_31 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_4.w = tmpvar_31.w;
  lowp vec4 color_32;
  color_32 = tmpvar_31;
  lmtex_4.xyz = (unity_Lightmap_HDR.x * color_32.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = (lmtex_4.xyz * _LightMapIntensity);
  fcc_3 = tmpvar_33;
  mediump vec3 tmpvar_34;
  tmpvar_34 = ((colAll_5.xyz * _Color.xyz) * (fcc_3 + _LightingColor));
  colorBlendLightMap_2 = tmpvar_34;
  mediump vec3 srcColor_35;
  srcColor_35 = colorBlendLightMap_2;
  colAll_5.xyz = mix (srcColor_35, xlv_COLOR1.xyz, xlv_COLOR1.www);
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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
  highp vec4 tex4_4;
  highp vec4 tex3_5;
  mediump vec4 col1_6;
  mediump float maskValue_7;
  highp vec4 tex2_8;
  mediump float yScrollValue2_9;
  mediump float xScrollValue2_10;
  highp float tmpvar_11;
  tmpvar_11 = cos(_RotateCt);
  highp float tmpvar_12;
  tmpvar_12 = sin(_RotateCt);
  highp mat2 tmpvar_13;
  tmpvar_13[0].x = tmpvar_11;
  tmpvar_13[0].y = tmpvar_12;
  tmpvar_13[1].x = -(tmpvar_12);
  tmpvar_13[1].y = tmpvar_11;
  highp vec2 tmpvar_14;
  tmpvar_14 = (((xlv_TEXCOORD0 - vec2(0.5, 0.5)) * tmpvar_13) + vec2(0.5, 0.5));
  highp float tmpvar_15;
  tmpvar_15 = (_ScrollXSpeed2 * _Time).x;
  xScrollValue2_10 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_ScrollYSpeed2 * _Time).x;
  yScrollValue2_9 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17.x = xScrollValue2_10;
  tmpvar_17.y = yScrollValue2_9;
  tmpvar_1 = (xlv_TEXCOORD2 + tmpvar_17);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_MainTex2, tmpvar_1);
  tex2_8 = tmpvar_18;
  lowp float tmpvar_19;
  tmpvar_19 = texture2D (_FlowMask, tmpvar_14).x;
  maskValue_7 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y / 2.0);
  mediump vec2 tmpvar_21;
  tmpvar_21.x = xlv_TEXCOORD0.x;
  tmpvar_21.y = ((xlv_TEXCOORD0.y - 1.0) / 2.0);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_MainTex, tmpvar_20);
  tex3_5 = tmpvar_22;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_21);
  tex4_4 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = clamp ((maskValue_7 / (_EmissionScaler * 4.0)), 0.0, 1.0);
  mediump float tmpvar_25;
  tmpvar_25 = clamp ((tmpvar_24 * (tmpvar_24 * 
    (3.0 - (2.0 * tmpvar_24))
  )), 0.0, 1.0);
  highp vec4 tmpvar_26;
  tmpvar_26 = mix (tex3_5, tex4_4, vec4(tmpvar_25));
  col1_6 = tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (tex2_8 * _MainColor2);
  col2_3.xyz = tmpvar_27.xyz;
  col2_3.w = _Opacity2;
  colAll_2.w = 0.0;
  colAll_2.xyz = ((col1_6.w * col1_6.xyz) + (col2_3.w * col2_3.xyz));
  if ((xlv_TEXCOORD3.z < _WaterPlaneHeight)) {
    mediump vec3 xlat_varinput_28;
    xlat_varinput_28 = xlv_TEXCOORD3;
    mediump vec3 fogParam_29;
    highp float tmpvar_30;
    tmpvar_30 = max (0.0, ((_WaterPlaneHeight - xlv_TEXCOORD3.z) / (_WaterPlaneHeight - _UWFogHeightEnd)));
    highp float tmpvar_31;
    tmpvar_31 = min (max ((
      (1.0 - (_UWHeightFogDensity * tmpvar_30))
     * _UWHeightFogEffectLimit), _UWHeightFogEffectStart), _UWHeightFogEffectLimit);
    highp float tmpvar_32;
    tmpvar_32 = clamp ((_UWFogColorHLIntensity * tmpvar_30), 0.0, 1.0);
    fogParam_29.z = 0.0;
    fogParam_29.y = tmpvar_31;
    fogParam_29.x = tmpvar_32;
    if ((xlv_TEXCOORD3.y > 0.99)) {
      xlat_varinput_28.y = (xlv_TEXCOORD3.y * (1.0 - (tmpvar_30 * _UWHeightRatio)));
      highp float tmpvar_33;
      tmpvar_33 = clamp (xlat_varinput_28.y, _UWCriticalRange, 1.0);
      xlat_varinput_28.y = tmpvar_33;
    };
    fogParam_29.z = (1.0 - xlat_varinput_28.y);
    mediump vec4 tmpvar_34;
    tmpvar_34.w = 0.0;
    tmpvar_34.xyz = colAll_2.xyz;
    highp vec3 tmpvar_35;
    tmpvar_35 = mix (mix (_UWFogColorFar, _UWFogColorNear, xlv_TEXCOORD3.xxxx), tmpvar_34, fogParam_29.zzzz).xyz;
    colAll_2.xyz = tmpvar_35;
    mediump vec4 tmpvar_36;
    tmpvar_36.w = 0.0;
    tmpvar_36.xyz = colAll_2.xyz;
    highp vec3 tmpvar_37;
    tmpvar_37 = mix (mix (_UWFogColorLow, _UWFogColorHigh, fogParam_29.xxxx), tmpvar_36, fogParam_29.yyyy).xyz;
    colAll_2.xyz = tmpvar_37;
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