//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Sheet_Anm" {
Properties {
_MainColor ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Environment Color", Color) = (1,1,1,1)
_Color ("Main Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
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
_Shininess ("Specular Shininess", Range(0, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_ClipPlane ("Clip Plane", Vector) = (0,0,0,0)
_FadeDistance ("Fade Start Distance", Range(0.1, 10)) = 0.5
_FadeOffset ("Fade Start Offset", Range(0, 10)) = 1
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 24385
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_5, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _frameInterpolationFactor;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
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
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_3, tmpvar_5, vec4(_frameInterpolationFactor));
  mediump vec3 baseColor_7;
  baseColor_7 = tmpvar_6.xyz;
  mediump vec3 diffColor_8;
  diffColor_8 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_8 = (tmpvar_6.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_8 = baseColor_7;
  };
  mediump vec3 position_9;
  position_9 = xlv_TEXCOORD3;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_9));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((mix (
    (diffColor_8 * _EnvColor.xyz)
  , 
    ((tmpvar_6.xyz * _EmissionTintColor.xyz) * _EmissionScaler)
  , vec3(
    mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle)
  )) * _MainColor.xyz) + ((_LightSpecColor * _SpecMulti) * max (0.0, 
    pow (max (dot (xlv_TEXCOORD2, xlat_mutableH), 0.001), _Shininess)
  )));
  outColor_1.w = xlv_COLOR1.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD4;
    mediump float a_14;
    a_14 = xlv_TEXCOORD4.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_5, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _frameInterpolationFactor;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
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
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_3, tmpvar_5, vec4(_frameInterpolationFactor));
  mediump vec3 baseColor_7;
  baseColor_7 = tmpvar_6.xyz;
  mediump vec3 diffColor_8;
  diffColor_8 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_8 = (tmpvar_6.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_8 = baseColor_7;
  };
  mediump vec3 position_9;
  position_9 = xlv_TEXCOORD3;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_9));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((mix (
    (diffColor_8 * _EnvColor.xyz)
  , 
    ((tmpvar_6.xyz * _EmissionTintColor.xyz) * _EmissionScaler)
  , vec3(
    mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle)
  )) * _MainColor.xyz) + ((_LightSpecColor * _SpecMulti) * max (0.0, 
    pow (max (dot (xlv_TEXCOORD2, xlat_mutableH), 0.001), _Shininess)
  )));
  outColor_1.w = xlv_COLOR1.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD4;
    mediump float a_14;
    a_14 = xlv_TEXCOORD4.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _nextFrameOffset;
