//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_DLC/Broken" {
Properties {
[MHYHelpBox(Info, Vertex Color B(outline width))] [MHYHeaderBox(OPTIONS)] [Enum(UnityEngine.Rendering.CullMode)] _CullMode ("Cull Mode", Float) = 2
[Toggle(_ALPHATEST_ON)] _EnableAlphaCutoff ("Enable Alpha Cutoff", Float) = 0
[MHYKeywordFilter(_ALPHATEST_ON On)] _AlphaCutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
_PolygonOffsetUnits ("Polygon Offset Units", Float) = 0
_OutlinePolygonOffsetFactor ("Outline Polygon Offset Factor", Float) = 0
_OutlinePolygonOffsetUnits ("Outline Polygon Offset Units", Float) = 0
[MHYHeaderBox(MAPS)] [MHYHeader(Main Maps)] [MHYSingleLineTextureNoScaleOffset(_Color)] _MainTex ("Albedo |RGB(base color) A (alpha)", 2D) = "white" { }
_Color ("Color", Color) = (1,1,1,1)
[MHYSingleLineTextureNoScaleOffset] _LightMap ("Light Map |R (sepcular intensity) G (diffuse threshold) B (specular threshold) A (material id)", 2D) = "grey" { }
[MHYSingleLineTextureNoScaleOffset] _MaskMap ("Mask Map |R (curvature) G (metal mask)", 2D) = "grey" { }
[MHYTextureScaleOffset] _MainMaps_ST ("Main Maps ST", Vector) = (1,1,0,0)
[MHYHeaderBox(LIGHTING)] [Toggle(_MULTI_BLOOM_ON)] _EnableMultipleBloom ("Enable Multiple Bloom", Float) = 0
[MHYKeywordFilter(_MULTI_BLOOM_ON Off)] _BloomIntensity ("Bloom Intensity", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity0 ("Bloom Intensity 0 (ID = 0)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity1 ("Bloom Intensity 1 (ID = 31)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity2 ("Bloom Intensity 2 (ID = 63)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity3 ("Bloom Intensity 3 (ID = 95)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity4 ("Bloom Intensity 4 (ID = 127)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity5 ("Bloom Intensity 5 (ID = 159)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity6 ("Bloom Intensity 6 (ID = 192)", Float) = 1
[MHYKeywordFilter(_MULTI_BLOOM_ON On)] _BloomIntensity7 ("Bloom Intensity 7 (ID = 223)", Float) = 1
[MHYHeaderBox(DIFFUSE)] [Toggle(_MULTI_DIFFUSE_ON)] _EnableMultipleDiffuse ("Enable Multiple Diffuse", Float) = 0
[MHYColorGradient(_MULTI_DIFFUSE_ON On)] _DiffuseRampMuitiTex ("Diffuse Multiple Ramp", 2D) = "white" { }
[MHYColorGradient(_MULTI_DIFFUSE_ON Off)] _DiffuseRampTex ("Diffuse Ramp", 2D) = "white" { }
_DiffuseRanges ("Diffuse Ranges", Vector) = (0.4,0.6,0,0)
_ShadowThreshold ("Shadow Threshold", Range(0, 1)) = 0.5
[MHYHeaderBox(SPECULAR)] [Toggle(_MULTI_SPECULAR_ON)] _EnableMultipleSpecular ("Enable Multiple Specular", Float) = 0
[MHYKeywordFilter(_MULTI_SPECULAR_ON Off)] _SpecularColor ("Specular Color", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor0 ("Specular Color (ID = 0)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor1 ("Specular Color (ID = 31)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor2 ("Specular Color (ID = 63)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor3 ("Specular Color (ID = 95)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor4 ("Specular Color (ID = 127)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor5 ("Specular Color (ID = 159)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor6 ("Specular Color (ID = 192)", Color) = (1,1,1,1)
[MHYKeywordFilter(_MULTI_SPECULAR_ON On)] _SpecularColor7 ("Specular Color (ID = 223)", Color) = (1,1,1,1)
_SpecularShininess ("Specular Shininess", Range(0.1, 500)) = 10
_SpecularIntensity ("Specular Intensity", Range(0, 50)) = 1
[MHYHeaderBox(OUTLINE)] [Toggle(_MULTI_OUTLINE_ON)] _EnableMultipleOutline ("Enable Multiple Outline", Float) = 0
[MHYKeywordFilter(_MULTI_OUTLINE_ON Off)] _OutlineColor ("Outline Color", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor0 ("Outline Color 0 (ID = 0)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor1 ("Outline Color 1 (ID = 31)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor2 ("Outline Color 2 (ID = 63)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor3 ("Outline Color 3 (ID = 95)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor4 ("Outline Color 4 (ID = 127)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor5 ("Outline Color 5 (ID = 159)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor6 ("Outline Color 6 (ID = 192)", Color) = (0,0,0,1)
[MHYKeywordFilter(_MULTI_OUTLINE_ON On)] _OutlineColor7 ("Outline Color 7 (ID = 223)", Color) = (0,0,0,1)
_OutlineWidth ("Outline Width", Range(0, 1)) = 0.1
[KeywordEnum(Normal, Tangent, UV2)] _OutlineNormalFrom ("Outline Normal From", Float) = 0
}
SubShader {
 Tags { "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "FORWARDONLY"
  Tags { "LIGHTMODE" = "FORWARDBASE" "PASSFLAGS" = "OnlyDirectional" "PerformanceChecks" = "False" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 12824
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_12;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_13;
  mediump float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_15 * (tmpvar_15 * 
    (3.0 - (2.0 * tmpvar_15))
  )));
  diff_14 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_16 < tmpvar_17.x)) {
    diff_14 = (clamp ((tmpvar_16 / 
      max (tmpvar_17.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_14 < tmpvar_17.y)) {
      diff_14 = (0.25 + (clamp (
        ((diff_14 - tmpvar_17.x) / max ((tmpvar_17.y - tmpvar_17.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_14 = (0.75 + (clamp (
        ((diff_14 - tmpvar_17.y) / max ((1.0 - tmpvar_17.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_18;
  tmpvar_18.y = 0.5;
  tmpvar_18.x = diff_14;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_DiffuseRampTex, tmpvar_18).xyz;
  diffuseLighting_13 = tmpvar_19;
  diffuseLighting_13 = (diffuseLighting_13 * tmpvar_7.xyz);
  mediump float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_22;
  tmpvar_22 = tmpvar_21;
  spec_20 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = (abs(dFdx(spec_20)) + abs(dFdy(spec_20)));
  mediump float edge0_24;
  edge0_24 = ((1.0 - lightmap_5.z) - tmpvar_23);
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((spec_20 - edge0_24) / (
    ((1.0 - lightmap_5.z) + tmpvar_23)
   - edge0_24)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_13 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_25 * (tmpvar_25 * 
      (3.0 - (2.0 * tmpvar_25))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_26;
  mediump vec3 x_27;
  x_27.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_26 = (x_27 - unity_SHC.xyz);
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_26 = tmpvar_28;
  col_1.xyz = (col_1.xyz + ((tmpvar_28 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_29;
    scrpos_29 = xlv_TEXCOORD2;
    mediump float a_30;
    a_30 = xlv_TEXCOORD2.z;
    if ((a_30 < 0.95)) {
      scrpos_29.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_30 = (a_30 * 17.0);
      highp float tmpvar_31;
      tmpvar_31 = (scrpos_29.y / 4.0);
      highp float tmpvar_32;
      tmpvar_32 = (fract(abs(tmpvar_31)) * 4.0);
      highp float tmpvar_33;
      if ((tmpvar_31 >= 0.0)) {
        tmpvar_33 = tmpvar_32;
      } else {
        tmpvar_33 = -(tmpvar_32);
      };
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_29.x / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float x_37;
      x_37 = ((a_30 - _DITHERMATRIX[
        int(tmpvar_33)
      ][
        int(tmpvar_36)
      ]) - 0.01);
      if ((x_37 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_12;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_13;
  mediump float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_15 * (tmpvar_15 * 
    (3.0 - (2.0 * tmpvar_15))
  )));
  diff_14 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_16 < tmpvar_17.x)) {
    diff_14 = (clamp ((tmpvar_16 / 
      max (tmpvar_17.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_14 < tmpvar_17.y)) {
      diff_14 = (0.25 + (clamp (
        ((diff_14 - tmpvar_17.x) / max ((tmpvar_17.y - tmpvar_17.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_14 = (0.75 + (clamp (
        ((diff_14 - tmpvar_17.y) / max ((1.0 - tmpvar_17.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_18;
  tmpvar_18.y = 0.5;
  tmpvar_18.x = diff_14;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_DiffuseRampTex, tmpvar_18).xyz;
  diffuseLighting_13 = tmpvar_19;
  diffuseLighting_13 = (diffuseLighting_13 * tmpvar_7.xyz);
  mediump float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_22;
  tmpvar_22 = tmpvar_21;
  spec_20 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = (abs(dFdx(spec_20)) + abs(dFdy(spec_20)));
  mediump float edge0_24;
  edge0_24 = ((1.0 - lightmap_5.z) - tmpvar_23);
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((spec_20 - edge0_24) / (
    ((1.0 - lightmap_5.z) + tmpvar_23)
   - edge0_24)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_13 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_25 * (tmpvar_25 * 
      (3.0 - (2.0 * tmpvar_25))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_26;
  mediump vec3 x_27;
  x_27.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_26 = (x_27 - unity_SHC.xyz);
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_26 = tmpvar_28;
  col_1.xyz = (col_1.xyz + ((tmpvar_28 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_29;
    scrpos_29 = xlv_TEXCOORD2;
    mediump float a_30;
    a_30 = xlv_TEXCOORD2.z;
    if ((a_30 < 0.95)) {
      scrpos_29.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_30 = (a_30 * 17.0);
      highp float tmpvar_31;
      tmpvar_31 = (scrpos_29.y / 4.0);
      highp float tmpvar_32;
      tmpvar_32 = (fract(abs(tmpvar_31)) * 4.0);
      highp float tmpvar_33;
      if ((tmpvar_31 >= 0.0)) {
        tmpvar_33 = tmpvar_32;
      } else {
        tmpvar_33 = -(tmpvar_32);
      };
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_29.x / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float x_37;
      x_37 = ((a_30 - _DITHERMATRIX[
        int(tmpvar_33)
      ][
        int(tmpvar_36)
      ]) - 0.01);
      if ((x_37 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_12;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_13;
  mediump float diff_14;
  mediump float tmpvar_15;
  tmpvar_15 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_16;
  tmpvar_16 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_15 * (tmpvar_15 * 
    (3.0 - (2.0 * tmpvar_15))
  )));
  diff_14 = tmpvar_16;
  mediump vec2 tmpvar_17;
  tmpvar_17 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_16 < tmpvar_17.x)) {
    diff_14 = (clamp ((tmpvar_16 / 
      max (tmpvar_17.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_14 < tmpvar_17.y)) {
      diff_14 = (0.25 + (clamp (
        ((diff_14 - tmpvar_17.x) / max ((tmpvar_17.y - tmpvar_17.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_14 = (0.75 + (clamp (
        ((diff_14 - tmpvar_17.y) / max ((1.0 - tmpvar_17.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_18;
  tmpvar_18.y = 0.5;
  tmpvar_18.x = diff_14;
  lowp vec3 tmpvar_19;
  tmpvar_19 = texture2D (_DiffuseRampTex, tmpvar_18).xyz;
  diffuseLighting_13 = tmpvar_19;
  diffuseLighting_13 = (diffuseLighting_13 * tmpvar_7.xyz);
  mediump float spec_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_22;
  tmpvar_22 = tmpvar_21;
  spec_20 = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = (abs(dFdx(spec_20)) + abs(dFdy(spec_20)));
  mediump float edge0_24;
  edge0_24 = ((1.0 - lightmap_5.z) - tmpvar_23);
  mediump float tmpvar_25;
  tmpvar_25 = clamp (((spec_20 - edge0_24) / (
    ((1.0 - lightmap_5.z) + tmpvar_23)
   - edge0_24)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_13 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_25 * (tmpvar_25 * 
      (3.0 - (2.0 * tmpvar_25))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_26;
  mediump vec3 x_27;
  x_27.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_27.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_26 = (x_27 - unity_SHC.xyz);
  mediump vec3 tmpvar_28;
  tmpvar_28 = max (((1.055 * 
    pow (max (res_26, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_26 = tmpvar_28;
  col_1.xyz = (col_1.xyz + ((tmpvar_28 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_29;
    scrpos_29 = xlv_TEXCOORD2;
    mediump float a_30;
    a_30 = xlv_TEXCOORD2.z;
    if ((a_30 < 0.95)) {
      scrpos_29.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_30 = (a_30 * 17.0);
      highp float tmpvar_31;
      tmpvar_31 = (scrpos_29.y / 4.0);
      highp float tmpvar_32;
      tmpvar_32 = (fract(abs(tmpvar_31)) * 4.0);
      highp float tmpvar_33;
      if ((tmpvar_31 >= 0.0)) {
        tmpvar_33 = tmpvar_32;
      } else {
        tmpvar_33 = -(tmpvar_32);
      };
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_29.x / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float x_37;
      x_37 = ((a_30 - _DITHERMATRIX[
        int(tmpvar_33)
      ][
        int(tmpvar_36)
      ]) - 0.01);
      if ((x_37 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((shadow_13 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (mix (0.4, 0.5, shadow_13), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_7.xyz);
  highp float shadow_23;
  shadow_23 = shadow_13;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = (shadow_23 * tmpvar_25);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_5.z) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_5.z) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_29 * (tmpvar_29 * 
      (3.0 - (2.0 * tmpvar_29))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_30;
  mediump vec3 x_31;
  x_31.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_30 = (x_31 - unity_SHC.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = max (((1.055 * 
    pow (max (res_30, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_30 = tmpvar_32;
  col_1.xyz = (col_1.xyz + ((tmpvar_32 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD2;
    mediump float a_34;
    a_34 = xlv_TEXCOORD2.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((shadow_13 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (mix (0.4, 0.5, shadow_13), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_7.xyz);
  highp float shadow_23;
  shadow_23 = shadow_13;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = (shadow_23 * tmpvar_25);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_5.z) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_5.z) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_29 * (tmpvar_29 * 
      (3.0 - (2.0 * tmpvar_29))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_30;
  mediump vec3 x_31;
  x_31.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_30 = (x_31 - unity_SHC.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = max (((1.055 * 
    pow (max (res_30, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_30 = tmpvar_32;
  col_1.xyz = (col_1.xyz + ((tmpvar_32 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD2;
    mediump float a_34;
    a_34 = xlv_TEXCOORD2.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_12;
  screenCoord_12 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_13;
  shadow_13 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_12);
    shadow_13 = tmpvar_14.x;
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (((shadow_13 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (mix (0.4, 0.5, shadow_13), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_7.xyz);
  highp float shadow_23;
  shadow_23 = shadow_13;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_11), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = (shadow_23 * tmpvar_25);
  spec_24 = tmpvar_26;
  mediump float tmpvar_27;
  tmpvar_27 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_28;
  edge0_28 = ((1.0 - lightmap_5.z) - tmpvar_27);
  mediump float tmpvar_29;
  tmpvar_29 = clamp (((spec_24 - edge0_28) / (
    ((1.0 - lightmap_5.z) + tmpvar_27)
   - edge0_28)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_29 * (tmpvar_29 * 
      (3.0 - (2.0 * tmpvar_29))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_30;
  mediump vec3 x_31;
  x_31.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_31.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_30 = (x_31 - unity_SHC.xyz);
  mediump vec3 tmpvar_32;
  tmpvar_32 = max (((1.055 * 
    pow (max (res_30, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_30 = tmpvar_32;
  col_1.xyz = (col_1.xyz + ((tmpvar_32 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_33;
    scrpos_33 = xlv_TEXCOORD2;
    mediump float a_34;
    a_34 = xlv_TEXCOORD2.z;
    if ((a_34 < 0.95)) {
      scrpos_33.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_34 = (a_34 * 17.0);
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_33.y / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_33.x / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float x_41;
      x_41 = ((a_34 - _DITHERMATRIX[
        int(tmpvar_37)
      ][
        int(tmpvar_40)
      ]) - 0.01);
      if ((x_41 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_30;
    scrpos_30 = xlv_TEXCOORD2;
    mediump float a_31;
    a_31 = xlv_TEXCOORD2.z;
    if ((a_31 < 0.95)) {
      scrpos_30.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_31 = (a_31 * 17.0);
      highp float tmpvar_32;
      tmpvar_32 = (scrpos_30.y / 4.0);
      highp float tmpvar_33;
      tmpvar_33 = (fract(abs(tmpvar_32)) * 4.0);
      highp float tmpvar_34;
      if ((tmpvar_32 >= 0.0)) {
        tmpvar_34 = tmpvar_33;
      } else {
        tmpvar_34 = -(tmpvar_33);
      };
      highp float tmpvar_35;
      tmpvar_35 = (scrpos_30.x / 4.0);
      highp float tmpvar_36;
      tmpvar_36 = (fract(abs(tmpvar_35)) * 4.0);
      highp float tmpvar_37;
      if ((tmpvar_35 >= 0.0)) {
        tmpvar_37 = tmpvar_36;
      } else {
        tmpvar_37 = -(tmpvar_36);
      };
      highp float x_38;
      x_38 = ((a_31 - _DITHERMATRIX[
        int(tmpvar_34)
      ][
        int(tmpvar_37)
      ]) - 0.01);
      if ((x_38 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD2;
    mediump float a_35;
    a_35 = xlv_TEXCOORD2.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD2;
    mediump float a_35;
    a_35 = xlv_TEXCOORD2.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_34;
    scrpos_34 = xlv_TEXCOORD2;
    mediump float a_35;
    a_35 = xlv_TEXCOORD2.z;
    if ((a_35 < 0.95)) {
      scrpos_34.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_35 = (a_35 * 17.0);
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_34.y / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_34.x / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float x_42;
      x_42 = ((a_35 - _DITHERMATRIX[
        int(tmpvar_38)
      ][
        int(tmpvar_41)
      ]) - 0.01);
      if ((x_42 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_37;
    scrpos_37 = xlv_TEXCOORD2;
    mediump float a_38;
    a_38 = xlv_TEXCOORD2.z;
    if ((a_38 < 0.95)) {
      scrpos_37.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_38 = (a_38 * 17.0);
      highp float tmpvar_39;
      tmpvar_39 = (scrpos_37.y / 4.0);
      highp float tmpvar_40;
      tmpvar_40 = (fract(abs(tmpvar_39)) * 4.0);
      highp float tmpvar_41;
      if ((tmpvar_39 >= 0.0)) {
        tmpvar_41 = tmpvar_40;
      } else {
        tmpvar_41 = -(tmpvar_40);
      };
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_37.x / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float x_45;
      x_45 = ((a_38 - _DITHERMATRIX[
        int(tmpvar_41)
      ][
        int(tmpvar_44)
      ]) - 0.01);
      if ((x_45 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_41;
    scrpos_41 = xlv_TEXCOORD2;
    mediump float a_42;
    a_42 = xlv_TEXCOORD2.z;
    if ((a_42 < 0.95)) {
      scrpos_41.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_42 = (a_42 * 17.0);
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_41.y / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_41.x / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float x_49;
      x_49 = ((a_42 - _DITHERMATRIX[
        int(tmpvar_45)
      ][
        int(tmpvar_48)
      ]) - 0.01);
      if ((x_49 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.y = 0.5;
  tmpvar_19.x = diff_15;
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.y = 0.5;
  tmpvar_22.x = diff_18;
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump float spec_21;
  mediump float tmpvar_22;
  tmpvar_22 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_23;
  tmpvar_23 = tmpvar_22;
  spec_21 = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = (abs(dFdx(spec_21)) + abs(dFdy(spec_21)));
  mediump float edge0_25;
  edge0_25 = ((1.0 - lightmap_5.z) - tmpvar_24);
  mediump float tmpvar_26;
  tmpvar_26 = clamp (((spec_21 - edge0_25) / (
    ((1.0 - lightmap_5.z) + tmpvar_24)
   - edge0_25)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_26 * (tmpvar_26 * 
      (3.0 - (2.0 * tmpvar_26))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_27;
  mediump vec3 x_28;
  x_28.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_28.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_27 = (x_28 - unity_SHC.xyz);
  mediump vec3 tmpvar_29;
  tmpvar_29 = max (((1.055 * 
    pow (max (res_27, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_27 = tmpvar_29;
  col_1.xyz = (col_1.xyz + ((tmpvar_29 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_30;
  bool tmpvar_31;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    tmpvar_30 = _BloomIntensity0;
  } else {
    bool tmpvar_32;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      tmpvar_30 = _BloomIntensity1;
    } else {
      bool tmpvar_33;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        tmpvar_30 = _BloomIntensity2;
      } else {
        bool tmpvar_34;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          tmpvar_30 = _BloomIntensity3;
        } else {
          bool tmpvar_35;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            tmpvar_30 = _BloomIntensity4;
          } else {
            bool tmpvar_36;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              tmpvar_30 = _BloomIntensity5;
            } else {
              bool tmpvar_37;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_37 = bool(1);
              } else {
                tmpvar_37 = bool(0);
              };
              if (tmpvar_37) {
                tmpvar_30 = _BloomIntensity6;
              } else {
                tmpvar_30 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_30;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_38;
    scrpos_38 = xlv_TEXCOORD2;
    mediump float a_39;
    a_39 = xlv_TEXCOORD2.z;
    if ((a_39 < 0.95)) {
      scrpos_38.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_39 = (a_39 * 17.0);
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_38.y / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float tmpvar_43;
      tmpvar_43 = (scrpos_38.x / 4.0);
      highp float tmpvar_44;
      tmpvar_44 = (fract(abs(tmpvar_43)) * 4.0);
      highp float tmpvar_45;
      if ((tmpvar_43 >= 0.0)) {
        tmpvar_45 = tmpvar_44;
      } else {
        tmpvar_45 = -(tmpvar_44);
      };
      highp float x_46;
      x_46 = ((a_39 - _DITHERMATRIX[
        int(tmpvar_42)
      ][
        int(tmpvar_45)
      ]) - 0.01);
      if ((x_46 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump float spec_25;
  mediump float tmpvar_26;
  tmpvar_26 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_27;
  tmpvar_27 = (shadow_24 * tmpvar_26);
  spec_25 = tmpvar_27;
  mediump float tmpvar_28;
  tmpvar_28 = (abs(dFdx(spec_25)) + abs(dFdy(spec_25)));
  mediump float edge0_29;
  edge0_29 = ((1.0 - lightmap_5.z) - tmpvar_28);
  mediump float tmpvar_30;
  tmpvar_30 = clamp (((spec_25 - edge0_29) / (
    ((1.0 - lightmap_5.z) + tmpvar_28)
   - edge0_29)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_30 * (tmpvar_30 * 
      (3.0 - (2.0 * tmpvar_30))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_31;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_32.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_31 = (x_32 - unity_SHC.xyz);
  mediump vec3 tmpvar_33;
  tmpvar_33 = max (((1.055 * 
    pow (max (res_31, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_31 = tmpvar_33;
  col_1.xyz = (col_1.xyz + ((tmpvar_33 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_34;
  bool tmpvar_35;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_35 = bool(1);
  } else {
    tmpvar_35 = bool(0);
  };
  if (tmpvar_35) {
    tmpvar_34 = _BloomIntensity0;
  } else {
    bool tmpvar_36;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_36 = bool(1);
    } else {
      tmpvar_36 = bool(0);
    };
    if (tmpvar_36) {
      tmpvar_34 = _BloomIntensity1;
    } else {
      bool tmpvar_37;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_37 = bool(1);
      } else {
        tmpvar_37 = bool(0);
      };
      if (tmpvar_37) {
        tmpvar_34 = _BloomIntensity2;
      } else {
        bool tmpvar_38;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_38 = bool(1);
        } else {
          tmpvar_38 = bool(0);
        };
        if (tmpvar_38) {
          tmpvar_34 = _BloomIntensity3;
        } else {
          bool tmpvar_39;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_39 = bool(1);
          } else {
            tmpvar_39 = bool(0);
          };
          if (tmpvar_39) {
            tmpvar_34 = _BloomIntensity4;
          } else {
            bool tmpvar_40;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_40 = bool(1);
            } else {
              tmpvar_40 = bool(0);
            };
            if (tmpvar_40) {
              tmpvar_34 = _BloomIntensity5;
            } else {
              bool tmpvar_41;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_41 = bool(1);
              } else {
                tmpvar_41 = bool(0);
              };
              if (tmpvar_41) {
                tmpvar_34 = _BloomIntensity6;
              } else {
                tmpvar_34 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_34;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_42;
    scrpos_42 = xlv_TEXCOORD2;
    mediump float a_43;
    a_43 = xlv_TEXCOORD2.z;
    if ((a_43 < 0.95)) {
      scrpos_42.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_43 = (a_43 * 17.0);
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_42.y / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_42.x / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float x_50;
      x_50 = ((a_43 - _DITHERMATRIX[
        int(tmpvar_46)
      ][
        int(tmpvar_49)
      ]) - 0.01);
      if ((x_50 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_13;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_14;
  mediump float diff_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_17;
  tmpvar_17 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_16 * (tmpvar_16 * 
    (3.0 - (2.0 * tmpvar_16))
  )));
  diff_15 = tmpvar_17;
  mediump vec2 tmpvar_18;
  tmpvar_18 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_17 < tmpvar_18.x)) {
    diff_15 = (clamp ((tmpvar_17 / 
      max (tmpvar_18.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_15 < tmpvar_18.y)) {
      diff_15 = (0.25 + (clamp (
        ((diff_15 - tmpvar_18.x) / max ((tmpvar_18.y - tmpvar_18.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_15 = (0.75 + (clamp (
        ((diff_15 - tmpvar_18.y) / max ((1.0 - tmpvar_18.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_19;
  tmpvar_19.x = diff_15;
  tmpvar_19.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_20;
  tmpvar_20 = texture2D (_DiffuseRampMuitiTex, tmpvar_19).xyz;
  diffuseLighting_14 = tmpvar_20;
  diffuseLighting_14 = (diffuseLighting_14 * tmpvar_7.xyz);
  mediump vec4 specularColor_21;
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  specularColor_21 = _SpecularColor0;
  bool tmpvar_25;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_25 = bool(1);
  } else {
    tmpvar_25 = bool(0);
  };
  if (tmpvar_25) {
    specularColor_21 = _SpecularColor1;
  } else {
    bool tmpvar_26;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_26 = bool(1);
    } else {
      tmpvar_26 = bool(0);
    };
    if (tmpvar_26) {
      specularColor_21 = _SpecularColor2;
    } else {
      bool tmpvar_27;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_27 = bool(1);
      } else {
        tmpvar_27 = bool(0);
      };
      if (tmpvar_27) {
        specularColor_21 = _SpecularColor3;
      } else {
        bool tmpvar_28;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_28 = bool(1);
        } else {
          tmpvar_28 = bool(0);
        };
        if (tmpvar_28) {
          specularColor_21 = _SpecularColor4;
        } else {
          bool tmpvar_29;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_29 = bool(1);
          } else {
            tmpvar_29 = bool(0);
          };
          if (tmpvar_29) {
            specularColor_21 = _SpecularColor5;
          } else {
            bool tmpvar_30;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_30 = bool(1);
            } else {
              tmpvar_30 = bool(0);
            };
            if (tmpvar_30) {
              specularColor_21 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_31;
  tmpvar_31 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_32;
  edge0_32 = ((1.0 - lightmap_5.z) - tmpvar_31);
  mediump float tmpvar_33;
  tmpvar_33 = clamp (((spec_22 - edge0_32) / (
    ((1.0 - lightmap_5.z) + tmpvar_31)
   - edge0_32)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_14 + ((
    ((specularColor_21.xyz * vec3((tmpvar_33 * (tmpvar_33 * 
      (3.0 - (2.0 * tmpvar_33))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_34;
  mediump vec3 x_35;
  x_35.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_35.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_34 = (x_35 - unity_SHC.xyz);
  mediump vec3 tmpvar_36;
  tmpvar_36 = max (((1.055 * 
    pow (max (res_34, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_34 = tmpvar_36;
  col_1.xyz = (col_1.xyz + ((tmpvar_36 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_37;
  bool tmpvar_38;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_38 = bool(1);
  } else {
    tmpvar_38 = bool(0);
  };
  if (tmpvar_38) {
    tmpvar_37 = _BloomIntensity0;
  } else {
    bool tmpvar_39;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_39 = bool(1);
    } else {
      tmpvar_39 = bool(0);
    };
    if (tmpvar_39) {
      tmpvar_37 = _BloomIntensity1;
    } else {
      bool tmpvar_40;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_40 = bool(1);
      } else {
        tmpvar_40 = bool(0);
      };
      if (tmpvar_40) {
        tmpvar_37 = _BloomIntensity2;
      } else {
        bool tmpvar_41;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_41 = bool(1);
        } else {
          tmpvar_41 = bool(0);
        };
        if (tmpvar_41) {
          tmpvar_37 = _BloomIntensity3;
        } else {
          bool tmpvar_42;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_42 = bool(1);
          } else {
            tmpvar_42 = bool(0);
          };
          if (tmpvar_42) {
            tmpvar_37 = _BloomIntensity4;
          } else {
            bool tmpvar_43;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_43 = bool(1);
            } else {
              tmpvar_43 = bool(0);
            };
            if (tmpvar_43) {
              tmpvar_37 = _BloomIntensity5;
            } else {
              bool tmpvar_44;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_44 = bool(1);
              } else {
                tmpvar_44 = bool(0);
              };
              if (tmpvar_44) {
                tmpvar_37 = _BloomIntensity6;
              } else {
                tmpvar_37 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_37;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_45;
    scrpos_45 = xlv_TEXCOORD2;
    mediump float a_46;
    a_46 = xlv_TEXCOORD2.z;
    if ((a_46 < 0.95)) {
      scrpos_45.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_46 = (a_46 * 17.0);
      highp float tmpvar_47;
      tmpvar_47 = (scrpos_45.y / 4.0);
      highp float tmpvar_48;
      tmpvar_48 = (fract(abs(tmpvar_47)) * 4.0);
      highp float tmpvar_49;
      if ((tmpvar_47 >= 0.0)) {
        tmpvar_49 = tmpvar_48;
      } else {
        tmpvar_49 = -(tmpvar_48);
      };
      highp float tmpvar_50;
      tmpvar_50 = (scrpos_45.x / 4.0);
      highp float tmpvar_51;
      tmpvar_51 = (fract(abs(tmpvar_50)) * 4.0);
      highp float tmpvar_52;
      if ((tmpvar_50 >= 0.0)) {
        tmpvar_52 = tmpvar_51;
      } else {
        tmpvar_52 = -(tmpvar_51);
      };
      highp float x_53;
      x_53 = ((a_46 - _DITHERMATRIX[
        int(tmpvar_49)
      ][
        int(tmpvar_52)
      ]) - 0.01);
      if ((x_53 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_7;
  tmpvar_7 = ((tmpvar_6 * _Color) * _EnvColor);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_13;
  screenCoord_13 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_14;
  shadow_14 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_15;
    tmpvar_15 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_13);
    shadow_14 = tmpvar_15.x;
  };
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_16;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_17;
  mediump float diff_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((shadow_14 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_20;
  tmpvar_20 = mix (mix (0.4, 0.5, shadow_14), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_19 * (tmpvar_19 * 
    (3.0 - (2.0 * tmpvar_19))
  )));
  diff_18 = tmpvar_20;
  mediump vec2 tmpvar_21;
  tmpvar_21 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_20 < tmpvar_21.x)) {
    diff_18 = (clamp ((tmpvar_20 / 
      max (tmpvar_21.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_18 < tmpvar_21.y)) {
      diff_18 = (0.25 + (clamp (
        ((diff_18 - tmpvar_21.x) / max ((tmpvar_21.y - tmpvar_21.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_18 = (0.75 + (clamp (
        ((diff_18 - tmpvar_21.y) / max ((1.0 - tmpvar_21.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_22;
  tmpvar_22.x = diff_18;
  tmpvar_22.y = (((tmpvar_10 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_23;
  tmpvar_23 = texture2D (_DiffuseRampMuitiTex, tmpvar_22).xyz;
  diffuseLighting_17 = tmpvar_23;
  diffuseLighting_17 = (diffuseLighting_17 * tmpvar_7.xyz);
  highp float shadow_24;
  shadow_24 = shadow_14;
  mediump vec4 specularColor_25;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_12), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_24 * tmpvar_27);
  spec_26 = tmpvar_28;
  specularColor_25 = _SpecularColor0;
  bool tmpvar_29;
  if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
    tmpvar_29 = bool(1);
  } else {
    tmpvar_29 = bool(0);
  };
  if (tmpvar_29) {
    specularColor_25 = _SpecularColor1;
  } else {
    bool tmpvar_30;
    if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
      tmpvar_30 = bool(1);
    } else {
      tmpvar_30 = bool(0);
    };
    if (tmpvar_30) {
      specularColor_25 = _SpecularColor2;
    } else {
      bool tmpvar_31;
      if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
        tmpvar_31 = bool(1);
      } else {
        tmpvar_31 = bool(0);
      };
      if (tmpvar_31) {
        specularColor_25 = _SpecularColor3;
      } else {
        bool tmpvar_32;
        if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
          tmpvar_32 = bool(1);
        } else {
          tmpvar_32 = bool(0);
        };
        if (tmpvar_32) {
          specularColor_25 = _SpecularColor4;
        } else {
          bool tmpvar_33;
          if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
            tmpvar_33 = bool(1);
          } else {
            tmpvar_33 = bool(0);
          };
          if (tmpvar_33) {
            specularColor_25 = _SpecularColor5;
          } else {
            bool tmpvar_34;
            if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
              tmpvar_34 = bool(1);
            } else {
              tmpvar_34 = bool(0);
            };
            if (tmpvar_34) {
              specularColor_25 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_35;
  tmpvar_35 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_36;
  edge0_36 = ((1.0 - lightmap_5.z) - tmpvar_35);
  mediump float tmpvar_37;
  tmpvar_37 = clamp (((spec_26 - edge0_36) / (
    ((1.0 - lightmap_5.z) + tmpvar_35)
   - edge0_36)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_17 + ((
    ((specularColor_25.xyz * vec3((tmpvar_37 * (tmpvar_37 * 
      (3.0 - (2.0 * tmpvar_37))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_7.xyz));
  mediump vec3 res_38;
  mediump vec3 x_39;
  x_39.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_39.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_38 = (x_39 - unity_SHC.xyz);
  mediump vec3 tmpvar_40;
  tmpvar_40 = max (((1.055 * 
    pow (max (res_38, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_38 = tmpvar_40;
  col_1.xyz = (col_1.xyz + ((tmpvar_40 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_7.xyz)));
  mediump float tmpvar_41;
  bool tmpvar_42;
  if (((-0.5 < tmpvar_10) && (tmpvar_10 < 0.5))) {
    tmpvar_42 = bool(1);
  } else {
    tmpvar_42 = bool(0);
  };
  if (tmpvar_42) {
    tmpvar_41 = _BloomIntensity0;
  } else {
    bool tmpvar_43;
    if (((0.5 < tmpvar_10) && (tmpvar_10 < 1.5))) {
      tmpvar_43 = bool(1);
    } else {
      tmpvar_43 = bool(0);
    };
    if (tmpvar_43) {
      tmpvar_41 = _BloomIntensity1;
    } else {
      bool tmpvar_44;
      if (((1.5 < tmpvar_10) && (tmpvar_10 < 2.5))) {
        tmpvar_44 = bool(1);
      } else {
        tmpvar_44 = bool(0);
      };
      if (tmpvar_44) {
        tmpvar_41 = _BloomIntensity2;
      } else {
        bool tmpvar_45;
        if (((2.5 < tmpvar_10) && (tmpvar_10 < 3.5))) {
          tmpvar_45 = bool(1);
        } else {
          tmpvar_45 = bool(0);
        };
        if (tmpvar_45) {
          tmpvar_41 = _BloomIntensity3;
        } else {
          bool tmpvar_46;
          if (((3.5 < tmpvar_10) && (tmpvar_10 < 4.5))) {
            tmpvar_46 = bool(1);
          } else {
            tmpvar_46 = bool(0);
          };
          if (tmpvar_46) {
            tmpvar_41 = _BloomIntensity4;
          } else {
            bool tmpvar_47;
            if (((4.5 < tmpvar_10) && (tmpvar_10 < 5.5))) {
              tmpvar_47 = bool(1);
            } else {
              tmpvar_47 = bool(0);
            };
            if (tmpvar_47) {
              tmpvar_41 = _BloomIntensity5;
            } else {
              bool tmpvar_48;
              if (((5.5 < tmpvar_10) && (tmpvar_10 < 6.5))) {
                tmpvar_48 = bool(1);
              } else {
                tmpvar_48 = bool(0);
              };
              if (tmpvar_48) {
                tmpvar_41 = _BloomIntensity6;
              } else {
                tmpvar_41 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_41;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_49;
    scrpos_49 = xlv_TEXCOORD2;
    mediump float a_50;
    a_50 = xlv_TEXCOORD2.z;
    if ((a_50 < 0.95)) {
      scrpos_49.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_50 = (a_50 * 17.0);
      highp float tmpvar_51;
      tmpvar_51 = (scrpos_49.y / 4.0);
      highp float tmpvar_52;
      tmpvar_52 = (fract(abs(tmpvar_51)) * 4.0);
      highp float tmpvar_53;
      if ((tmpvar_51 >= 0.0)) {
        tmpvar_53 = tmpvar_52;
      } else {
        tmpvar_53 = -(tmpvar_52);
      };
      highp float tmpvar_54;
      tmpvar_54 = (scrpos_49.x / 4.0);
      highp float tmpvar_55;
      tmpvar_55 = (fract(abs(tmpvar_54)) * 4.0);
      highp float tmpvar_56;
      if ((tmpvar_54 >= 0.0)) {
        tmpvar_56 = tmpvar_55;
      } else {
        tmpvar_56 = -(tmpvar_55);
      };
      highp float x_57;
      x_57 = ((a_50 - _DITHERMATRIX[
        int(tmpvar_53)
      ][
        int(tmpvar_56)
      ]) - 0.01);
      if ((x_57 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_14;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_15;
  mediump float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_17 * (tmpvar_17 * 
    (3.0 - (2.0 * tmpvar_17))
  )));
  diff_16 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_18 < tmpvar_19.x)) {
    diff_16 = (clamp ((tmpvar_18 / 
      max (tmpvar_19.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_16 < tmpvar_19.y)) {
      diff_16 = (0.25 + (clamp (
        ((diff_16 - tmpvar_19.x) / max ((tmpvar_19.y - tmpvar_19.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_16 = (0.75 + (clamp (
        ((diff_16 - tmpvar_19.y) / max ((1.0 - tmpvar_19.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 0.5;
  tmpvar_20.x = diff_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_DiffuseRampTex, tmpvar_20).xyz;
  diffuseLighting_15 = tmpvar_21;
  diffuseLighting_15 = (diffuseLighting_15 * tmpvar_8.xyz);
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_26;
  edge0_26 = ((1.0 - lightmap_5.z) - tmpvar_25);
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((spec_22 - edge0_26) / (
    ((1.0 - lightmap_5.z) + tmpvar_25)
   - edge0_26)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_15 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_27 * (tmpvar_27 * 
      (3.0 - (2.0 * tmpvar_27))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_28 = (x_29 - unity_SHC.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_28 = tmpvar_30;
  col_1.xyz = (col_1.xyz + ((tmpvar_30 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD2;
    mediump float a_32;
    a_32 = xlv_TEXCOORD2.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_14;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_15;
  mediump float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_17 * (tmpvar_17 * 
    (3.0 - (2.0 * tmpvar_17))
  )));
  diff_16 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_18 < tmpvar_19.x)) {
    diff_16 = (clamp ((tmpvar_18 / 
      max (tmpvar_19.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_16 < tmpvar_19.y)) {
      diff_16 = (0.25 + (clamp (
        ((diff_16 - tmpvar_19.x) / max ((tmpvar_19.y - tmpvar_19.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_16 = (0.75 + (clamp (
        ((diff_16 - tmpvar_19.y) / max ((1.0 - tmpvar_19.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 0.5;
  tmpvar_20.x = diff_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_DiffuseRampTex, tmpvar_20).xyz;
  diffuseLighting_15 = tmpvar_21;
  diffuseLighting_15 = (diffuseLighting_15 * tmpvar_8.xyz);
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_26;
  edge0_26 = ((1.0 - lightmap_5.z) - tmpvar_25);
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((spec_22 - edge0_26) / (
    ((1.0 - lightmap_5.z) + tmpvar_25)
   - edge0_26)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_15 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_27 * (tmpvar_27 * 
      (3.0 - (2.0 * tmpvar_27))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_28 = (x_29 - unity_SHC.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_28 = tmpvar_30;
  col_1.xyz = (col_1.xyz + ((tmpvar_30 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD2;
    mediump float a_32;
    a_32 = xlv_TEXCOORD2.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_14;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_15;
  mediump float diff_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_18;
  tmpvar_18 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_17 * (tmpvar_17 * 
    (3.0 - (2.0 * tmpvar_17))
  )));
  diff_16 = tmpvar_18;
  mediump vec2 tmpvar_19;
  tmpvar_19 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_18 < tmpvar_19.x)) {
    diff_16 = (clamp ((tmpvar_18 / 
      max (tmpvar_19.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_16 < tmpvar_19.y)) {
      diff_16 = (0.25 + (clamp (
        ((diff_16 - tmpvar_19.x) / max ((tmpvar_19.y - tmpvar_19.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_16 = (0.75 + (clamp (
        ((diff_16 - tmpvar_19.y) / max ((1.0 - tmpvar_19.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 0.5;
  tmpvar_20.x = diff_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_DiffuseRampTex, tmpvar_20).xyz;
  diffuseLighting_15 = tmpvar_21;
  diffuseLighting_15 = (diffuseLighting_15 * tmpvar_8.xyz);
  mediump float spec_22;
  mediump float tmpvar_23;
  tmpvar_23 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_24;
  tmpvar_24 = tmpvar_23;
  spec_22 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = (abs(dFdx(spec_22)) + abs(dFdy(spec_22)));
  mediump float edge0_26;
  edge0_26 = ((1.0 - lightmap_5.z) - tmpvar_25);
  mediump float tmpvar_27;
  tmpvar_27 = clamp (((spec_22 - edge0_26) / (
    ((1.0 - lightmap_5.z) + tmpvar_25)
   - edge0_26)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_15 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_27 * (tmpvar_27 * 
      (3.0 - (2.0 * tmpvar_27))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_28;
  mediump vec3 x_29;
  x_29.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_29.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_28 = (x_29 - unity_SHC.xyz);
  mediump vec3 tmpvar_30;
  tmpvar_30 = max (((1.055 * 
    pow (max (res_28, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_28 = tmpvar_30;
  col_1.xyz = (col_1.xyz + ((tmpvar_30 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_31;
    scrpos_31 = xlv_TEXCOORD2;
    mediump float a_32;
    a_32 = xlv_TEXCOORD2.z;
    if ((a_32 < 0.95)) {
      scrpos_31.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_32 = (a_32 * 17.0);
      highp float tmpvar_33;
      tmpvar_33 = (scrpos_31.y / 4.0);
      highp float tmpvar_34;
      tmpvar_34 = (fract(abs(tmpvar_33)) * 4.0);
      highp float tmpvar_35;
      if ((tmpvar_33 >= 0.0)) {
        tmpvar_35 = tmpvar_34;
      } else {
        tmpvar_35 = -(tmpvar_34);
      };
      highp float tmpvar_36;
      tmpvar_36 = (scrpos_31.x / 4.0);
      highp float tmpvar_37;
      tmpvar_37 = (fract(abs(tmpvar_36)) * 4.0);
      highp float tmpvar_38;
      if ((tmpvar_36 >= 0.0)) {
        tmpvar_38 = tmpvar_37;
      } else {
        tmpvar_38 = -(tmpvar_37);
      };
      highp float x_39;
      x_39 = ((a_32 - _DITHERMATRIX[
        int(tmpvar_35)
      ][
        int(tmpvar_38)
      ]) - 0.01);
      if ((x_39 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_17;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_18;
  mediump float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((shadow_15 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = mix (mix (0.4, 0.5, shadow_15), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  diff_19 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_21 < tmpvar_22.x)) {
    diff_19 = (clamp ((tmpvar_21 / 
      max (tmpvar_22.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_19 < tmpvar_22.y)) {
      diff_19 = (0.25 + (clamp (
        ((diff_19 - tmpvar_22.x) / max ((tmpvar_22.y - tmpvar_22.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_19 = (0.75 + (clamp (
        ((diff_19 - tmpvar_22.y) / max ((1.0 - tmpvar_22.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_23;
  tmpvar_23.y = 0.5;
  tmpvar_23.x = diff_19;
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_DiffuseRampTex, tmpvar_23).xyz;
  diffuseLighting_18 = tmpvar_24;
  diffuseLighting_18 = (diffuseLighting_18 * tmpvar_8.xyz);
  highp float shadow_25;
  shadow_25 = shadow_15;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_25 * tmpvar_27);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_5.z) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_5.z) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_18 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_31 * (tmpvar_31 * 
      (3.0 - (2.0 * tmpvar_31))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_32;
  mediump vec3 x_33;
  x_33.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_32 = (x_33 - unity_SHC.xyz);
  mediump vec3 tmpvar_34;
  tmpvar_34 = max (((1.055 * 
    pow (max (res_32, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_32 = tmpvar_34;
  col_1.xyz = (col_1.xyz + ((tmpvar_34 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_35;
    scrpos_35 = xlv_TEXCOORD2;
    mediump float a_36;
    a_36 = xlv_TEXCOORD2.z;
    if ((a_36 < 0.95)) {
      scrpos_35.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_36 = (a_36 * 17.0);
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_35.y / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_35.x / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float x_43;
      x_43 = ((a_36 - _DITHERMATRIX[
        int(tmpvar_39)
      ][
        int(tmpvar_42)
      ]) - 0.01);
      if ((x_43 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_17;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_18;
  mediump float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((shadow_15 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = mix (mix (0.4, 0.5, shadow_15), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  diff_19 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_21 < tmpvar_22.x)) {
    diff_19 = (clamp ((tmpvar_21 / 
      max (tmpvar_22.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_19 < tmpvar_22.y)) {
      diff_19 = (0.25 + (clamp (
        ((diff_19 - tmpvar_22.x) / max ((tmpvar_22.y - tmpvar_22.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_19 = (0.75 + (clamp (
        ((diff_19 - tmpvar_22.y) / max ((1.0 - tmpvar_22.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_23;
  tmpvar_23.y = 0.5;
  tmpvar_23.x = diff_19;
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_DiffuseRampTex, tmpvar_23).xyz;
  diffuseLighting_18 = tmpvar_24;
  diffuseLighting_18 = (diffuseLighting_18 * tmpvar_8.xyz);
  highp float shadow_25;
  shadow_25 = shadow_15;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_25 * tmpvar_27);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_5.z) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_5.z) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_18 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_31 * (tmpvar_31 * 
      (3.0 - (2.0 * tmpvar_31))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_32;
  mediump vec3 x_33;
  x_33.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_32 = (x_33 - unity_SHC.xyz);
  mediump vec3 tmpvar_34;
  tmpvar_34 = max (((1.055 * 
    pow (max (res_32, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_32 = tmpvar_34;
  col_1.xyz = (col_1.xyz + ((tmpvar_34 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_35;
    scrpos_35 = xlv_TEXCOORD2;
    mediump float a_36;
    a_36 = xlv_TEXCOORD2.z;
    if ((a_36 < 0.95)) {
      scrpos_35.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_36 = (a_36 * 17.0);
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_35.y / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_35.x / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float x_43;
      x_43 = ((a_36 - _DITHERMATRIX[
        int(tmpvar_39)
      ][
        int(tmpvar_42)
      ]) - 0.01);
      if ((x_43 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_14;
  screenCoord_14 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_15;
  shadow_15 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_16;
    tmpvar_16 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_14);
    shadow_15 = tmpvar_16.x;
  };
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_17;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_18;
  mediump float diff_19;
  mediump float tmpvar_20;
  tmpvar_20 = clamp (((shadow_15 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_21;
  tmpvar_21 = mix (mix (0.4, 0.5, shadow_15), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_20 * (tmpvar_20 * 
    (3.0 - (2.0 * tmpvar_20))
  )));
  diff_19 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_21 < tmpvar_22.x)) {
    diff_19 = (clamp ((tmpvar_21 / 
      max (tmpvar_22.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_19 < tmpvar_22.y)) {
      diff_19 = (0.25 + (clamp (
        ((diff_19 - tmpvar_22.x) / max ((tmpvar_22.y - tmpvar_22.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_19 = (0.75 + (clamp (
        ((diff_19 - tmpvar_22.y) / max ((1.0 - tmpvar_22.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_23;
  tmpvar_23.y = 0.5;
  tmpvar_23.x = diff_19;
  lowp vec3 tmpvar_24;
  tmpvar_24 = texture2D (_DiffuseRampTex, tmpvar_23).xyz;
  diffuseLighting_18 = tmpvar_24;
  diffuseLighting_18 = (diffuseLighting_18 * tmpvar_8.xyz);
  highp float shadow_25;
  shadow_25 = shadow_15;
  mediump float spec_26;
  mediump float tmpvar_27;
  tmpvar_27 = pow (max (dot (normalDir_2, tmpvar_13), 0.0), _SpecularShininess);
  highp float tmpvar_28;
  tmpvar_28 = (shadow_25 * tmpvar_27);
  spec_26 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = (abs(dFdx(spec_26)) + abs(dFdy(spec_26)));
  mediump float edge0_30;
  edge0_30 = ((1.0 - lightmap_5.z) - tmpvar_29);
  mediump float tmpvar_31;
  tmpvar_31 = clamp (((spec_26 - edge0_30) / (
    ((1.0 - lightmap_5.z) + tmpvar_29)
   - edge0_30)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_18 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_31 * (tmpvar_31 * 
      (3.0 - (2.0 * tmpvar_31))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_32;
  mediump vec3 x_33;
  x_33.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_33.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_32 = (x_33 - unity_SHC.xyz);
  mediump vec3 tmpvar_34;
  tmpvar_34 = max (((1.055 * 
    pow (max (res_32, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_32 = tmpvar_34;
  col_1.xyz = (col_1.xyz + ((tmpvar_34 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_35;
    scrpos_35 = xlv_TEXCOORD2;
    mediump float a_36;
    a_36 = xlv_TEXCOORD2.z;
    if ((a_36 < 0.95)) {
      scrpos_35.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_36 = (a_36 * 17.0);
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_35.y / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float tmpvar_40;
      tmpvar_40 = (scrpos_35.x / 4.0);
      highp float tmpvar_41;
      tmpvar_41 = (fract(abs(tmpvar_40)) * 4.0);
      highp float tmpvar_42;
      if ((tmpvar_40 >= 0.0)) {
        tmpvar_42 = tmpvar_41;
      } else {
        tmpvar_42 = -(tmpvar_41);
      };
      highp float x_43;
      x_43 = ((a_36 - _DITHERMATRIX[
        int(tmpvar_39)
      ][
        int(tmpvar_42)
      ]) - 0.01);
      if ((x_43 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_32;
    scrpos_32 = xlv_TEXCOORD2;
    mediump float a_33;
    a_33 = xlv_TEXCOORD2.z;
    if ((a_33 < 0.95)) {
      scrpos_32.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_33 = (a_33 * 17.0);
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_32.y / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_32.x / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float x_40;
      x_40 = ((a_33 - _DITHERMATRIX[
        int(tmpvar_36)
      ][
        int(tmpvar_39)
      ]) - 0.01);
      if ((x_40 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_32;
    scrpos_32 = xlv_TEXCOORD2;
    mediump float a_33;
    a_33 = xlv_TEXCOORD2.z;
    if ((a_33 < 0.95)) {
      scrpos_32.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_33 = (a_33 * 17.0);
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_32.y / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_32.x / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float x_40;
      x_40 = ((a_33 - _DITHERMATRIX[
        int(tmpvar_36)
      ][
        int(tmpvar_39)
      ]) - 0.01);
      if ((x_40 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_32;
    scrpos_32 = xlv_TEXCOORD2;
    mediump float a_33;
    a_33 = xlv_TEXCOORD2.z;
    if ((a_33 < 0.95)) {
      scrpos_32.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_33 = (a_33 * 17.0);
      highp float tmpvar_34;
      tmpvar_34 = (scrpos_32.y / 4.0);
      highp float tmpvar_35;
      tmpvar_35 = (fract(abs(tmpvar_34)) * 4.0);
      highp float tmpvar_36;
      if ((tmpvar_34 >= 0.0)) {
        tmpvar_36 = tmpvar_35;
      } else {
        tmpvar_36 = -(tmpvar_35);
      };
      highp float tmpvar_37;
      tmpvar_37 = (scrpos_32.x / 4.0);
      highp float tmpvar_38;
      tmpvar_38 = (fract(abs(tmpvar_37)) * 4.0);
      highp float tmpvar_39;
      if ((tmpvar_37 >= 0.0)) {
        tmpvar_39 = tmpvar_38;
      } else {
        tmpvar_39 = -(tmpvar_38);
      };
      highp float x_40;
      x_40 = ((a_33 - _DITHERMATRIX[
        int(tmpvar_36)
      ][
        int(tmpvar_39)
      ]) - 0.01);
      if ((x_40 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_36;
    scrpos_36 = xlv_TEXCOORD2;
    mediump float a_37;
    a_37 = xlv_TEXCOORD2.z;
    if ((a_37 < 0.95)) {
      scrpos_36.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_37 = (a_37 * 17.0);
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_36.y / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_36.x / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float x_44;
      x_44 = ((a_37 - _DITHERMATRIX[
        int(tmpvar_40)
      ][
        int(tmpvar_43)
      ]) - 0.01);
      if ((x_44 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_36;
    scrpos_36 = xlv_TEXCOORD2;
    mediump float a_37;
    a_37 = xlv_TEXCOORD2.z;
    if ((a_37 < 0.95)) {
      scrpos_36.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_37 = (a_37 * 17.0);
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_36.y / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_36.x / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float x_44;
      x_44 = ((a_37 - _DITHERMATRIX[
        int(tmpvar_40)
      ][
        int(tmpvar_43)
      ]) - 0.01);
      if ((x_44 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_36;
    scrpos_36 = xlv_TEXCOORD2;
    mediump float a_37;
    a_37 = xlv_TEXCOORD2.z;
    if ((a_37 < 0.95)) {
      scrpos_36.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_37 = (a_37 * 17.0);
      highp float tmpvar_38;
      tmpvar_38 = (scrpos_36.y / 4.0);
      highp float tmpvar_39;
      tmpvar_39 = (fract(abs(tmpvar_38)) * 4.0);
      highp float tmpvar_40;
      if ((tmpvar_38 >= 0.0)) {
        tmpvar_40 = tmpvar_39;
      } else {
        tmpvar_40 = -(tmpvar_39);
      };
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_36.x / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float x_44;
      x_44 = ((a_37 - _DITHERMATRIX[
        int(tmpvar_40)
      ][
        int(tmpvar_43)
      ]) - 0.01);
      if ((x_44 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_39;
    scrpos_39 = xlv_TEXCOORD2;
    mediump float a_40;
    a_40 = xlv_TEXCOORD2.z;
    if ((a_40 < 0.95)) {
      scrpos_39.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_40 = (a_40 * 17.0);
      highp float tmpvar_41;
      tmpvar_41 = (scrpos_39.y / 4.0);
      highp float tmpvar_42;
      tmpvar_42 = (fract(abs(tmpvar_41)) * 4.0);
      highp float tmpvar_43;
      if ((tmpvar_41 >= 0.0)) {
        tmpvar_43 = tmpvar_42;
      } else {
        tmpvar_43 = -(tmpvar_42);
      };
      highp float tmpvar_44;
      tmpvar_44 = (scrpos_39.x / 4.0);
      highp float tmpvar_45;
      tmpvar_45 = (fract(abs(tmpvar_44)) * 4.0);
      highp float tmpvar_46;
      if ((tmpvar_44 >= 0.0)) {
        tmpvar_46 = tmpvar_45;
      } else {
        tmpvar_46 = -(tmpvar_45);
      };
      highp float x_47;
      x_47 = ((a_40 - _DITHERMATRIX[
        int(tmpvar_43)
      ][
        int(tmpvar_46)
      ]) - 0.01);
      if ((x_47 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  col_1.w = _BloomIntensity;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_43;
    scrpos_43 = xlv_TEXCOORD2;
    mediump float a_44;
    a_44 = xlv_TEXCOORD2.z;
    if ((a_44 < 0.95)) {
      scrpos_43.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_44 = (a_44 * 17.0);
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_43.y / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float tmpvar_48;
      tmpvar_48 = (scrpos_43.x / 4.0);
      highp float tmpvar_49;
      tmpvar_49 = (fract(abs(tmpvar_48)) * 4.0);
      highp float tmpvar_50;
      if ((tmpvar_48 >= 0.0)) {
        tmpvar_50 = tmpvar_49;
      } else {
        tmpvar_50 = -(tmpvar_49);
      };
      highp float x_51;
      x_51 = ((a_44 - _DITHERMATRIX[
        int(tmpvar_47)
      ][
        int(tmpvar_50)
      ]) - 0.01);
      if ((x_51 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.y = 0.5;
  tmpvar_21.x = diff_17;
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.y = 0.5;
  tmpvar_24.x = diff_20;
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump float spec_23;
  mediump float tmpvar_24;
  tmpvar_24 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_25;
  tmpvar_25 = tmpvar_24;
  spec_23 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = (abs(dFdx(spec_23)) + abs(dFdy(spec_23)));
  mediump float edge0_27;
  edge0_27 = ((1.0 - lightmap_5.z) - tmpvar_26);
  mediump float tmpvar_28;
  tmpvar_28 = clamp (((spec_23 - edge0_27) / (
    ((1.0 - lightmap_5.z) + tmpvar_26)
   - edge0_27)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_28 * (tmpvar_28 * 
      (3.0 - (2.0 * tmpvar_28))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_29;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_30.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_29 = (x_30 - unity_SHC.xyz);
  mediump vec3 tmpvar_31;
  tmpvar_31 = max (((1.055 * 
    pow (max (res_29, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_29 = tmpvar_31;
  col_1.xyz = (col_1.xyz + ((tmpvar_31 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_32;
  bool tmpvar_33;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_33 = bool(1);
  } else {
    tmpvar_33 = bool(0);
  };
  if (tmpvar_33) {
    tmpvar_32 = _BloomIntensity0;
  } else {
    bool tmpvar_34;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_34 = bool(1);
    } else {
      tmpvar_34 = bool(0);
    };
    if (tmpvar_34) {
      tmpvar_32 = _BloomIntensity1;
    } else {
      bool tmpvar_35;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_35 = bool(1);
      } else {
        tmpvar_35 = bool(0);
      };
      if (tmpvar_35) {
        tmpvar_32 = _BloomIntensity2;
      } else {
        bool tmpvar_36;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_36 = bool(1);
        } else {
          tmpvar_36 = bool(0);
        };
        if (tmpvar_36) {
          tmpvar_32 = _BloomIntensity3;
        } else {
          bool tmpvar_37;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_37 = bool(1);
          } else {
            tmpvar_37 = bool(0);
          };
          if (tmpvar_37) {
            tmpvar_32 = _BloomIntensity4;
          } else {
            bool tmpvar_38;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_38 = bool(1);
            } else {
              tmpvar_38 = bool(0);
            };
            if (tmpvar_38) {
              tmpvar_32 = _BloomIntensity5;
            } else {
              bool tmpvar_39;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_39 = bool(1);
              } else {
                tmpvar_39 = bool(0);
              };
              if (tmpvar_39) {
                tmpvar_32 = _BloomIntensity6;
              } else {
                tmpvar_32 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_32;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_40;
    scrpos_40 = xlv_TEXCOORD2;
    mediump float a_41;
    a_41 = xlv_TEXCOORD2.z;
    if ((a_41 < 0.95)) {
      scrpos_40.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_41 = (a_41 * 17.0);
      highp float tmpvar_42;
      tmpvar_42 = (scrpos_40.y / 4.0);
      highp float tmpvar_43;
      tmpvar_43 = (fract(abs(tmpvar_42)) * 4.0);
      highp float tmpvar_44;
      if ((tmpvar_42 >= 0.0)) {
        tmpvar_44 = tmpvar_43;
      } else {
        tmpvar_44 = -(tmpvar_43);
      };
      highp float tmpvar_45;
      tmpvar_45 = (scrpos_40.x / 4.0);
      highp float tmpvar_46;
      tmpvar_46 = (fract(abs(tmpvar_45)) * 4.0);
      highp float tmpvar_47;
      if ((tmpvar_45 >= 0.0)) {
        tmpvar_47 = tmpvar_46;
      } else {
        tmpvar_47 = -(tmpvar_46);
      };
      highp float x_48;
      x_48 = ((a_41 - _DITHERMATRIX[
        int(tmpvar_44)
      ][
        int(tmpvar_47)
      ]) - 0.01);
      if ((x_48 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump float spec_27;
  mediump float tmpvar_28;
  tmpvar_28 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_29;
  tmpvar_29 = (shadow_26 * tmpvar_28);
  spec_27 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = (abs(dFdx(spec_27)) + abs(dFdy(spec_27)));
  mediump float edge0_31;
  edge0_31 = ((1.0 - lightmap_5.z) - tmpvar_30);
  mediump float tmpvar_32;
  tmpvar_32 = clamp (((spec_27 - edge0_31) / (
    ((1.0 - lightmap_5.z) + tmpvar_30)
   - edge0_31)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((_SpecularColor.xyz * vec3((tmpvar_32 * (tmpvar_32 * 
      (3.0 - (2.0 * tmpvar_32))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_33;
  mediump vec3 x_34;
  x_34.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_34.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_33 = (x_34 - unity_SHC.xyz);
  mediump vec3 tmpvar_35;
  tmpvar_35 = max (((1.055 * 
    pow (max (res_33, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_33 = tmpvar_35;
  col_1.xyz = (col_1.xyz + ((tmpvar_35 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_36;
  bool tmpvar_37;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_37 = bool(1);
  } else {
    tmpvar_37 = bool(0);
  };
  if (tmpvar_37) {
    tmpvar_36 = _BloomIntensity0;
  } else {
    bool tmpvar_38;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_38 = bool(1);
    } else {
      tmpvar_38 = bool(0);
    };
    if (tmpvar_38) {
      tmpvar_36 = _BloomIntensity1;
    } else {
      bool tmpvar_39;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_39 = bool(1);
      } else {
        tmpvar_39 = bool(0);
      };
      if (tmpvar_39) {
        tmpvar_36 = _BloomIntensity2;
      } else {
        bool tmpvar_40;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_40 = bool(1);
        } else {
          tmpvar_40 = bool(0);
        };
        if (tmpvar_40) {
          tmpvar_36 = _BloomIntensity3;
        } else {
          bool tmpvar_41;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_41 = bool(1);
          } else {
            tmpvar_41 = bool(0);
          };
          if (tmpvar_41) {
            tmpvar_36 = _BloomIntensity4;
          } else {
            bool tmpvar_42;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_42 = bool(1);
            } else {
              tmpvar_42 = bool(0);
            };
            if (tmpvar_42) {
              tmpvar_36 = _BloomIntensity5;
            } else {
              bool tmpvar_43;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_43 = bool(1);
              } else {
                tmpvar_43 = bool(0);
              };
              if (tmpvar_43) {
                tmpvar_36 = _BloomIntensity6;
              } else {
                tmpvar_36 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_36;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_44;
    scrpos_44 = xlv_TEXCOORD2;
    mediump float a_45;
    a_45 = xlv_TEXCOORD2.z;
    if ((a_45 < 0.95)) {
      scrpos_44.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_45 = (a_45 * 17.0);
      highp float tmpvar_46;
      tmpvar_46 = (scrpos_44.y / 4.0);
      highp float tmpvar_47;
      tmpvar_47 = (fract(abs(tmpvar_46)) * 4.0);
      highp float tmpvar_48;
      if ((tmpvar_46 >= 0.0)) {
        tmpvar_48 = tmpvar_47;
      } else {
        tmpvar_48 = -(tmpvar_47);
      };
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_44.x / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float x_52;
      x_52 = ((a_45 - _DITHERMATRIX[
        int(tmpvar_48)
      ][
        int(tmpvar_51)
      ]) - 0.01);
      if ((x_52 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_15;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_16;
  mediump float diff_17;
  mediump float tmpvar_18;
  tmpvar_18 = clamp (1.0, 0.0, 1.0);
  mediump float tmpvar_19;
  tmpvar_19 = mix (0.5, ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_18 * (tmpvar_18 * 
    (3.0 - (2.0 * tmpvar_18))
  )));
  diff_17 = tmpvar_19;
  mediump vec2 tmpvar_20;
  tmpvar_20 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_19 < tmpvar_20.x)) {
    diff_17 = (clamp ((tmpvar_19 / 
      max (tmpvar_20.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_17 < tmpvar_20.y)) {
      diff_17 = (0.25 + (clamp (
        ((diff_17 - tmpvar_20.x) / max ((tmpvar_20.y - tmpvar_20.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_17 = (0.75 + (clamp (
        ((diff_17 - tmpvar_20.y) / max ((1.0 - tmpvar_20.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_21;
  tmpvar_21.x = diff_17;
  tmpvar_21.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_22;
  tmpvar_22 = texture2D (_DiffuseRampMuitiTex, tmpvar_21).xyz;
  diffuseLighting_16 = tmpvar_22;
  diffuseLighting_16 = (diffuseLighting_16 * tmpvar_8.xyz);
  mediump vec4 specularColor_23;
  mediump float spec_24;
  mediump float tmpvar_25;
  tmpvar_25 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_26;
  tmpvar_26 = tmpvar_25;
  spec_24 = tmpvar_26;
  specularColor_23 = _SpecularColor0;
  bool tmpvar_27;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_27 = bool(1);
  } else {
    tmpvar_27 = bool(0);
  };
  if (tmpvar_27) {
    specularColor_23 = _SpecularColor1;
  } else {
    bool tmpvar_28;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_28 = bool(1);
    } else {
      tmpvar_28 = bool(0);
    };
    if (tmpvar_28) {
      specularColor_23 = _SpecularColor2;
    } else {
      bool tmpvar_29;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_29 = bool(1);
      } else {
        tmpvar_29 = bool(0);
      };
      if (tmpvar_29) {
        specularColor_23 = _SpecularColor3;
      } else {
        bool tmpvar_30;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_30 = bool(1);
        } else {
          tmpvar_30 = bool(0);
        };
        if (tmpvar_30) {
          specularColor_23 = _SpecularColor4;
        } else {
          bool tmpvar_31;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_31 = bool(1);
          } else {
            tmpvar_31 = bool(0);
          };
          if (tmpvar_31) {
            specularColor_23 = _SpecularColor5;
          } else {
            bool tmpvar_32;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_32 = bool(1);
            } else {
              tmpvar_32 = bool(0);
            };
            if (tmpvar_32) {
              specularColor_23 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_33;
  tmpvar_33 = (abs(dFdx(spec_24)) + abs(dFdy(spec_24)));
  mediump float edge0_34;
  edge0_34 = ((1.0 - lightmap_5.z) - tmpvar_33);
  mediump float tmpvar_35;
  tmpvar_35 = clamp (((spec_24 - edge0_34) / (
    ((1.0 - lightmap_5.z) + tmpvar_33)
   - edge0_34)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_16 + ((
    ((specularColor_23.xyz * vec3((tmpvar_35 * (tmpvar_35 * 
      (3.0 - (2.0 * tmpvar_35))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_36;
  mediump vec3 x_37;
  x_37.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_37.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_36 = (x_37 - unity_SHC.xyz);
  mediump vec3 tmpvar_38;
  tmpvar_38 = max (((1.055 * 
    pow (max (res_36, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_36 = tmpvar_38;
  col_1.xyz = (col_1.xyz + ((tmpvar_38 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_39;
  bool tmpvar_40;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_40 = bool(1);
  } else {
    tmpvar_40 = bool(0);
  };
  if (tmpvar_40) {
    tmpvar_39 = _BloomIntensity0;
  } else {
    bool tmpvar_41;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_41 = bool(1);
    } else {
      tmpvar_41 = bool(0);
    };
    if (tmpvar_41) {
      tmpvar_39 = _BloomIntensity1;
    } else {
      bool tmpvar_42;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_42 = bool(1);
      } else {
        tmpvar_42 = bool(0);
      };
      if (tmpvar_42) {
        tmpvar_39 = _BloomIntensity2;
      } else {
        bool tmpvar_43;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_43 = bool(1);
        } else {
          tmpvar_43 = bool(0);
        };
        if (tmpvar_43) {
          tmpvar_39 = _BloomIntensity3;
        } else {
          bool tmpvar_44;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_44 = bool(1);
          } else {
            tmpvar_44 = bool(0);
          };
          if (tmpvar_44) {
            tmpvar_39 = _BloomIntensity4;
          } else {
            bool tmpvar_45;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_45 = bool(1);
            } else {
              tmpvar_45 = bool(0);
            };
            if (tmpvar_45) {
              tmpvar_39 = _BloomIntensity5;
            } else {
              bool tmpvar_46;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_46 = bool(1);
              } else {
                tmpvar_46 = bool(0);
              };
              if (tmpvar_46) {
                tmpvar_39 = _BloomIntensity6;
              } else {
                tmpvar_39 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_39;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_47;
    scrpos_47 = xlv_TEXCOORD2;
    mediump float a_48;
    a_48 = xlv_TEXCOORD2.z;
    if ((a_48 < 0.95)) {
      scrpos_47.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_48 = (a_48 * 17.0);
      highp float tmpvar_49;
      tmpvar_49 = (scrpos_47.y / 4.0);
      highp float tmpvar_50;
      tmpvar_50 = (fract(abs(tmpvar_49)) * 4.0);
      highp float tmpvar_51;
      if ((tmpvar_49 >= 0.0)) {
        tmpvar_51 = tmpvar_50;
      } else {
        tmpvar_51 = -(tmpvar_50);
      };
      highp float tmpvar_52;
      tmpvar_52 = (scrpos_47.x / 4.0);
      highp float tmpvar_53;
      tmpvar_53 = (fract(abs(tmpvar_52)) * 4.0);
      highp float tmpvar_54;
      if ((tmpvar_52 >= 0.0)) {
        tmpvar_54 = tmpvar_53;
      } else {
        tmpvar_54 = -(tmpvar_53);
      };
      highp float x_55;
      x_55 = ((a_48 - _DITHERMATRIX[
        int(tmpvar_51)
      ][
        int(tmpvar_54)
      ]) - 0.01);
      if ((x_55 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaps_ST;
uniform mediump float _UsingDitherAlpha;
uniform mediump float _DitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainMaps_ST.xy) + _MainMaps_ST.zw);
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  tmpvar_3 = o_7;
  tmpvar_4 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_WorldToObject[0].xyz;
  tmpvar_10[1] = unity_WorldToObject[1].xyz;
  tmpvar_10[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_glesNormal * tmpvar_10));
  if (bool(_UsingDitherAlpha)) {
    tmpvar_3.z = _DitherAlpha;
  };
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = tmpvar_11;
}


#endif
#ifdef FRAGMENT
#extension GL_OES_standard_derivatives : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHC;
uniform highp float _ReceiveDynamicShadow;
uniform sampler2D _DynamicCharacterShadowVolumeBuffer;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _AlphaCutoff;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMap;
uniform sampler2D _MaskMap;
uniform mediump float _BloomIntensity0;
uniform mediump float _BloomIntensity1;
uniform mediump float _BloomIntensity2;
uniform mediump float _BloomIntensity3;
uniform mediump float _BloomIntensity4;
uniform mediump float _BloomIntensity5;
uniform mediump float _BloomIntensity6;
uniform mediump float _BloomIntensity7;
uniform sampler2D _DiffuseRampMuitiTex;
uniform mediump vec2 _DiffuseRanges;
uniform mediump float _ShadowThreshold;
uniform mediump vec4 _SpecularColor0;
uniform mediump vec4 _SpecularColor1;
uniform mediump vec4 _SpecularColor2;
uniform mediump vec4 _SpecularColor3;
uniform mediump vec4 _SpecularColor4;
uniform mediump vec4 _SpecularColor5;
uniform mediump vec4 _SpecularColor6;
uniform mediump float _SpecularShininess;
uniform mediump float _SpecularIntensity;
uniform mediump vec4 _LightPosDir;
uniform mediump vec4 _CharacterSHColor;
uniform mediump float _UsingDitherAlpha;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec4 col_1;
  mediump vec3 normalDir_2;
  mediump vec3 viewDir_3;
  mediump vec4 mask_4;
  mediump vec4 lightmap_5;
  mediump vec4 albedo_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * _Color) * _EnvColor);
  albedo_6.xyz = tmpvar_8.xyz;
  albedo_6.w = clamp (tmpvar_8.w, 0.0, 1.0);
  mediump float x_9;
  x_9 = (albedo_6.w - _AlphaCutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_LightMap, xlv_TEXCOORD0);
  lightmap_5 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MaskMap, xlv_TEXCOORD0);
  mask_4 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = floor(((lightmap_5.w * 8.0) + 0.5));
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3));
  viewDir_3 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = normalize((_LightPosDir.xyz + viewDir_3));
  highp vec2 screenCoord_15;
  screenCoord_15 = (xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w);
  mediump float shadow_16;
  shadow_16 = 1.0;
  if ((_ReceiveDynamicShadow > 0.5)) {
    lowp vec4 tmpvar_17;
    tmpvar_17 = texture2D (_DynamicCharacterShadowVolumeBuffer, screenCoord_15);
    shadow_16 = tmpvar_17.x;
  };
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(xlv_TEXCOORD4);
  normalDir_2 = tmpvar_18;
  col_1 = vec4(1.0, 1.0, 1.0, 1.0);
  mediump vec3 diffuseLighting_19;
  mediump float diff_20;
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((shadow_16 - 0.5) / 0.5), 0.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = mix (mix (0.4, 0.5, shadow_16), ((
    ((dot (normalDir_2, _LightPosDir.xyz) * 0.5) + 0.5)
   * lightmap_5.y) * 2.0), (tmpvar_21 * (tmpvar_21 * 
    (3.0 - (2.0 * tmpvar_21))
  )));
  diff_20 = tmpvar_22;
  mediump vec2 tmpvar_23;
  tmpvar_23 = mix (_DiffuseRanges, vec2(_ShadowThreshold), vec2((1.0 - mask_4.x)));
  if ((tmpvar_22 < tmpvar_23.x)) {
    diff_20 = (clamp ((tmpvar_22 / 
      max (tmpvar_23.x, 0.0001)
    ), 0.0, 1.0) * 0.25);
  } else {
    if ((diff_20 < tmpvar_23.y)) {
      diff_20 = (0.25 + (clamp (
        ((diff_20 - tmpvar_23.x) / max ((tmpvar_23.y - tmpvar_23.x), 0.0001))
      , 0.0, 1.0) * 0.5));
    } else {
      diff_20 = (0.75 + (clamp (
        ((diff_20 - tmpvar_23.y) / max ((1.0 - tmpvar_23.y), 0.0001))
      , 0.0, 1.0) * 0.25));
    };
  };
  mediump vec2 tmpvar_24;
  tmpvar_24.x = diff_20;
  tmpvar_24.y = (((tmpvar_12 * 2.0) + 1.0) * 0.0625);
  lowp vec3 tmpvar_25;
  tmpvar_25 = texture2D (_DiffuseRampMuitiTex, tmpvar_24).xyz;
  diffuseLighting_19 = tmpvar_25;
  diffuseLighting_19 = (diffuseLighting_19 * tmpvar_8.xyz);
  highp float shadow_26;
  shadow_26 = shadow_16;
  mediump vec4 specularColor_27;
  mediump float spec_28;
  mediump float tmpvar_29;
  tmpvar_29 = pow (max (dot (normalDir_2, tmpvar_14), 0.0), _SpecularShininess);
  highp float tmpvar_30;
  tmpvar_30 = (shadow_26 * tmpvar_29);
  spec_28 = tmpvar_30;
  specularColor_27 = _SpecularColor0;
  bool tmpvar_31;
  if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
    tmpvar_31 = bool(1);
  } else {
    tmpvar_31 = bool(0);
  };
  if (tmpvar_31) {
    specularColor_27 = _SpecularColor1;
  } else {
    bool tmpvar_32;
    if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
      tmpvar_32 = bool(1);
    } else {
      tmpvar_32 = bool(0);
    };
    if (tmpvar_32) {
      specularColor_27 = _SpecularColor2;
    } else {
      bool tmpvar_33;
      if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
        tmpvar_33 = bool(1);
      } else {
        tmpvar_33 = bool(0);
      };
      if (tmpvar_33) {
        specularColor_27 = _SpecularColor3;
      } else {
        bool tmpvar_34;
        if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
          tmpvar_34 = bool(1);
        } else {
          tmpvar_34 = bool(0);
        };
        if (tmpvar_34) {
          specularColor_27 = _SpecularColor4;
        } else {
          bool tmpvar_35;
          if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
            tmpvar_35 = bool(1);
          } else {
            tmpvar_35 = bool(0);
          };
          if (tmpvar_35) {
            specularColor_27 = _SpecularColor5;
          } else {
            bool tmpvar_36;
            if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
              tmpvar_36 = bool(1);
            } else {
              tmpvar_36 = bool(0);
            };
            if (tmpvar_36) {
              specularColor_27 = _SpecularColor6;
            };
          };
        };
      };
    };
  };
  mediump float tmpvar_37;
  tmpvar_37 = (abs(dFdx(spec_28)) + abs(dFdy(spec_28)));
  mediump float edge0_38;
  edge0_38 = ((1.0 - lightmap_5.z) - tmpvar_37);
  mediump float tmpvar_39;
  tmpvar_39 = clamp (((spec_28 - edge0_38) / (
    ((1.0 - lightmap_5.z) + tmpvar_37)
   - edge0_38)), 0.0, 1.0);
  col_1.xyz = (diffuseLighting_19 + ((
    ((specularColor_27.xyz * vec3((tmpvar_39 * (tmpvar_39 * 
      (3.0 - (2.0 * tmpvar_39))
    )))) * lightmap_5.x)
   * _SpecularIntensity) * tmpvar_8.xyz));
  mediump vec3 res_40;
  mediump vec3 x_41;
  x_41.x = dot (unity_SHAr, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.y = dot (unity_SHAg, vec4(0.0, 1.0, 0.0, 1.0));
  x_41.z = dot (unity_SHAb, vec4(0.0, 1.0, 0.0, 1.0));
  res_40 = (x_41 - unity_SHC.xyz);
  mediump vec3 tmpvar_42;
  tmpvar_42 = max (((1.055 * 
    pow (max (res_40, vec3(0.0, 0.0, 0.0)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  res_40 = tmpvar_42;
  col_1.xyz = (col_1.xyz + ((tmpvar_42 * _CharacterSHColor.xyz) * (_CharacterSHColor.w * tmpvar_8.xyz)));
  mediump float tmpvar_43;
  bool tmpvar_44;
  if (((-0.5 < tmpvar_12) && (tmpvar_12 < 0.5))) {
    tmpvar_44 = bool(1);
  } else {
    tmpvar_44 = bool(0);
  };
  if (tmpvar_44) {
    tmpvar_43 = _BloomIntensity0;
  } else {
    bool tmpvar_45;
    if (((0.5 < tmpvar_12) && (tmpvar_12 < 1.5))) {
      tmpvar_45 = bool(1);
    } else {
      tmpvar_45 = bool(0);
    };
    if (tmpvar_45) {
      tmpvar_43 = _BloomIntensity1;
    } else {
      bool tmpvar_46;
      if (((1.5 < tmpvar_12) && (tmpvar_12 < 2.5))) {
        tmpvar_46 = bool(1);
      } else {
        tmpvar_46 = bool(0);
      };
      if (tmpvar_46) {
        tmpvar_43 = _BloomIntensity2;
      } else {
        bool tmpvar_47;
        if (((2.5 < tmpvar_12) && (tmpvar_12 < 3.5))) {
          tmpvar_47 = bool(1);
        } else {
          tmpvar_47 = bool(0);
        };
        if (tmpvar_47) {
          tmpvar_43 = _BloomIntensity3;
        } else {
          bool tmpvar_48;
          if (((3.5 < tmpvar_12) && (tmpvar_12 < 4.5))) {
            tmpvar_48 = bool(1);
          } else {
            tmpvar_48 = bool(0);
          };
          if (tmpvar_48) {
            tmpvar_43 = _BloomIntensity4;
          } else {
            bool tmpvar_49;
            if (((4.5 < tmpvar_12) && (tmpvar_12 < 5.5))) {
              tmpvar_49 = bool(1);
            } else {
              tmpvar_49 = bool(0);
            };
            if (tmpvar_49) {
              tmpvar_43 = _BloomIntensity5;
            } else {
              bool tmpvar_50;
              if (((5.5 < tmpvar_12) && (tmpvar_12 < 6.5))) {
                tmpvar_50 = bool(1);
              } else {
                tmpvar_50 = bool(0);
              };
              if (tmpvar_50) {
                tmpvar_43 = _BloomIntensity6;
              } else {
                tmpvar_43 = _BloomIntensity7;
              };
            };
          };
        };
      };
    };
  };
  col_1.w = tmpvar_43;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_51;
    scrpos_51 = xlv_TEXCOORD2;
    mediump float a_52;
    a_52 = xlv_TEXCOORD2.z;
    if ((a_52 < 0.95)) {
      scrpos_51.xy = ((xlv_TEXCOORD2.xy / xlv_TEXCOORD2.w) * _ScreenParams.xy);
      a_52 = (a_52 * 17.0);
      highp float tmpvar_53;
      tmpvar_53 = (scrpos_51.y / 4.0);
      highp float tmpvar_54;
      tmpvar_54 = (fract(abs(tmpvar_53)) * 4.0);
      highp float tmpvar_55;
      if ((tmpvar_53 >= 0.0)) {
        tmpvar_55 = tmpvar_54;
      } else {
        tmpvar_55 = -(tmpvar_54);
      };
      highp float tmpvar_56;
      tmpvar_56 = (scrpos_51.x / 4.0);
      highp float tmpvar_57;
      tmpvar_57 = (fract(abs(tmpvar_56)) * 4.0);
      highp float tmpvar_58;
      if ((tmpvar_56 >= 0.0)) {
        tmpvar_58 = tmpvar_57;
      } else {
        tmpvar_58 = -(tmpvar_57);
      };
      highp float x_59;
      x_59 = ((a_52 - _DITHERMATRIX[
        int(tmpvar_55)
      ][
        int(tmpvar_58)
      ]) - 0.01);
      if ((x_59 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = col_1;
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
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHATEST_ON" "_DYNAMIC_CHARACTER_SHADOW_ON" "_MULTI_BLOOM_ON" "_MULTI_DIFFUSE_ON" "_MULTI_SPECULAR_ON" }
""
}
}
}
 UsePass "Hidden/miHoYo/DLC/Character/Shared/OPAQUEOUTLINE"
 UsePass "Hidden/miHoYo/DLC/Common/Shared/PREDEPTH"
}
CustomEditor "MoleMoleEditor.CharacterAvatarShaderGUI"
}