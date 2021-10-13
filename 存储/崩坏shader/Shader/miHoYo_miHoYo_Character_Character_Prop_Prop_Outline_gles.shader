//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Outline" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
[Toggle(CLIP_PLANE_WORLD)] _ClipPlaneWorld ("Clip Plane In World Space", Float) = 0
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPOutlineColor ("SP Outline Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
[Toggle(EMISSION_OVERRIDE)] _EmissionOverride ("Emission Override (Only store param, need to do overriding in script)", Float) = 0
_EOEmissionScaler ("Overriding Emission Scaler", Range(1, 10)) = 1
_EOEmissionBloomFactor ("Overriding Emission Bloom Factor", Float) = 1
[Toggle(USINGDITHERALPAH)] _UsingDitherAlpha ("UsingDitherAlpha", Float) = 0
_DitherAlpha ("Dither Alpha Value", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 45247
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_22;
    highp vec4 tmpvar_23;
    tmpvar_23 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_24;
    tmpvar_24.x = tmpvar_23.x;
    tmpvar_24.y = (tmpvar_23.y * _ProjectionParams.x);
    o_22.xy = (tmpvar_24 + tmpvar_23.w);
    o_22.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_22.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_28;
    highp vec4 tmpvar_29;
    tmpvar_29 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_30;
    tmpvar_30.x = tmpvar_29.x;
    tmpvar_30.y = (tmpvar_29.y * _ProjectionParams.x);
    o_28.xy = (tmpvar_30 + tmpvar_29.w);
    o_28.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_28.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_28;
    highp vec4 tmpvar_29;
    tmpvar_29 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_30;
    tmpvar_30.x = tmpvar_29.x;
    tmpvar_30.y = (tmpvar_29.y * _ProjectionParams.x);
    o_28.xy = (tmpvar_30 + tmpvar_29.w);
    o_28.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_28.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_28;
    highp vec4 tmpvar_29;
    tmpvar_29 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_30;
    tmpvar_30.x = tmpvar_29.x;
    tmpvar_30.y = (tmpvar_29.y * _ProjectionParams.x);
    o_28.xy = (tmpvar_30 + tmpvar_29.w);
    o_28.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_28.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_14;
    scrpos_14 = xlv_TEXCOORD3;
    mediump float a_15;
    a_15 = xlv_TEXCOORD3.z;
    if ((a_15 < 0.95)) {
      scrpos_14.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_15 = (a_15 * 17.0);
      highp float tmpvar_16;
      tmpvar_16 = (scrpos_14.y / 4.0);
      highp float tmpvar_17;
      tmpvar_17 = (fract(abs(tmpvar_16)) * 4.0);
      highp float tmpvar_18;
      if ((tmpvar_16 >= 0.0)) {
        tmpvar_18 = tmpvar_17;
      } else {
        tmpvar_18 = -(tmpvar_17);
      };
      highp float tmpvar_19;
      tmpvar_19 = (scrpos_14.x / 4.0);
      highp float tmpvar_20;
      tmpvar_20 = (fract(abs(tmpvar_19)) * 4.0);
      highp float tmpvar_21;
      if ((tmpvar_19 >= 0.0)) {
        tmpvar_21 = tmpvar_20;
      } else {
        tmpvar_21 = -(tmpvar_20);
      };
      highp float x_22;
      x_22 = ((a_15 - _DITHERMATRIX[
        int(tmpvar_18)
      ][
        int(tmpvar_21)
      ]) - 0.01);
      if ((x_22 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = outColor_3;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_19 < (_ClipPlane.w - 0.01))) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_19 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.w = 1.0;
  tmpvar_21.xyz = vertex_17.xyz;
  tmpvar_20 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_21));
  highp vec4 spuvs_22;
  highp vec4 tmpvar_23;
  tmpvar_23 = (vertex_17 * 0.5);
  spuvs_22.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_24;
  tmpvar_24.x = (tmpvar_23.x + (tmpvar_23.z * tmpvar_23.z));
  tmpvar_24.y = ((tmpvar_23.y + (0.5 * tmpvar_23.z)) + ((0.5 * tmpvar_23.x) * tmpvar_23.x));
  spuvs_22.zw = ((tmpvar_24 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_25;
    highp vec4 tmpvar_26;
    tmpvar_26 = (tmpvar_20 * 0.5);
    highp vec2 tmpvar_27;
    tmpvar_27.x = tmpvar_26.x;
    tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
    o_25.xy = (tmpvar_27 + tmpvar_26.w);
    o_25.zw = tmpvar_20.zw;
    tmpvar_6.xyw = o_25.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_20;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_22;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  highp vec4 spuvs_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (vertex_17 * 0.5);
  spuvs_28.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_30;
  tmpvar_30.x = (tmpvar_29.x + (tmpvar_29.z * tmpvar_29.z));
  tmpvar_30.y = ((tmpvar_29.y + (0.5 * tmpvar_29.z)) + ((0.5 * tmpvar_29.x) * tmpvar_29.x));
  spuvs_28.zw = ((tmpvar_30 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_31;
    highp vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_33;
    tmpvar_33.x = tmpvar_32.x;
    tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
    o_31.xy = (tmpvar_33 + tmpvar_32.w);
    o_31.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_31.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_28;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  highp vec4 spuvs_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (vertex_17 * 0.5);
  spuvs_28.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_30;
  tmpvar_30.x = (tmpvar_29.x + (tmpvar_29.z * tmpvar_29.z));
  tmpvar_30.y = ((tmpvar_29.y + (0.5 * tmpvar_29.z)) + ((0.5 * tmpvar_29.x) * tmpvar_29.x));
  spuvs_28.zw = ((tmpvar_30 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_31;
    highp vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_33;
    tmpvar_33.x = tmpvar_32.x;
    tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
    o_31.xy = (tmpvar_33 + tmpvar_32.w);
    o_31.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_31.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_28;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform mediump float _UseCameraFade;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7 = vec2(0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_4 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_4, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  if (bool(_UseCameraFade)) {
    highp float fadeOffset_13;
    fadeOffset_13 = _FadeOffset;
    highp float fadeDistance_14;
    fadeDistance_14 = _FadeDistance;
    highp float tmpvar_15;
    tmpvar_15 = clamp (((
      (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
     - fadeOffset_13) / fadeDistance_14), 0.0, 1.0);
    alpha_2 = tmpvar_15;
  };
  highp float alpha_16;
  alpha_16 = alpha_2;
  highp vec4 vertex_17;
  vertex_17 = tmpvar_1;
  highp float tmpvar_18;
  highp vec4 pointInPlane_19;
  highp float tmpvar_20;
  tmpvar_20 = abs(_ClipPlane.w);
  if ((tmpvar_20 < 0.001)) {
    pointInPlane_19 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_21;
    tmpvar_21.w = 1.0;
    tmpvar_21.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_19 = tmpvar_21;
  };
  pointInPlane_19 = (unity_WorldToObject * pointInPlane_19);
  pointInPlane_19 = (pointInPlane_19 / pointInPlane_19.w);
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_WorldToObject[0].xyz;
  tmpvar_22[1] = unity_WorldToObject[1].xyz;
  tmpvar_22[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _ClipPlane.xyz);
  highp float tmpvar_24;
  tmpvar_24 = dot (pointInPlane_19.xyz, tmpvar_23);
  highp float tmpvar_25;
  tmpvar_25 = dot (_glesVertex.xyz, tmpvar_23);
  if ((tmpvar_25 < tmpvar_24)) {
    vertex_17.xyz = (_glesVertex.xyz - ((tmpvar_25 - tmpvar_24) * tmpvar_23));
    tmpvar_18 = 0.0;
  } else {
    tmpvar_18 = alpha_16;
  };
  tmpvar_1 = vertex_17;
  alpha_2 = (alpha_2 * tmpvar_18);
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_26;
  highp vec4 tmpvar_27;
  tmpvar_27.w = 1.0;
  tmpvar_27.xyz = vertex_17.xyz;
  tmpvar_26 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_27));
  highp vec4 spuvs_28;
  highp vec4 tmpvar_29;
  tmpvar_29 = (vertex_17 * 0.5);
  spuvs_28.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_30;
  tmpvar_30.x = (tmpvar_29.x + (tmpvar_29.z * tmpvar_29.z));
  tmpvar_30.y = ((tmpvar_29.y + (0.5 * tmpvar_29.z)) + ((0.5 * tmpvar_29.x) * tmpvar_29.x));
  spuvs_28.zw = ((tmpvar_30 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_31;
    highp vec4 tmpvar_32;
    tmpvar_32 = (tmpvar_26 * 0.5);
    highp vec2 tmpvar_33;
    tmpvar_33.x = tmpvar_32.x;
    tmpvar_33.y = (tmpvar_32.y * _ProjectionParams.x);
    o_31.xy = (tmpvar_33 + tmpvar_32.w);
    o_31.zw = tmpvar_26.zw;
    tmpvar_6.xyw = o_31.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  if (bool(_UsingBloomMask)) {
    tmpvar_7 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_26;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_28;
  xlv_TEXCOORD5 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform sampler2D _SPTex;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPIntensity;
uniform highp float _SPTransition;
uniform mediump vec4 _SPTransitionColor;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionEmissionScaler;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform mediump float _OpaquenessReduse;
uniform mediump vec4 _EmissionTintColor;
uniform mediump float _EmissionScaler;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _LightArea;
uniform mediump vec4 _ShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform highp float _UsingDitherAlpha;
uniform highp float _UsingBloomMask;
uniform sampler2D _BloomMaskTex;
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
highp float xlat_mutable_SPIntensity;
highp float xlat_mutable_SPTransition;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  xlat_mutable_SPIntensity = _SPIntensity;
  xlat_mutable_SPTransition = _SPTransition;
  mediump float emissionFactor_1;
  mediump vec3 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_2 = tmpvar_4;
  mediump vec3 diffColor_5;
  diffColor_5 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_5 = (baseTexColor_2 * _ShadowMultColor.xyz);
  } else {
    diffColor_5 = baseTexColor_2;
  };
  mediump vec3 tmpvar_6;
  tmpvar_6 = ((baseTexColor_2 * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_7;
  position_7 = xlv_TEXCOORD2;
  mediump vec3 specColor_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceCameraPos - position_7));
  xlat_mutableV = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_10;
  specColor_8 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_12;
  tmpvar_12 = mix (_EmissionFactor, tmpvar_11.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_12;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_13;
    tmpvar_13 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_12 * tmpvar_13.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_5 * _EnvColor.xyz)
  , tmpvar_6, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_8);
  outColor_3.w = clamp ((xlv_COLOR1.y + _OpaquenessReduse), 0.0, 1.0);
  mediump float intensity_14;
  mediump vec4 spColor_15;
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_15 = tmpvar_16;
  spColor_15.w = (spColor_15.w * _SPOpaqueness);
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_18;
  tmpvar_18 = (((1.99 * tmpvar_17.x) * _SPNoiseScaler) - 1.0);
  intensity_14 = tmpvar_18;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_14 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_14 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_19;
      tmpvar_19 = mix (spColor_15.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_14) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_15.xyz = tmpvar_19;
    };
  };
  highp vec4 tmpvar_20;
  tmpvar_20 = mix (outColor_3, spColor_15, vec4(xlat_mutable_SPIntensity));
  spColor_15 = tmpvar_20;
  outColor_3 = spColor_15;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_21;
    scrpos_21 = xlv_TEXCOORD3;
    mediump float a_22;
    a_22 = xlv_TEXCOORD3.z;
    if ((a_22 < 0.95)) {
      scrpos_21.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_22 = (a_22 * 17.0);
      highp float tmpvar_23;
      tmpvar_23 = (scrpos_21.y / 4.0);
      highp float tmpvar_24;
      tmpvar_24 = (fract(abs(tmpvar_23)) * 4.0);
      highp float tmpvar_25;
      if ((tmpvar_23 >= 0.0)) {
        tmpvar_25 = tmpvar_24;
      } else {
        tmpvar_25 = -(tmpvar_24);
      };
      highp float tmpvar_26;
      tmpvar_26 = (scrpos_21.x / 4.0);
      highp float tmpvar_27;
      tmpvar_27 = (fract(abs(tmpvar_26)) * 4.0);
      highp float tmpvar_28;
      if ((tmpvar_26 >= 0.0)) {
        tmpvar_28 = tmpvar_27;
      } else {
        tmpvar_28 = -(tmpvar_27);
      };
      highp float x_29;
      x_29 = ((a_22 - _DITHERMATRIX[
        int(tmpvar_25)
      ][
        int(tmpvar_28)
      ]) - 0.01);
      if ((x_29 < 0.0)) {
        discard;
      };
    };
  };
  gl_FragData[0] = spColor_15;
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
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 90191
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "Simple" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 191890
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_5 < (_ClipPlane.w - 0.01))) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_5 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = vertex_3.xyz;
  highp vec4 tmpvar_7;
  tmpvar_7 = (vertex_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = (tmpvar_7.x + (tmpvar_7.z * tmpvar_7.z));
  tmpvar_8.y = ((tmpvar_7.y + (0.5 * tmpvar_7.z)) + ((0.5 * tmpvar_7.x) * tmpvar_7.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_8 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
varying highp vec3 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (vertex_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (vertex_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _ClipPlane;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec3 tmpvar_2;
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  highp vec4 vertex_3;
  vertex_3 = tmpvar_1;
  highp float tmpvar_4;
  highp vec4 pointInPlane_5;
  highp float tmpvar_6;
  tmpvar_6 = abs(_ClipPlane.w);
  if ((tmpvar_6 < 0.001)) {
    pointInPlane_5 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_7;
    tmpvar_7.w = 1.0;
    tmpvar_7.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_5 = tmpvar_7;
  };
  pointInPlane_5 = (unity_WorldToObject * pointInPlane_5);
  pointInPlane_5 = (pointInPlane_5 / pointInPlane_5.w);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_8 * _ClipPlane.xyz);
  highp float tmpvar_10;
  tmpvar_10 = dot (pointInPlane_5.xyz, tmpvar_9);
  highp float tmpvar_11;
  tmpvar_11 = dot (_glesVertex.xyz, tmpvar_9);
  if ((tmpvar_11 < tmpvar_10)) {
    vertex_3.xyz = (_glesVertex.xyz - ((tmpvar_11 - tmpvar_10) * tmpvar_9));
    tmpvar_4 = 0.0;
  } else {
    tmpvar_4 = 1.0;
  };
  tmpvar_1 = vertex_3;
  tmpvar_2.z = tmpvar_4;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = vertex_3.xyz;
  highp vec4 tmpvar_13;
  tmpvar_13 = (vertex_3 * 0.5);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (tmpvar_13.z * tmpvar_13.z));
  tmpvar_14.y = ((tmpvar_13.y + (0.5 * tmpvar_13.z)) + ((0.5 * tmpvar_13.x) * tmpvar_13.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((tmpvar_14 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _EmissionFactor;
uniform mediump float _EmissionFactorFromTexToggle;
uniform mediump float _EmissionBloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  color_1.w = (mix (_BloomFactor, _EmissionBloomFactor, mix (_EmissionFactor, tmpvar_2.w, _EmissionFactorFromTexToggle)) * xlv_TEXCOORD0.z);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.PropShaderEditorBase"
}