uniform highp vec4 _MainTex_ST;
uniform mediump float _Opaqueness;
uniform highp vec4 _ClipPlane;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump float alpha_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8.y = 0.0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_9.xyz / tmpvar_9.w);
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_4 = (tmpvar_3 + _nextFrameOffset);
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesNormal));
  tmpvar_5 = tmpvar_11;
  mediump vec3 L_12;
  L_12 = _WorldSpaceLightPos0.xyz;
  tmpvar_8.x = ((dot (tmpvar_5, L_12) * 0.4975) + 0.5);
  alpha_2 = 1.0;
  highp vec4 vertex_13;
  vertex_13 = tmpvar_1;
  highp float tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_15 < (_ClipPlane.w - 0.01))) {
    vertex_13.xyz = (_glesVertex.xyz - ((tmpvar_15 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_14 = 0.0;
  } else {
    tmpvar_14 = 1.0;
  };
  tmpvar_1 = vertex_13;
  alpha_2 = tmpvar_14;
  tmpvar_8.y = (alpha_2 * _Opaqueness);
  highp vec4 tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = vertex_13.xyz;
  tmpvar_16 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_18;
    highp vec4 tmpvar_19;
    tmpvar_19 = (tmpvar_16 * 0.5);
    highp vec2 tmpvar_20;
    tmpvar_20.x = tmpvar_19.x;
    tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
    o_18.xy = (tmpvar_20 + tmpvar_19.w);
    o_18.zw = tmpvar_16.zw;
    tmpvar_7.xyw = o_18.xyw;
    tmpvar_7.z = _DitherAlpha;
  };
  gl_Position = tmpvar_16;
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_4;
  xlv_TEXCOORD2 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_COLOR1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ScreenParams;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 _DITHERMATRIX;
uniform mediump float _frameInterpolationFactor;
uniform mediump vec4 _MainColor;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
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
uniform mediump vec3 V;
uniform mediump vec3 H;
mediump vec3 xlat_mutableH;
mediump vec3 xlat_mutableV;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec2 xlv_COLOR1;
void main ()
{
  xlat_mutableH = H;
  xlat_mutableV = V;
  mediump vec4 outColor_1;
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = tmpvar_2;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1);
  mediump vec4 tmpvar_5;
  tmpvar_5 = tmpvar_4;
  mediump vec4 tmpvar_6;
  tmpvar_6 = mix (tmpvar_3, tmpvar_5, vec4(_frameInterpolationFactor));
  mediump vec3 baseColor_7;
  baseColor_7 = tmpvar_6.xyz;
  mediump vec3 diffColor_8;
  diffColor_8 = vec3(1.0, 1.0, 1.0);
  if ((xlv_COLOR1.x < _LightArea)) {
    diffColor_8 = (tmpvar_6.xyz * _ShadowMultColor.xyz);
  } else {
    diffColor_8 = baseColor_7;
  };
  mediump vec3 position_9;
  position_9 = xlv_TEXCOORD3;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - position_9));
  xlat_mutableV = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz + xlat_mutableV));
  xlat_mutableH = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, xlv_TEXCOORD0);
  outColor_1.xyz = ((mix (
    (diffColor_8 * _EnvColor.xyz)
  , 
    ((tmpvar_6.xyz * _EmissionTintColor.xyz) * _EmissionScaler)
  , vec3(
    mix (_EmissionFactor, tmpvar_12.w, _EmissionFactorFromTexToggle)
  )) * _MainColor.xyz) + ((_LightSpecColor * _SpecMulti) * max (0.0, 
    pow (max (dot (xlv_TEXCOORD2, xlat_mutableH), 0.001), _Shininess)
  )));
  outColor_1.w = xlv_COLOR1.y;
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_13;
    scrpos_13 = xlv_TEXCOORD4;
    mediump float a_14;
    a_14 = xlv_TEXCOORD4.z;
    if ((a_14 < 0.95)) {
      scrpos_13.xy = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) * _ScreenParams.xy);
      a_14 = (a_14 * 17.0);
      highp float tmpvar_15;
      tmpvar_15 = (scrpos_13.y / 4.0);
      highp float tmpvar_16;
      tmpvar_16 = (fract(abs(tmpvar_15)) * 4.0);
      highp float tmpvar_17;
      if ((tmpvar_15 >= 0.0)) {
        tmpvar_17 = tmpvar_16;
      } else {
        tmpvar_17 = -(tmpvar_16);
      };
      highp float tmpvar_18;
      tmpvar_18 = (scrpos_13.x / 4.0);
      highp float tmpvar_19;
      tmpvar_19 = (fract(abs(tmpvar_18)) * 4.0);
      highp float tmpvar_20;
      if ((tmpvar_18 >= 0.0)) {
        tmpvar_20 = tmpvar_19;
      } else {
        tmpvar_20 = -(tmpvar_19);
      };
      highp float x_21;
      x_21 = ((a_14 - _DITHERMATRIX[
        int(tmpvar_17)
      ][
        int(tmpvar_20)
      ]) - 0.01);
      if ((x_21 < 0.0)) {
        discard;
      };
    };
  };
  outColor_1.w = clamp (xlv_COLOR1.y, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
  Name "FROM_TEX_CLIPPLANE"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 125259
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
}
}