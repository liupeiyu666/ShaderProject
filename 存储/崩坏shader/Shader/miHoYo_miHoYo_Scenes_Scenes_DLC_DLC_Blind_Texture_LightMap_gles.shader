//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/DLC_Blind_Texture_LightMap" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_LightMapIntensity ("Light Map Intensity", Float) = 1
_LightingColor ("Lighting Color", Color) = (0.2,0.2,0.2,1)
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Float) = 1
_MainTex ("Color Tex (RGB)|Emission(A)", 2D) = "white" { }
_MainColor ("MainColor", Color) = (0.5,0.5,0.5,0.5)
[MaterialToggle] _TextureFill ("TextureFill", Float) = 1
_Texture ("Texture", 2D) = "white" { }
_TextureAspectX ("Texture Aspect X", Float) = 1
_TextureAspectY ("Texture Aspect Y", Float) = 1
_Value ("Value", Float) = 0
[MHYSingleLineTextureNoScaleOffset] _PropertyLightmapTex ("LightMap", 2D) = "gray" { }
[MHYTextureScaleOffset] _PropertyLightmapTexTS ("PropertyLightmapTexTS", Vector) = (1,1,0,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 0
}
SubShader {
 Tags { "DrawDepth" = "FrontFace" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  Tags { "DrawDepth" = "FrontFace" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 54682
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump sampler2D unity_Lightmap;
uniform mediump vec4 unity_Lightmap_HDR;
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  mediump vec4 tmpvar_14;
  tmpvar_14 = texture2D (unity_Lightmap, xlv_TEXCOORD1);
  lmtex_3.w = tmpvar_14.w;
  lowp vec4 color_15;
  color_15 = tmpvar_14;
  lmtex_3.xyz = (unity_Lightmap_HDR.x * color_15.xyz);
  highp vec3 tmpvar_16;
  tmpvar_16 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_17;
  mediump vec3 srcColor_18;
  srcColor_18 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_18, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_19;
  tmpvar_19.xyz = outColor_6.xyz;
  tmpvar_19.w = _BloomFactor;
  gl_FragData[0] = tmpvar_19;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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
uniform mediump vec4 _MainTex_ST;
uniform highp vec4 _Texture_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _Texture_ST.xy) + _Texture_ST.zw);
  tmpvar_3 = ((_glesMultiTexCoord1.xy * _PropertyLightmapTexTS.xy) + _PropertyLightmapTexTS.zw);
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
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_COLOR1 = tmpvar_6;
  xlv_TEXCOORD02 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform sampler2D _PropertyLightmapTex;
uniform highp float _LightMapIntensity;
uniform mediump vec3 _LightingColor;
uniform mediump float _BloomFactor;
uniform sampler2D _Texture;
uniform highp float _TextureFill;
uniform highp float _TextureAspectX;
uniform highp float _TextureAspectY;
uniform highp float _Value;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD02;
void main ()
{
  highp vec3 colorBlendLightMap_1;
  mediump vec3 fcc_2;
  mediump vec4 lmtex_3;
  mediump float g_4;
  mediump vec4 tex_C_Color_5;
  mediump vec4 outColor_6;
  outColor_6 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_5 = tmpvar_7;
  if ((_TextureFill > 0.0)) {
    mediump vec2 tmpvar_8;
    tmpvar_8.x = xlv_TEXCOORD02.x;
    tmpvar_8.y = (1.0 - xlv_TEXCOORD02.y);
    lowp vec4 tmpvar_9;
    tmpvar_9 = texture2D (_Texture, tmpvar_8);
    g_4 = tmpvar_9.y;
  } else {
    mediump vec2 tmpvar_10;
    tmpvar_10.x = xlv_TEXCOORD02.x;
    tmpvar_10.y = (1.0 - xlv_TEXCOORD02.y);
    highp vec2 tmpvar_11;
    tmpvar_11.x = _TextureAspectX;
    tmpvar_11.y = _TextureAspectY;
    lowp vec4 tmpvar_12;
    highp vec2 P_13;
    P_13 = (tmpvar_10 * tmpvar_11);
    tmpvar_12 = texture2D (_Texture, P_13);
    g_4 = tmpvar_12.y;
  };
  if ((g_4 <= _Value)) {
    discard;
  };
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_PropertyLightmapTex, xlv_TEXCOORD1);
  lmtex_3 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (lmtex_3.xyz * _LightMapIntensity);
  fcc_2 = tmpvar_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = ((tex_C_Color_5.xyz * _Color.xyz) * (fcc_2 + _LightingColor));
  colorBlendLightMap_1 = tmpvar_16;
  mediump vec3 srcColor_17;
  srcColor_17 = colorBlendLightMap_1;
  outColor_6.xyz = mix (srcColor_17, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_6.w = _BloomFactor;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = outColor_6.xyz;
  tmpvar_18.w = _BloomFactor;
  gl_FragData[0] = tmpvar_18;
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