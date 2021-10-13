//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Bamboo (wind)" {
Properties {
_MayaScale ("Scale Compared to Maya", Float) = 0.01
_Scale ("Scale", Float) = 1
_MainTex ("Color Tex (RGB)", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_BottomColor ("Bottom Color", Color) = (1,1,1,1)
_MiddleColor ("Middle Color", Color) = (1,1,1,1)
_MiddleColorPosition ("Middle Color Position", Range(0.01, 0.99)) = 0.5
_TopColor ("Top Color", Color) = (1,1,1,1)
_Width ("Width", Range(0.0001, 1)) = 0.0001
_Ambient ("Ambient", Range(0.01, 10)) = 1
_AmbientRimIndex ("Ambient Rim Index", Range(0.01, 100)) = 10
_AmbientRimScale ("Ambient Rim Scale", Range(0.01, 10)) = 0
_Diffuse ("Diffuse", Range(0.01, 10)) = 1
_Specular ("Specular", Range(0.01, 10)) = 1
_Shininess ("Shininess", Range(0.01, 100)) = 10
_SpecularColor ("Specular Color", Color) = (1,1,1,1)
_LightDir ("Light Dir", Vector) = (0,0,1,0)
_LightUp ("Light Up", Vector) = (0,1,0,0)
_LightRight ("Light Right", Vector) = (1,0,0,0)
_ShadowTex ("Shadow Tex (R)", 2D) = "white" { }
_WindDirection ("Wind Direction", Vector) = (1,0,0,0)
_BendIntensity ("Bend InTensity", Range(0, 1)) = 0
_BendSpeed ("Bend Speed", Range(0, 1)) = 0
_BendVariance ("Bend Variance", Float) = 1
_SideBend ("Side Bend", Range(0, 10)) = 0
_Gust ("Gust", Float) = 1
_GlobalSpeed ("Global Speed", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "QUEUE" = "Geometry" "RenderType" = "Opaque" }
  GpuProgramID 57559
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixV;
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
uniform highp vec4 _miHoYo_WindParams1;
uniform highp float _Scale;
uniform highp float _MayaScale;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec3 _BottomColor;
uniform mediump vec3 _MiddleColor;
uniform mediump float _MiddleColorPosition;
uniform mediump vec3 _TopColor;
uniform highp float _Width;
uniform highp vec4 _LightDir;
uniform highp vec4 _LightUp;
uniform highp vec4 _LightRight;
uniform mediump vec4 _ShadowTex_ST;
uniform highp vec3 _WindDirection;
uniform highp float _BendIntensity;
uniform highp float _BendSpeed;
uniform highp float _BendVariance;
uniform highp float _SideBend;
uniform highp float _Gust;
uniform highp float _GlobalSpeed;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float t_2;
  mediump vec3 toColor_3;
  mediump vec3 fromColor_4;
  highp vec4 posInW_5;
  highp float dirSign_6;
  highp vec4 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec2 tmpvar_9;
  mediump vec2 tmpvar_10;
  highp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_7 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_8 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = vec2(0.0, 0.0);
  tmpvar_11 = vec3(0.0, 0.0, 0.0);
  tmpvar_12 = vec3(0.0, 0.0, 0.0);
  tmpvar_9 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump float tmpvar_13;
  tmpvar_13 = ((_glesMultiTexCoord0.x * 2.0) - 1.0);
  dirSign_6 = tmpvar_13;
  highp vec4 v_14;
  v_14.x = unity_MatrixV[0].z;
  v_14.y = unity_MatrixV[1].z;
  v_14.z = unity_MatrixV[2].z;
  v_14.w = unity_MatrixV[3].z;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(v_14.xyz);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesNormal);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(((tmpvar_15.yzx * tmpvar_17.zxy) - (tmpvar_15.zxy * tmpvar_17.yzx)));
  highp vec3 tmpvar_19;
  tmpvar_19 = (_glesVertex.xyz + ((_glesTANGENT.xyz * _glesMultiTexCoord1.y) * 0.01));
  highp float wavesIn_20;
  highp vec4 posInW_21;
  highp vec3 tmpvar_22;
  if (bool(_miHoYo_WindParams1.y)) {
    tmpvar_22 = _WindDirection;
  } else {
    tmpvar_22 = _miHoYo_Wind.xyz;
  };
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_ObjectToWorld * _glesVertex);
  posInW_21.w = tmpvar_23.w;
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = tmpvar_19;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_ObjectToWorld * tmpvar_24).xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = (tmpvar_23.xyz - tmpvar_25);
  highp float tmpvar_27;
  tmpvar_27 = sqrt(dot (tmpvar_26, tmpvar_26));
  wavesIn_20 = (((
    (_miHoYo_Wind.w * mix (1.0, _miHoYo_WindParams1.z, _GlobalSpeed))
   + 
    (_miHoYo_WindParams1.w * _GlobalSpeed)
  ) * _BendSpeed) + (dot (tmpvar_25, vec3(1.0, 1.0, 1.0)) * _BendVariance));
  highp vec4 tmpvar_28;
  tmpvar_28 = abs(((
    fract((((
      fract((wavesIn_20 * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  posInW_21.xyz = (tmpvar_23.xyz + ((
    ((normalize(tmpvar_22) * (dot (
      (((tmpvar_28 * tmpvar_28) * (3.0 - (2.0 * tmpvar_28))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0)) + (_miHoYo_WindParams1.x * _Gust))) * (tmpvar_27 * tmpvar_27))
   * _BendIntensity) * 0.01));
  highp vec4 tmpvar_29;
  tmpvar_29 = abs(((
    fract((((
      fract(((wavesIn_20 - 0.5) * vec4(1.975, 0.793, 0.375, 0.193)))
     * 2.0) - 1.0) + 0.5))
   * 2.0) - 1.0));
  highp vec3 tmpvar_30;
  tmpvar_30.y = 0.0;
  tmpvar_30.x = -(tmpvar_22.z);
  tmpvar_30.z = tmpvar_22.x;
  posInW_21.xyz = (posInW_21.xyz + ((
    (((normalize(tmpvar_30) * dot (
      (((tmpvar_29 * tmpvar_29) * (3.0 - (2.0 * tmpvar_29))) - 0.5)
    , vec4(1.0, 1.0, 1.0, 1.0))) * tmpvar_27) * _BendIntensity)
   * 0.01) * _SideBend));
  posInW_5.w = posInW_21.w;
  posInW_5.xyz = (posInW_21.xyz + ((
    (((dirSign_6 * _Width) * _MayaScale) * tmpvar_18)
   * _glesColor.x) * _Scale));
  tmpvar_7 = (unity_MatrixVP * posInW_5);
  tmpvar_11 = -(tmpvar_15);
  tmpvar_12 = normalize((tmpvar_11 + _LightDir.xyz));
  highp float tmpvar_31;
  tmpvar_31 = tmpvar_1.y;
  t_2 = tmpvar_31;
  if ((t_2 < _MiddleColorPosition)) {
    fromColor_4 = _BottomColor;
    toColor_3 = _MiddleColor;
    t_2 = (t_2 / _MiddleColorPosition);
  } else {
    fromColor_4 = _MiddleColor;
    toColor_3 = _TopColor;
    t_2 = ((t_2 - _MiddleColorPosition) / (1.0 - _MiddleColorPosition));
  };
  tmpvar_8 = mix (fromColor_4, toColor_3, vec3(t_2));
  highp mat4 tmpvar_32;
  tmpvar_32[0].x = _LightRight.x;
  tmpvar_32[0].y = _LightUp.x;
  tmpvar_32[0].z = _LightDir.x;
  tmpvar_32[0].w = 0.0;
  tmpvar_32[1].x = _LightRight.y;
  tmpvar_32[1].y = _LightUp.y;
  tmpvar_32[1].z = _LightDir.y;
  tmpvar_32[1].w = 0.0;
  tmpvar_32[2].x = _LightRight.z;
  tmpvar_32[2].y = _LightUp.z;
  tmpvar_32[2].z = _LightDir.z;
  tmpvar_32[2].w = 0.0;
  tmpvar_32[3].x = _LightRight.w;
  tmpvar_32[3].y = _LightUp.w;
  tmpvar_32[3].z = _LightDir.w;
  tmpvar_32[3].w = 1.0;
  tmpvar_10 = (tmpvar_32 * posInW_5).xy;
  tmpvar_10 = ((tmpvar_10 * _ShadowTex_ST.xy) + _ShadowTex_ST.zw);
  mediump vec4 tmpvar_33;
  if ((_FogColorNear.w > 0.5)) {
    mediump vec4 fogColor_34;
    highp vec3 tmpvar_35;
    tmpvar_35 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_36;
    tmpvar_36 = max (0.0, (sqrt(
      dot (tmpvar_35, tmpvar_35)
    ) - _FogStartDistance));
    highp float tmpvar_37;
    tmpvar_37 = min (max ((
      (1.0 - exp((-(
        (_FogIntensity * tmpvar_36)
      ) * (_FogIntensity * tmpvar_36))))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_38;
    tmpvar_38 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
      (-((_FogColorIntensity * tmpvar_36)) * (_FogColorIntensity * tmpvar_36))
    ), 0.0, 1.0)));
    fogColor_34.xyz = tmpvar_38;
    fogColor_34.w = tmpvar_37;
    tmpvar_33 = fogColor_34;
  } else {
    mediump vec4 fogColor_39;
    highp vec3 tmpvar_40;
    tmpvar_40 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
    highp float tmpvar_41;
    tmpvar_41 = max (0.0, (sqrt(
      dot (tmpvar_40, tmpvar_40)
    ) - _FogStartDistance));
    highp float tmpvar_42;
    highp float tmpvar_43;
    tmpvar_43 = (_FogEndDistance - _FogStartDistance);
    tmpvar_42 = min (max ((
      (((500.0 * _FogIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
     * _FogEffectLimit), _FogEffectStart), _FogEffectLimit);
    highp vec3 tmpvar_44;
    tmpvar_44 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3((1.0 - clamp (
      (((1000.0 * _FogColorIntensity) * tmpvar_41) / max (0.1, tmpvar_43))
    , 0.0, 1.0))));
    fogColor_39.xyz = tmpvar_44;
    fogColor_39.w = tmpvar_42;
    tmpvar_33 = fogColor_39;
  };
  gl_Position = tmpvar_7;
  xlv_COLOR0 = tmpvar_8;
  xlv_COLOR1 = tmpvar_33;
  xlv_TEXCOORD0 = tmpvar_9;
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = tmpvar_11;
  xlv_TEXCOORD3 = tmpvar_18;
  xlv_TEXCOORD4 = tmpvar_12;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _Ambient;
uniform mediump float _AmbientRimIndex;
uniform mediump float _AmbientRimScale;
uniform mediump float _Diffuse;
uniform mediump float _Specular;
uniform mediump float _Shininess;
uniform mediump vec4 _SpecularColor;
uniform highp vec4 _LightDir;
uniform sampler2D _ShadowTex;
uniform mediump float _LumiFactor;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  mediump float specular_1;
  mediump float nl_2;
  mediump float diff_3;
  mediump float ambient_4;
  mediump vec4 shadowTex_5;
  mediump vec4 diffTex_6;
  highp float t_7;
  mediump vec4 color_8;
  color_8 = vec4(0.0, 0.0, 0.0, 0.0);
  mediump float tmpvar_9;
  if ((xlv_TEXCOORD0.x > 0.5)) {
    tmpvar_9 = xlv_TEXCOORD0.x;
  } else {
    tmpvar_9 = (1.0 - xlv_TEXCOORD0.x);
  };
  t_7 = tmpvar_9;
  t_7 = ((t_7 * 2.0) - 1.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = ((normalize(xlv_TEXCOORD3) * (1.0 - 
    (xlv_TEXCOORD0.x * 2.0)
  )) + (normalize(xlv_TEXCOORD2) * sqrt(
    (1.0 - (t_7 * t_7))
  )));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  diffTex_6 = tmpvar_11;
  diffTex_6.xyz = (diffTex_6.xyz * xlv_COLOR0);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_ShadowTex, xlv_TEXCOORD1);
  shadowTex_5 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = pow (t_7, _AmbientRimIndex);
  ambient_4 = (_Ambient + (tmpvar_13 * _AmbientRimScale));
  highp float tmpvar_14;
  tmpvar_14 = dot (tmpvar_10, _LightDir.xyz);
  nl_2 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = max (nl_2, 0.0);
  nl_2 = tmpvar_15;
  diff_3 = (tmpvar_15 * _Diffuse);
  diff_3 = (diff_3 * shadowTex_5.x);
  highp float tmpvar_16;
  tmpvar_16 = ((pow (
    max (dot (xlv_TEXCOORD4, tmpvar_10), 0.0)
  , _Shininess) * _Specular) * diffTex_6.w);
  specular_1 = tmpvar_16;
  specular_1 = (specular_1 * shadowTex_5.x);
  color_8 = ((diffTex_6 * (ambient_4 + diff_3)) + (_SpecularColor * specular_1));
  color_8.xyz = mix (color_8.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  color_8.w = _BloomFactor;
  color_8.xyz = mix (color_8.xyz, vec3(dot (color_8.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_8;
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