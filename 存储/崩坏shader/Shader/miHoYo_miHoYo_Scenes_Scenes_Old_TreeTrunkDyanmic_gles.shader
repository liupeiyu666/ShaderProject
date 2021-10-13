//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/TreeTrunkDyanmic" {
Properties {
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_BendScale ("BendScale", Range(0, 0.1)) = 0.01
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  Name "BASE"
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 29082
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
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
uniform highp vec4 _miHoYo_Wind;
uniform mediump vec4 _MainTex_ST;
uniform highp float _BendScale;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec3 vPos_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  mediump vec2 tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * vec4(0.0, 0.0, 0.0, 1.0)).xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  vPos_1 = (tmpvar_6.xyz - tmpvar_5);
  highp vec3 vNewPos_7;
  highp float fBF_8;
  fBF_8 = ((vPos_1.y * _BendScale) + 1.0);
  fBF_8 = (fBF_8 * fBF_8);
  fBF_8 = ((fBF_8 * fBF_8) - fBF_8);
  vNewPos_7.y = vPos_1.y;
  vNewPos_7.xz = (vPos_1.xz + (_miHoYo_Wind.xz * fBF_8));
  vPos_1 = ((normalize(vNewPos_7) * sqrt(
    dot (vPos_1, vPos_1)
  )) + tmpvar_5);
  highp vec4 tmpvar_9;
  tmpvar_9.xyz = vPos_1;
  tmpvar_9.w = tmpvar_6.w;
  tmpvar_2 = (unity_MatrixVP * tmpvar_9);
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_3 = _glesColor;
  mediump vec4 tmpvar_10;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_11;
    highp vec3 tmpvar_12;
    tmpvar_12 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_13;
    tmpvar_13 = max (0.0, (sqrt(
      dot (tmpvar_12, tmpvar_12)
    ) - _FogStartDistance));
    highp float tmpvar_14;
    tmpvar_14 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_13)
      ) * (_FogIntensity * tmpvar_13))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_15;
    tmpvar_15 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_13)) * (_FogColorIntensity * tmpvar_13))
    ), 0.0, 1.0)));
    fogColor_11.xyz = tmpvar_15;
    fogColor_11.w = tmpvar_14;
    tmpvar_10 = fogColor_11;
  } else {
    mediump vec4 fogColor_16;
    highp vec3 tmpvar_17;
    tmpvar_17 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_18;
    tmpvar_18 = max (0.0, (sqrt(
      dot (tmpvar_17, tmpvar_17)
    ) - _FogStartDistance));
    highp float tmpvar_19;
    highp float tmpvar_20;
    tmpvar_20 = (_FogEndDistance - _FogStartDistance);
    tmpvar_19 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_21;
    tmpvar_21 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_18) / max (0.1, tmpvar_20))
    , 0.0, 1.0))));
    fogColor_16.xyz = tmpvar_21;
    fogColor_16.w = tmpvar_19;
    tmpvar_10 = fogColor_16;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR0 = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_COLOR1 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 tex_C_Color_1;
  mediump vec4 outColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_C_Color_1 = tmpvar_3;
  outColor_2 = (tex_C_Color_1 * xlv_COLOR0);
  outColor_2.xyz = mix (outColor_2.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  outColor_2.w = _BloomFactor;
  outColor_2.xyz = mix (outColor_2.xyz, vec3(dot (outColor_2.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = outColor_2;
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
}
}
}
Fallback "Diffuse"
}