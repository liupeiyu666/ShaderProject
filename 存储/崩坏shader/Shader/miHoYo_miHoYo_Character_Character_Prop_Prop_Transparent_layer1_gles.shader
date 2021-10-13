//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Transparent_layer1" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_OpaquenessFromTexToggle ("Opaqueness From Tex Toggle", Range(0, 1)) = 0
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_EmissionTintColor ("Emission Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(1, 10)) = 1
_EmissionFactor ("Emission Factor (lerp factor between original and emission color)", Range(0, 1)) = 0
_EmissionFactorFromTexToggle ("Emission Factor From Tex Toggle", Range(0, 1)) = 0
_EmissionBloomFactor ("Emission Bloom Factor", Float) = 1
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_ShadowMultColor ("Shadow Multiply Color", Color) = (1,1,1,1)
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
_SPTransitionColor ("SP Transition Color", Color) = (1,1,1,1)
_SPOpaqueness ("SP Opaqueness", Range(0, 1)) = 1
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 14095
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
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
}
}
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 83683
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_15;
    scrpos_15 = xlv_TEXCOORD3;
    mediump float a_16;
    a_16 = xlv_TEXCOORD3.z;
    if ((a_16 < 0.95)) {
      scrpos_15.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_16 = (a_16 * 17.0);
      highp float tmpvar_17;
      tmpvar_17 = (scrpos_15.y / 4.0);
      highp float tmpvar_18;
      tmpvar_18 = (fract(abs(tmpvar_17)) * 4.0);
      highp float tmpvar_19;
      if ((tmpvar_17 >= 0.0)) {
        tmpvar_19 = tmpvar_18;
      } else {
        tmpvar_19 = -(tmpvar_18);
      };
      highp float tmpvar_20;
      tmpvar_20 = (scrpos_15.x / 4.0);
      highp float tmpvar_21;
      tmpvar_21 = (fract(abs(tmpvar_20)) * 4.0);
      highp float tmpvar_22;
      if ((tmpvar_20 >= 0.0)) {
        tmpvar_22 = tmpvar_21;
      } else {
        tmpvar_22 = -(tmpvar_21);
      };
      highp float x_23;
      x_23 = ((a_16 - _DITHERMATRIX[
        int(tmpvar_19)
      ][
        int(tmpvar_22)
      ]) - 0.01);
      if ((x_23 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (outColor_3.w, 0.0, 1.0);
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  mediump float intensity_15;
  mediump vec4 spColor_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_16 = tmpvar_17;
  spColor_16.w = (spColor_16.w * _SPOpaqueness);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_19;
  tmpvar_19 = (((1.99 * tmpvar_18.x) * _SPNoiseScaler) - 1.0);
  intensity_15 = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_15 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_15 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_20;
      tmpvar_20 = mix (spColor_16.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_15) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_16.xyz = tmpvar_20;
    };
  };
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (outColor_3, spColor_16, vec4(xlat_mutable_SPIntensity));
  spColor_16 = tmpvar_21;
  outColor_3 = spColor_16;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD3;
    mediump float a_23;
    a_23 = xlv_TEXCOORD3.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (spColor_16.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  mediump float intensity_15;
  mediump vec4 spColor_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_16 = tmpvar_17;
  spColor_16.w = (spColor_16.w * _SPOpaqueness);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_19;
  tmpvar_19 = (((1.99 * tmpvar_18.x) * _SPNoiseScaler) - 1.0);
  intensity_15 = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_15 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_15 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_20;
      tmpvar_20 = mix (spColor_16.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_15) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_16.xyz = tmpvar_20;
    };
  };
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (outColor_3, spColor_16, vec4(xlat_mutable_SPIntensity));
  spColor_16 = tmpvar_21;
  outColor_3 = spColor_16;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD3;
    mediump float a_23;
    a_23 = xlv_TEXCOORD3.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (spColor_16.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
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
uniform mediump float _OpaquenessFromTexToggle;
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
  mediump vec4 baseTexColor_2;
  mediump vec4 outColor_3;
  outColor_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  baseTexColor_2 = tmpvar_4;
  mediump vec3 baseColor_5;
  baseColor_5 = baseTexColor_2.xyz;
  mediump vec3 diffColor_6;
  diffColor_6 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_6 = (baseTexColor_2.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_6 = baseColor_5;
  };
  mediump vec3 tmpvar_7;
  tmpvar_7 = ((baseTexColor_2.xyz * _EmissionTintColor.xyz) * _EmissionScaler);
  mediump vec3 position_8;
  position_8 = xlv_TEXCOORD2;
  mediump vec3 specColor_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_8));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  specColor_9 = ((_LightSpecColor * _SpecMulti) * max (0.0, pow (
    max (dot (xlv_TEXCOORD1, xlat_mutableH), 0.001)
  , _Shininess)));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump float tmpvar_13;
  tmpvar_13 = mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle);
  emissionFactor_1 = tmpvar_13;
  if (bool(_UsingBloomMask)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_BloomMaskTex, xlv_TEXCOORD5);
    emissionFactor_1 = (tmpvar_13 * tmpvar_14.x);
  };
  outColor_3.xyz = ((mix (
    (diffColor_6 * _EnvColor.xyz)
  , tmpvar_7, vec3(emissionFactor_1)) * _MainColor.xyz) + specColor_9);
  outColor_3.w = (mix (1.0, baseTexColor_2.w, _OpaquenessFromTexToggle) * xlv_COLOR1.y);
  mediump float intensity_15;
  mediump vec4 spColor_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_SPTex, xlv_TEXCOORD4.xy);
  spColor_16 = tmpvar_17;
  spColor_16.w = (spColor_16.w * _SPOpaqueness);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_SPNoiseTex, xlv_TEXCOORD4.zw);
  highp float tmpvar_19;
  tmpvar_19 = (((1.99 * tmpvar_18.x) * _SPNoiseScaler) - 1.0);
  intensity_15 = tmpvar_19;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_15 >= (1.7 * xlat_mutable_SPTransition))) {
    xlat_mutable_SPIntensity = 0.0;
  } else {
    if ((intensity_15 >= (1.5 * xlat_mutable_SPTransition))) {
      highp vec3 tmpvar_20;
      tmpvar_20 = mix (spColor_16.xyz, (_SPTransitionColor.xyz * _SPTransitionEmissionScaler), vec3(clamp ((10.0 * 
        (-(intensity_15) + (1.7 * xlat_mutable_SPTransition))
      ), 0.0, 1.0)));
      spColor_16.xyz = tmpvar_20;
    };
  };
  highp vec4 tmpvar_21;
  tmpvar_21 = mix (outColor_3, spColor_16, vec4(xlat_mutable_SPIntensity));
  spColor_16 = tmpvar_21;
  outColor_3 = spColor_16;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_22;
    scrpos_22 = xlv_TEXCOORD3;
    mediump float a_23;
    a_23 = xlv_TEXCOORD3.z;
    if ((a_23 < 0.95)) {
      scrpos_22.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_23 = (a_23 * 17.0);
      highp float tmpvar_24;
      tmpvar_24 = (scrpos_22.y / 4.0);
      highp float tmpvar_25;
      tmpvar_25 = (fract(abs(tmpvar_24)) * 4.0);
      highp float tmpvar_26;
      if ((tmpvar_24 >= 0.0)) {
        tmpvar_26 = tmpvar_25;
      } else {
        tmpvar_26 = -(tmpvar_25);
      };
      highp float tmpvar_27;
      tmpvar_27 = (scrpos_22.x / 4.0);
      highp float tmpvar_28;
      tmpvar_28 = (fract(abs(tmpvar_27)) * 4.0);
      highp float tmpvar_29;
      if ((tmpvar_27 >= 0.0)) {
        tmpvar_29 = tmpvar_28;
      } else {
        tmpvar_29 = -(tmpvar_28);
      };
      highp float x_30;
      x_30 = ((a_23 - _DITHERMATRIX[
        int(tmpvar_26)
      ][
        int(tmpvar_29)
      ]) - 0.01);
      if ((x_30 < 0.0)) {
        discard;
      };
    };
  };
  outColor_3.w = clamp (spColor_16.w, 0.0, 1.0);
  gl_FragData[0] = outColor_3;
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
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 156809
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
CustomEditor "MoleMole.PropShaderEditorBase"
}