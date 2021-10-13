//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Rotate_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_RotateTex ("RotateTexture", 2D) = "white" { }
_RotateColor ("RotateColor", Color) = (1,1,1,1)
_RotateOpacity ("RotateOpacity", Range(0, 1)) = 1
_RotateSpeed ("RotateSpeed", Float) = 0
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 LOD 100
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 100
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 19784
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  mediump vec4 tmpvar_20;
  tmpvar_20 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lmtex_3.w = tmpvar_20.w;
  lowp vec4 color_21;
  color_21 = tmpvar_20;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_21.xyz);
  highp vec3 tmpvar_22;
  tmpvar_22 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_23;
  mediump vec3 srcColor_24;
  srcColor_24 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_24, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_25;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
uniform highp vec4 _PropertyLightmapTexTS;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _RotateTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _RotateTex_ST.xy) + _RotateTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_COLOR1 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec4 _SinTime;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp vec4 _MainColor;
uniform sampler2D _RotateTex;
uniform highp vec4 _RotateColor;
uniform highp float _RotateOpacity;
uniform mediump float _RotateSpeed;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump vec4 tex_C_Color_4;
  mediump vec4 outColor_5;
  mediump vec4 col2_6;
  mediump vec4 col1_7;
  highp vec4 tex2_8;
  highp vec4 tex1_9;
  mediump float RotateCt_10;
  RotateCt_10 = 0.0;
  if ((_SinTime.z > 0.0)) {
    RotateCt_10 = _SinTime.z;
  } else {
    if ((_SinTime.z <= 0.0)) {
      RotateCt_10 = 0.0;
    };
  };
  highp float tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = (_Time.y * _RotateSpeed);
  tmpvar_11 = cos((tmpvar_12 * RotateCt_10));
  highp float tmpvar_13;
  tmpvar_13 = sin((tmpvar_12 * RotateCt_10));
  highp mat2 tmpvar_14;
  tmpvar_14[0].x = tmpvar_11;
  tmpvar_14[0].y = tmpvar_13;
  tmpvar_14[1].x = -(tmpvar_13);
  tmpvar_14[1].y = tmpvar_11;
  highp vec2 tmpvar_15;
  tmpvar_15 = (((xlv_TEXCOORD1 - vec2(0.5, 0.5)) * tmpvar_14) + vec2(0.5, 0.5));
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex1_9 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_RotateTex, tmpvar_15);
  tex2_8 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (tex1_9 * _MainColor);
  col1_7 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tex2_8 * _RotateColor);
  col2_6.xyz = tmpvar_19.xyz;
  col2_6.w = (tex2_8.w * _RotateOpacity);
  tex_C_Color_4 = tex1_9;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD2);
  lmtex_3 = tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tex_C_Color_4.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_22;
  mediump vec3 srcColor_23;
  srcColor_23 = colorBlendLightMap_1;
  outColor_5.xyz = mix (srcColor_23, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_5.w = _BloomFactor;
  mediump vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = (((col1_7.xyz * 
    (1.0 - col2_6.w)
  ) + (col2_6.xyz * col2_6.w)) * outColor_5.xyz);
  gl_FragData[0] = tmpvar_24;
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
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_LightMap_ON" }
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
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" "_LightMap_ON" }
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
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "_LightMap_ON" }
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
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" "_LightMap_ON" }
""
}
}
}
}
Fallback "Diffuse"
}