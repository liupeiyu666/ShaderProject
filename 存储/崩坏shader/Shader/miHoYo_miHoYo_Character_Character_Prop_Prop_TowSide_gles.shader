//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_TowSide" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 0.25
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor", Range(0, 1)) = 0
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 0
[Toggle(SPECIAL_STATE)] _SpecialState ("Special State", Float) = 0
_SPTex ("SP Tex", 2D) = "white" { }
_SPNoiseTex ("SP Noise Tex", 2D) = "white" { }
_SPNoiseScaler ("SP Noise Scaler", Range(0, 10)) = 1
_SPIntensity ("SP Intensity", Range(0, 1)) = 0.5
_SPTransition ("SP Transition", Range(0, 1)) = 0
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPTransitionEmissionScaler ("SP Transition Emission Scaler", Range(1, 100)) = 1
_SPTransitionBloomFactor ("SP Transition Bloom Factor", Float) = 1
_SPCubeMap ("SP CubeMap", Cube) = "white" { }
_SPCubeMapColor ("SP CubeMap Color", Color) = (1,1,1,0)
_SPCubeMapOffset ("SP CubeMap Offset", Vector) = (0,0,0,0)
_SPCubeMapIntensity ("SP CubeMap Intensity", Range(0, 1)) = 0
_SPCubeMapNoiseIntensity ("SP CubeMap Noise Intensity", Range(0, 5)) = 0
_SPCubeMapBrightness ("SP CubeMap Brightness", Float) = 1.26
_SPOldColor ("SP Old Color", Color) = (1,1,1,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "TWO_SIDE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 43802
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_18.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_18.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_18.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (vertex_13 * 0.5);
  spuvs_18.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19.x + (tmpvar_19.z * tmpvar_19.z));
  tmpvar_20.y = ((tmpvar_19.y + (0.5 * tmpvar_19.z)) + ((0.5 * tmpvar_19.x) * tmpvar_19.x));
  spuvs_18.zw = ((tmpvar_20 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_21.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_18;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (vertex_13 * 0.5);
  spuvs_18.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19.x + (tmpvar_19.z * tmpvar_19.z));
  tmpvar_20.y = ((tmpvar_19.y + (0.5 * tmpvar_19.z)) + ((0.5 * tmpvar_19.x) * tmpvar_19.x));
  spuvs_18.zw = ((tmpvar_20 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_21.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_18;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPTex_ST;
uniform highp vec4 _SPNoiseTex_ST;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_TEXCOORD5;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_7.y = 0.0;
  highp vec4 tmpvar_8;
  tmpvar_8 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_5 = (tmpvar_8.xyz / tmpvar_8.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesNormal));
  tmpvar_4 = tmpvar_10;
  mediump vec3 L_11;
  L_11 = _WorldSpaceLightPos0.xyz;
  tmpvar_7.x = ((dot (tmpvar_4, L_11) * 0.4975) + 0.5);
  alpha_2 = mix (1.0, _glesColor.w, _VertexAlphaFactor);
  highp float alpha_12;
  alpha_12 = alpha_2;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = alpha_12;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_7.y = (alpha_2 * _Opaqueness);
  highp vec4 spuvs_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (vertex_13 * 0.5);
  spuvs_18.xy = ((_glesMultiTexCoord0.xy * _SPTex_ST.xy) + _SPTex_ST.zw);
  highp vec2 tmpvar_20;
  tmpvar_20.x = (tmpvar_19.x + (tmpvar_19.z * tmpvar_19.z));
  tmpvar_20.y = ((tmpvar_19.y + (0.5 * tmpvar_19.z)) + ((0.5 * tmpvar_19.x) * tmpvar_19.x));
  spuvs_18.zw = ((tmpvar_20 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_21;
    highp vec4 tmpvar_22;
    tmpvar_22 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_23;
    tmpvar_23.x = tmpvar_22.x;
    tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
    o_21.xy = (tmpvar_23 + tmpvar_22.w);
    o_21.zw = tmpvar_16.zw;
    tmpvar_6.xyw = o_21.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = spuvs_18;
  xlv_TEXCOORD5 = vec2(0.0, 0.0);
  xlv_COLOR1 = tmpvar_7;
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
}
}
 Pass {
  Name "CONSTANT_MAX"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 95931
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD2 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
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
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
    tmpvar_7 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
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
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
    tmpvar_7 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
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
uniform highp vec4 _MainTex_ST;
uniform highp float _UsingBloomMask;
uniform highp vec4 _BloomMaskTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  if (bool(_UsingBloomMask)) {
    tmpvar_2 = ((_glesMultiTexCoord0.xy * _BloomMaskTex_ST.xy) + _BloomMaskTex_ST.zw);
  };
  highp vec4 tmpvar_5;
  tmpvar_5 = (_glesVertex * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (tmpvar_5.x + (tmpvar_5.z * tmpvar_5.z));
  tmpvar_6.y = ((tmpvar_5.y + (0.5 * tmpvar_5.z)) + ((0.5 * tmpvar_5.x) * tmpvar_5.x));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((tmpvar_6 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  xlv_TEXCOORD2 = tmpvar_2;
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
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = _BloomFactor;
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
    tmpvar_7 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
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
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.PropShaderEditorBase"
}