//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/BoxEffect_Texture" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (0,0,0,0)
_MainMaskTexture ("MainMaskTexture", 2D) = "white" { }
_MainMaskTexture2 ("MainMaskTexture2", 2D) = "white" { }
_MaskOffset ("MaskOffset", Vector) = (0,1,0,0)
_MaskOffset2 ("MaskOffset2", Vector) = (0,1,0,0)
_MaskSpeed ("MaskSpeed", Vector) = (0,0,0,0)
_BoxColor ("BoxColor", Color) = (0,0,0,0)
_BoxColorIndensity ("BoxColorIndensity", Float) = 0
_BoxSideColor ("BoxSideColor", Color) = (0,0,0,0)
_SideColorIndensity ("SideColorIndensity", Float) = 0
_SmothStep ("SmothStep", Vector) = (0.11,-0.5,0.1,0)
_EdgeTexture ("EdgeTexture", 2D) = "white" { }
_EdgeColor ("EdgeColor", Color) = (0,0,0,0)
_EdgeIndensity ("EdgeIndensity", Float) = 0
_texcoord2 ("", 2D) = "white" { }
_ReflectionStrength ("Reflection Strength", Range(0, 2)) = 1
_RefractTex ("Refraction Texture", Cube) = "" { }
_FogTune ("Fog Tune", Range(0, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 36960
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _FogEffectLimit;
uniform highp float _FogStartDistance;
uniform highp float _FogEndDistance;
uniform highp vec3 _MaskOffset;
uniform highp vec3 _MaskOffset2;
uniform sampler2D _MainMaskTexture2;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform mediump float _FogTune;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.zw = vec2(0.0, 0.0);
  tmpvar_9.x = _MaskSpeed.z;
  tmpvar_9.y = _MaskSpeed.w;
  highp vec4 tmpvar_10;
  tmpvar_10.zw = vec2(0.0, 0.0);
  tmpvar_10.xy = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp float x_11;
  x_11 = (1.0 - texture2DLod (_MainMaskTexture, tmpvar_10.xy, 0.0).x);
  highp float tmpvar_12;
  tmpvar_12 = clamp (((x_11 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  tmpvar_7.xyz = normalize((_glesNormal * tmpvar_13));
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_14;
  tmpvar_14.zw = vec2(0.0, 0.0);
  tmpvar_14.xy = ((_Time.y * (tmpvar_9 * vec4(0.1, 0.1, 0.1, 0.1)).xy) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DLod (_MainMaskTexture2, tmpvar_14.xy, 0.0);
  highp vec4 tmpvar_16;
  tmpvar_16.w = 0.0;
  tmpvar_16.xyz = ((_MaskOffset * 0.01) * (_MaskOffset2 * tmpvar_15.x));
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_16 * (
    (tmpvar_12 * (tmpvar_12 * (3.0 - (2.0 * tmpvar_12))))
   * _glesColor)).xyz);
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_17));
  tmpvar_3 = _glesColor;
  tmpvar_4 = _glesMultiTexCoord0;
  tmpvar_5 = _glesMultiTexCoord1;
  tmpvar_6 = _glesMultiTexCoord2;
  tmpvar_8 = (unity_ObjectToWorld * tmpvar_1);
  highp float fogTune_18;
  fogTune_18 = _FogTune;
  mediump vec4 tmpvar_19;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_20;
    highp vec3 tmpvar_21;
    tmpvar_21 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_22;
    tmpvar_22 = max (0.0, (sqrt(
      dot (tmpvar_21, tmpvar_21)
    ) - _FogStartDistance));
    highp float tmpvar_23;
    tmpvar_23 = min (max ((
      (1.0 - exp(((
        -((_FogIntensity * tmpvar_22))
       * 
        (_FogIntensity * tmpvar_22)
      ) * fogTune_18)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_24;
    tmpvar_24 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_22)) * (_FogColorIntensity * tmpvar_22))
    ), 0.0, 1.0)));
    fogColor_20.xyz = tmpvar_24;
    fogColor_20.w = tmpvar_23;
    tmpvar_19 = fogColor_20;
  } else {
    mediump vec4 fogColor_25;
    highp vec3 tmpvar_26;
    tmpvar_26 = ((unity_ObjectToWorld * tmpvar_1).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_27;
    tmpvar_27 = max (0.0, (sqrt(
      dot (tmpvar_26, tmpvar_26)
    ) - _FogStartDistance));
    highp float tmpvar_28;
    tmpvar_28 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
     * _FogEffectLimit), (_FogEffectStart * fogTune_18)), _FogEffectLimit);
    highp vec3 tmpvar_29;
    tmpvar_29 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_27) / max (0.1, ((_FogEndDistance * fogTune_18) - _FogStartDistance)))
    , 0.0, 1.0))));
    fogColor_25.xyz = tmpvar_29;
    fogColor_25.w = tmpvar_28;
    tmpvar_19 = fogColor_25;
  };
  gl_Position = tmpvar_2;
  xlv_COLOR = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = tmpvar_7;
  xlv_TEXCOORD4 = tmpvar_8;
  xlv_COLOR1 = tmpvar_19;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _MaskSpeed;
uniform highp vec4 _SmothStep;
uniform sampler2D _MainMaskTexture;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform sampler2D _EdgeTexture;
uniform highp vec4 _EdgeTexture_ST;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeIndensity;
uniform highp vec4 _BoxSideColor;
uniform highp float _SideColorIndensity;
uniform highp vec4 _BoxColor;
uniform highp float _BoxColorIndensity;
uniform lowp samplerCube _RefractTex;
uniform mediump float _ReflectionStrength;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump vec3 reflection_2;
  mediump vec3 R_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((xlv_TEXCOORD1.xy * _EdgeTexture_ST.xy) + _EdgeTexture_ST.zw);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_Time.y * (_MaskSpeed * vec4(0.1, 0.1, 0.1, 0.1)).xy) + xlv_TEXCOORD0.xy);
  highp float tmpvar_7;
  lowp float x_8;
  x_8 = (1.0 - texture2D (_MainMaskTexture, tmpvar_6).x);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((x_8 - _SmothStep.x) / (_SmothStep.y - _SmothStep.x)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_9 * (tmpvar_9 * (3.0 - 
    (2.0 * tmpvar_9)
  )));
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD3.xyz);
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((xlv_TEXCOORD4.xyz - _WorldSpaceCameraPos));
  highp vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_11 - (2.0 * (
    dot (xlv_TEXCOORD3.xyz, tmpvar_11)
   * xlv_TEXCOORD3.xyz)));
  R_3 = tmpvar_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = textureCube (_RefractTex, R_3).xyz;
  reflection_2 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTexture, tmpvar_4);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_EdgeTexture, tmpvar_5);
  highp vec3 tmpvar_16;
  tmpvar_16 = (((
    (tmpvar_14 * _MainColor)
   + 
    ((tmpvar_15 * _EdgeColor) * _EdgeIndensity)
  ) + (
    ((((_BoxSideColor * 
      abs(tmpvar_10.x)
    ) + (
      abs(tmpvar_10.z)
     * _BoxSideColor)) * tmpvar_7) * _SideColorIndensity)
   + 
    ((tmpvar_7 * _BoxColor) * _BoxColorIndensity)
  )).xyz + (reflection_2 * _ReflectionStrength));
  aseOutColor_1 = tmpvar_16;
  aseOutColor_1 = mix (aseOutColor_1, xlv_COLOR1.xyz, xlv_COLOR1.www);
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = 1.0;
  gl_FragData[0] = tmpvar_17;
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
CustomEditor "ASEMaterialInspector"
}