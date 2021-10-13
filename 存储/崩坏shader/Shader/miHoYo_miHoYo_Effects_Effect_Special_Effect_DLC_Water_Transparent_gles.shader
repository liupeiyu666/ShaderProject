//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/DLC_Water_Transparent" {
Properties {
_ShallowColor ("ShallowColor", Color) = (0,1,0.5862069,0)
_DeepColor ("DeepColor", Color) = (0,0,0,0)
_ShoreTransparency ("ShoreTransparency", Range(0, 10)) = 0.04
_ShoreFade ("ShoreFade", Range(0, 5)) = 5
_Normal01 ("Normal01", 2D) = "white" { }
_DeepColorDepth ("DeepColorDepth", Range(0, 10)) = 0.04
_DeepColorFade ("DeepColorFade", Range(0, 5)) = 1
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_VSpeed ("Normal01_V-Speed", Float) = 0
_Normal02 ("Normal02", 2D) = "bump" { }
_Normal02_U_Speed ("Normal02_U_Speed", Float) = 0
_Normal02_V_Speed ("Normal02_V_Speed", Float) = 0
_ReflectionTex ("Reflection", 2D) = "white" { }
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_NormalMapBias ("NormalMapBias", Float) = -1
_NormalMapScale ("NormalMapScale", Float) = 1
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 0.6
_ShoreReflectionFade ("ShoreReflectionFade", Range(0, 10)) = 2.6
_FresnelPower ("FresnelPower", Range(0, 5)) = 5
[MHYToggle] _SSRToggle ("SSRToggle", Float) = 1
_SSRDistortion ("SSRDistortion", Float) = 2
_SSRDistortion_Shore ("SSRDistortion_Shore", Float) = 0.01
_RefractionIntensity ("RefractionIntensity", Float) = 0
_ES_SunDirection ("Sun Direction", Vector) = (1,1,1,0)
_Gloss ("Gloss", Float) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_SpecularPower ("SpecularPower", Range(0, 10)) = 1
_FoamTexture ("FoamTexture", 2D) = "black" { }
_FoamColor ("FoamColor", Color) = (1,1,1,1)
_FoamWidth ("FoamWidth", Range(0, 5)) = 0.5
_FoamFade ("FoamFade", Range(0, 2)) = 2
_FoamSpeed ("FoamSpeed", Float) = 0
_FoamFadeDistance ("FoamFadeDistance", Float) = 2
_FoamFadeOffset ("FoamFadeOffset", Float) = 0
_OpacityByDepth ("OpacityByDepth", Range(0, 1)) = 0.04
_WaterMeshScale ("WaterMeshScale", Vector) = (1,1,1,0)
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_MHYZBias ("Z Bias", Float) = 0
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 0
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "SUBSHADER 0 PASS 0"
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 37506
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 ambient_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_11.zw;
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_8.xyz = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_9.xyz = tmpvar_19;
  tmpvar_10.xyz = (((tmpvar_17.yzx * tmpvar_19.zxy) - (tmpvar_17.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_6.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).z);
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_1.xyz;
  tmpvar_21 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_22));
  tmpvar_4.xyw = tmpvar_21.xyw;
  tmpvar_4.z = (tmpvar_21.z + (_MHYZBias * tmpvar_21.w));
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_glesNormal * tmpvar_23));
  worldNormal_3 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = worldNormal_3;
  mediump vec3 x_26;
  x_26.x = dot (unity_SHAr, tmpvar_25);
  x_26.y = dot (unity_SHAg, tmpvar_25);
  x_26.z = dot (unity_SHAb, tmpvar_25);
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (worldNormal_3.xyzz * worldNormal_3.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  ambient_2 = (x_26 + max (vec3(0.0, 0.0, 0.0), (x1_27 + 
    (unity_SHC.xyz * ((worldNormal_3.x * worldNormal_3.x) - (worldNormal_3.y * worldNormal_3.y)))
  )));
  tmpvar_5.xyz = ambient_2;
  tmpvar_5.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = o_13;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp vec3 _WaterMeshScale;
uniform highp float _Normal01_VSpeed;
uniform mediump float _NormalMapBias;
uniform sampler2D _Normal02;
uniform highp float _Normal02_U_Speed;
uniform highp vec4 _Normal02_ST;
uniform highp float _Normal02_V_Speed;
uniform highp float _RefractionIntensity;
uniform highp float _OpacityByDepth;
uniform highp float _SpecularIntensity;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _ShoreTransparency;
uniform highp float _SpecularPower;
uniform highp vec4 _ShallowColor;
uniform highp float _ShoreFade;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform highp vec4 _DistortionIntensity;
uniform sampler2D _ReflectionTex;
uniform highp float _SSRDistortion;
uniform highp float _SSRDistortion_Shore;
uniform highp float _ReflectionIntensity;
uniform highp float _FresnelPower;
uniform highp float _ShoreReflectionFade;
uniform sampler2D _FoamTexture;
uniform highp vec4 _FoamTexture_ST;
uniform highp float _FoamSpeed;
uniform highp float _FoamFade;
uniform highp float _FoamWidth;
uniform highp float _FoamFadeDistance;
uniform highp float _FoamFadeOffset;
uniform highp vec4 _FoamColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp float clampResult308_2;
  highp vec4 tex2DNode433_3;
  highp vec4 refraColor59_4;
  highp vec4 ase_lightColor_5;
  highp float ifLocalVar175_6;
  highp vec3 normalLocal32_7;
  highp vec3 temp_output_17_0_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD2.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal01_U_Speed) + (tmpvar_9.x * _WaterMeshScale.x));
  tmpvar_10.y = ((tmpvar_9.y * _WaterMeshScale.z) + (_Time.y * _Normal01_VSpeed));
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD2.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _Normal02_U_Speed) + (_WaterMeshScale.x * tmpvar_11.x));
  tmpvar_12.y = ((_WaterMeshScale.z * tmpvar_11.y) + (_Time.y * _Normal02_V_Speed));
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.xy = tmpvar_10;
  tmpvar_13.w = _NormalMapBias;
  mediump vec4 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal01, tmpvar_10, tmpvar_13.w);
  tmpvar_14 = tmpvar_15;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * _NormalMapScale);
  highp vec4 tmpvar_18;
  tmpvar_18.z = 0.0;
  tmpvar_18.xy = tmpvar_12;
  tmpvar_18.w = _NormalMapBias;
  mediump vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Normal02, tmpvar_12, tmpvar_18.w);
  tmpvar_19 = tmpvar_20;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * _NormalMapScale);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  temp_output_17_0_8 = tmpvar_23;
  normalLocal32_7 = temp_output_17_0_8;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (((
    (temp_output_17_0_8.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD3.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD3.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w), 0.0, 1.0));
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 + xlv_TEXCOORD3);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_29) + _ZBufferParams.w))) - xlv_TEXCOORD3.w)
  , 0.0, 1.0) * tmpvar_26) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, tmpvar_30);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp float tmpvar_33;
  tmpvar_33 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD3.w);
  highp vec3 tmpvar_34;
  tmpvar_34.y = 1.0;
  tmpvar_34.x = temp_output_17_0_8.x;
  tmpvar_34.z = temp_output_17_0_8.y;
  highp float tmpvar_35;
  tmpvar_35 = dot (normalize(tmpvar_34), normalize((_ES_SunDirection + 
    normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz))
  )));
  highp float tmpvar_36;
  tmpvar_36 = (_Gloss * 128.0);
  ifLocalVar175_6 = 0.0;
  if ((_ES_SunDirection.y <= 0.0)) {
    ifLocalVar175_6 = 0.0;
  } else {
    ifLocalVar175_6 = pow (max (tmpvar_35, 0.0001), tmpvar_36);
  };
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_37;
  tmpvar_37 = (1.0/(_ShoreTransparency));
  highp float tmpvar_38;
  tmpvar_38 = pow (max (clamp (
    (tmpvar_33 * tmpvar_37)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec2 P_39;
  P_39 = (tmpvar_30 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_BeforeAlphaTexture, P_39);
  refraColor59_4 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_38)) * refraColor59_4);
  highp vec4 tmpvar_42;
  tmpvar_42.w = 0.0;
  tmpvar_42.xyz = temp_output_17_0_8;
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((
    ((tmpvar_42 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD3.w))
   * 
    clamp ((tmpvar_33 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD3) / xlv_TEXCOORD3.w).xy;
  tmpvar_43 = texture2D (_ReflectionTex, P_44);
  tex2DNode433_3 = tmpvar_43;
  normalLocal32_7.xz = temp_output_17_0_8.xy;
  normalLocal32_7.y = 1.0;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD2.xy * _FoamTexture_ST.xy) + _FoamTexture_ST.zw);
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * (0.06 * _FoamSpeed));
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * (_FoamSpeed * 0.04));
  highp vec2 tmpvar_48;
  tmpvar_48.x = (tmpvar_45.x + tmpvar_46);
  tmpvar_48.y = (tmpvar_45.y + tmpvar_47);
  highp vec2 tmpvar_49;
  tmpvar_49.x = (tmpvar_46 * -0.8);
  tmpvar_49.y = (tmpvar_47 * 0.7);
  highp vec2 P_50;
  P_50 = ((tmpvar_45 * vec2(0.6, 0.6)) + tmpvar_49);
  lowp float tmpvar_51;
  tmpvar_51 = clamp ((texture2D (_FoamTexture, P_50).x + -0.1), 0.0, 1.0);
  clampResult308_2 = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((0.1 / _OpacityByDepth), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  highp vec3 tmpvar_55;
  tmpvar_55 = (_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz);
  tmpvar_54.xyz = (((
    clamp ((_SpecularIntensity * ifLocalVar175_6), 0.0, 16.0)
   * ase_lightColor_5.xyz) * clamp (
    (((tmpvar_33 - 1.0) * 0.1) * tmpvar_37)
  , 0.0, 1.0)) * pow (max (
    (1.0 - dot (normalize(tmpvar_55), normalize(xlv_TEXCOORD5.xyz)))
  , 0.0001), _SpecularPower));
  lowp vec4 tmpvar_56;
  tmpvar_56 = texture2D (_FoamTexture, tmpvar_48);
  highp vec3 tmpvar_57;
  tmpvar_57 = ((tmpvar_54 + mix (tmpvar_41, 
    mix (mix (tmpvar_41, _DeepColor, vec4(pow (max (
      clamp ((tmpvar_33 * (0.1 / _DeepColorDepth)), 0.0, 1.0)
    , 0.0001), _DeepColorFade))), tex2DNode433_3, vec4(clamp (((_ReflectionIntensity * 
      pow (max ((1.0 - dot (
        normalize(tmpvar_55)
      , 
        normalize(normalLocal32_7)
      )), 0.0001), _FresnelPower)
    ) * clamp (
      (tmpvar_33 * (1.0/(_ShoreReflectionFade)))
    , 0.0, 1.0)), 0.0, 1.0)))
  , vec4(tmpvar_38))) + ((
    ((tmpvar_56.x * clampResult308_2) * clamp (((1.0/(_FoamFade)) * tmpvar_33), 0.0, 1.0))
   * 
    (1.0 - clamp ((tmpvar_33 * (1.0/(
      (_FoamWidth * clamp (((
        (xlv_TEXCOORD2.z - _ProjectionParams.y)
       - _FoamFadeOffset) / _FoamFadeDistance), 0.0, 1.0))
    ))), 0.0, 1.0))
  ) * _FoamColor)).xyz;
  aseOutColor_1 = tmpvar_57;
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = aseOutColor_1;
  tmpvar_58.w = clamp (tmpvar_52, 0.0, 1.0);
  gl_FragData[0] = tmpvar_58;
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
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 ambient_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_11.zw;
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_8.xyz = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_9.xyz = tmpvar_19;
  tmpvar_10.xyz = (((tmpvar_17.yzx * tmpvar_19.zxy) - (tmpvar_17.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_6.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).z);
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_1.xyz;
  tmpvar_21 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_22));
  tmpvar_4.xyw = tmpvar_21.xyw;
  tmpvar_4.z = (tmpvar_21.z + (_MHYZBias * tmpvar_21.w));
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_glesNormal * tmpvar_23));
  worldNormal_3 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = worldNormal_3;
  mediump vec3 x_26;
  x_26.x = dot (unity_SHAr, tmpvar_25);
  x_26.y = dot (unity_SHAg, tmpvar_25);
  x_26.z = dot (unity_SHAb, tmpvar_25);
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (worldNormal_3.xyzz * worldNormal_3.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  ambient_2 = (x_26 + max (vec3(0.0, 0.0, 0.0), (x1_27 + 
    (unity_SHC.xyz * ((worldNormal_3.x * worldNormal_3.x) - (worldNormal_3.y * worldNormal_3.y)))
  )));
  tmpvar_5.xyz = ambient_2;
  tmpvar_5.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = o_13;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp vec3 _WaterMeshScale;
uniform highp float _Normal01_VSpeed;
uniform mediump float _NormalMapBias;
uniform sampler2D _Normal02;
uniform highp float _Normal02_U_Speed;
uniform highp vec4 _Normal02_ST;
uniform highp float _Normal02_V_Speed;
uniform highp float _RefractionIntensity;
uniform highp float _OpacityByDepth;
uniform highp float _SpecularIntensity;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _ShoreTransparency;
uniform highp float _SpecularPower;
uniform highp vec4 _ShallowColor;
uniform highp float _ShoreFade;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform highp vec4 _DistortionIntensity;
uniform sampler2D _ReflectionTex;
uniform highp float _SSRDistortion;
uniform highp float _SSRDistortion_Shore;
uniform highp float _ReflectionIntensity;
uniform highp float _FresnelPower;
uniform highp float _ShoreReflectionFade;
uniform sampler2D _FoamTexture;
uniform highp vec4 _FoamTexture_ST;
uniform highp float _FoamSpeed;
uniform highp float _FoamFade;
uniform highp float _FoamWidth;
uniform highp float _FoamFadeDistance;
uniform highp float _FoamFadeOffset;
uniform highp vec4 _FoamColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp float clampResult308_2;
  highp vec4 tex2DNode433_3;
  highp vec4 refraColor59_4;
  highp vec4 ase_lightColor_5;
  highp float ifLocalVar175_6;
  highp vec3 normalLocal32_7;
  highp vec3 temp_output_17_0_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD2.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal01_U_Speed) + (tmpvar_9.x * _WaterMeshScale.x));
  tmpvar_10.y = ((tmpvar_9.y * _WaterMeshScale.z) + (_Time.y * _Normal01_VSpeed));
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD2.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _Normal02_U_Speed) + (_WaterMeshScale.x * tmpvar_11.x));
  tmpvar_12.y = ((_WaterMeshScale.z * tmpvar_11.y) + (_Time.y * _Normal02_V_Speed));
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.xy = tmpvar_10;
  tmpvar_13.w = _NormalMapBias;
  mediump vec4 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal01, tmpvar_10, tmpvar_13.w);
  tmpvar_14 = tmpvar_15;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * _NormalMapScale);
  highp vec4 tmpvar_18;
  tmpvar_18.z = 0.0;
  tmpvar_18.xy = tmpvar_12;
  tmpvar_18.w = _NormalMapBias;
  mediump vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Normal02, tmpvar_12, tmpvar_18.w);
  tmpvar_19 = tmpvar_20;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * _NormalMapScale);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  temp_output_17_0_8 = tmpvar_23;
  normalLocal32_7 = temp_output_17_0_8;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (((
    (temp_output_17_0_8.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD3.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD3.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w), 0.0, 1.0));
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 + xlv_TEXCOORD3);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_29) + _ZBufferParams.w))) - xlv_TEXCOORD3.w)
  , 0.0, 1.0) * tmpvar_26) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, tmpvar_30);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp float tmpvar_33;
  tmpvar_33 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD3.w);
  highp vec3 tmpvar_34;
  tmpvar_34.y = 1.0;
  tmpvar_34.x = temp_output_17_0_8.x;
  tmpvar_34.z = temp_output_17_0_8.y;
  highp float tmpvar_35;
  tmpvar_35 = dot (normalize(tmpvar_34), normalize((_ES_SunDirection + 
    normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz))
  )));
  highp float tmpvar_36;
  tmpvar_36 = (_Gloss * 128.0);
  ifLocalVar175_6 = 0.0;
  if ((_ES_SunDirection.y <= 0.0)) {
    ifLocalVar175_6 = 0.0;
  } else {
    ifLocalVar175_6 = pow (max (tmpvar_35, 0.0001), tmpvar_36);
  };
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_37;
  tmpvar_37 = (1.0/(_ShoreTransparency));
  highp float tmpvar_38;
  tmpvar_38 = pow (max (clamp (
    (tmpvar_33 * tmpvar_37)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec2 P_39;
  P_39 = (tmpvar_30 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_BeforeAlphaTexture, P_39);
  refraColor59_4 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_38)) * refraColor59_4);
  highp vec4 tmpvar_42;
  tmpvar_42.w = 0.0;
  tmpvar_42.xyz = temp_output_17_0_8;
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((
    ((tmpvar_42 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD3.w))
   * 
    clamp ((tmpvar_33 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD3) / xlv_TEXCOORD3.w).xy;
  tmpvar_43 = texture2D (_ReflectionTex, P_44);
  tex2DNode433_3 = tmpvar_43;
  normalLocal32_7.xz = temp_output_17_0_8.xy;
  normalLocal32_7.y = 1.0;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD2.xy * _FoamTexture_ST.xy) + _FoamTexture_ST.zw);
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * (0.06 * _FoamSpeed));
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * (_FoamSpeed * 0.04));
  highp vec2 tmpvar_48;
  tmpvar_48.x = (tmpvar_45.x + tmpvar_46);
  tmpvar_48.y = (tmpvar_45.y + tmpvar_47);
  highp vec2 tmpvar_49;
  tmpvar_49.x = (tmpvar_46 * -0.8);
  tmpvar_49.y = (tmpvar_47 * 0.7);
  highp vec2 P_50;
  P_50 = ((tmpvar_45 * vec2(0.6, 0.6)) + tmpvar_49);
  lowp float tmpvar_51;
  tmpvar_51 = clamp ((texture2D (_FoamTexture, P_50).x + -0.1), 0.0, 1.0);
  clampResult308_2 = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((0.1 / _OpacityByDepth), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  highp vec3 tmpvar_55;
  tmpvar_55 = (_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz);
  tmpvar_54.xyz = (((
    clamp ((_SpecularIntensity * ifLocalVar175_6), 0.0, 16.0)
   * ase_lightColor_5.xyz) * clamp (
    (((tmpvar_33 - 1.0) * 0.1) * tmpvar_37)
  , 0.0, 1.0)) * pow (max (
    (1.0 - dot (normalize(tmpvar_55), normalize(xlv_TEXCOORD5.xyz)))
  , 0.0001), _SpecularPower));
  lowp vec4 tmpvar_56;
  tmpvar_56 = texture2D (_FoamTexture, tmpvar_48);
  highp vec3 tmpvar_57;
  tmpvar_57 = ((tmpvar_54 + mix (tmpvar_41, 
    mix (mix (tmpvar_41, _DeepColor, vec4(pow (max (
      clamp ((tmpvar_33 * (0.1 / _DeepColorDepth)), 0.0, 1.0)
    , 0.0001), _DeepColorFade))), tex2DNode433_3, vec4(clamp (((_ReflectionIntensity * 
      pow (max ((1.0 - dot (
        normalize(tmpvar_55)
      , 
        normalize(normalLocal32_7)
      )), 0.0001), _FresnelPower)
    ) * clamp (
      (tmpvar_33 * (1.0/(_ShoreReflectionFade)))
    , 0.0, 1.0)), 0.0, 1.0)))
  , vec4(tmpvar_38))) + ((
    ((tmpvar_56.x * clampResult308_2) * clamp (((1.0/(_FoamFade)) * tmpvar_33), 0.0, 1.0))
   * 
    (1.0 - clamp ((tmpvar_33 * (1.0/(
      (_FoamWidth * clamp (((
        (xlv_TEXCOORD2.z - _ProjectionParams.y)
       - _FoamFadeOffset) / _FoamFadeDistance), 0.0, 1.0))
    ))), 0.0, 1.0))
  ) * _FoamColor)).xyz;
  aseOutColor_1 = tmpvar_57;
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = aseOutColor_1;
  tmpvar_58.w = clamp (tmpvar_52, 0.0, 1.0);
  gl_FragData[0] = tmpvar_58;
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
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 ambient_2;
  mediump vec3 worldNormal_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec4 o_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14.x;
  tmpvar_15.y = (tmpvar_14.y * _ProjectionParams.x);
  o_13.xy = (tmpvar_15 + tmpvar_14.w);
  o_13.zw = tmpvar_11.zw;
  tmpvar_7.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_glesNormal * tmpvar_16));
  tmpvar_8.xyz = tmpvar_17;
  highp mat3 tmpvar_18;
  tmpvar_18[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_18[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_18[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize((tmpvar_18 * _glesTANGENT.xyz));
  tmpvar_9.xyz = tmpvar_19;
  tmpvar_10.xyz = (((tmpvar_17.yzx * tmpvar_19.zxy) - (tmpvar_17.zxy * tmpvar_19.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  highp vec4 tmpvar_20;
  tmpvar_20.w = 1.0;
  tmpvar_20.xyz = tmpvar_1.xyz;
  tmpvar_6.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_20)).z);
  tmpvar_6.xy = _glesMultiTexCoord0.xy;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  tmpvar_8.w = 0.0;
  tmpvar_9.w = 0.0;
  tmpvar_10.w = 0.0;
  highp vec4 tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22.w = 1.0;
  tmpvar_22.xyz = tmpvar_1.xyz;
  tmpvar_21 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_22));
  tmpvar_4.xyw = tmpvar_21.xyw;
  tmpvar_4.z = (tmpvar_21.z + (_MHYZBias * tmpvar_21.w));
  highp mat3 tmpvar_23;
  tmpvar_23[0] = unity_WorldToObject[0].xyz;
  tmpvar_23[1] = unity_WorldToObject[1].xyz;
  tmpvar_23[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_glesNormal * tmpvar_23));
  worldNormal_3 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = worldNormal_3;
  mediump vec3 x_26;
  x_26.x = dot (unity_SHAr, tmpvar_25);
  x_26.y = dot (unity_SHAg, tmpvar_25);
  x_26.z = dot (unity_SHAb, tmpvar_25);
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (worldNormal_3.xyzz * worldNormal_3.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  ambient_2 = (x_26 + max (vec3(0.0, 0.0, 0.0), (x1_27 + 
    (unity_SHC.xyz * ((worldNormal_3.x * worldNormal_3.x) - (worldNormal_3.y * worldNormal_3.y)))
  )));
  tmpvar_5.xyz = ambient_2;
  tmpvar_5.w = 1.0;
  gl_Position = tmpvar_4;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD3 = o_13;
  xlv_TEXCOORD4 = tmpvar_7;
  xlv_TEXCOORD5 = tmpvar_8;
  xlv_TEXCOORD6 = tmpvar_9;
  xlv_TEXCOORD7 = tmpvar_10;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp vec3 _WaterMeshScale;
uniform highp float _Normal01_VSpeed;
uniform mediump float _NormalMapBias;
uniform sampler2D _Normal02;
uniform highp float _Normal02_U_Speed;
uniform highp vec4 _Normal02_ST;
uniform highp float _Normal02_V_Speed;
uniform highp float _RefractionIntensity;
uniform highp float _OpacityByDepth;
uniform highp float _SpecularIntensity;
uniform highp vec3 _ES_SunDirection;
uniform highp float _Gloss;
uniform highp float _ShoreTransparency;
uniform highp float _SpecularPower;
uniform highp vec4 _ShallowColor;
uniform highp float _ShoreFade;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform highp vec4 _DistortionIntensity;
uniform sampler2D _ReflectionTex;
uniform highp float _SSRDistortion;
uniform highp float _SSRDistortion_Shore;
uniform highp float _ReflectionIntensity;
uniform highp float _FresnelPower;
uniform highp float _ShoreReflectionFade;
uniform sampler2D _FoamTexture;
uniform highp vec4 _FoamTexture_ST;
uniform highp float _FoamSpeed;
uniform highp float _FoamFade;
uniform highp float _FoamWidth;
uniform highp float _FoamFadeDistance;
uniform highp float _FoamFadeOffset;
uniform highp vec4 _FoamColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp float clampResult308_2;
  highp vec4 tex2DNode433_3;
  highp vec4 refraColor59_4;
  highp vec4 ase_lightColor_5;
  highp float ifLocalVar175_6;
  highp vec3 normalLocal32_7;
  highp vec3 temp_output_17_0_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD2.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal01_U_Speed) + (tmpvar_9.x * _WaterMeshScale.x));
  tmpvar_10.y = ((tmpvar_9.y * _WaterMeshScale.z) + (_Time.y * _Normal01_VSpeed));
  highp vec2 tmpvar_11;
  tmpvar_11 = ((xlv_TEXCOORD2.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_12;
  tmpvar_12.x = ((_Time.y * _Normal02_U_Speed) + (_WaterMeshScale.x * tmpvar_11.x));
  tmpvar_12.y = ((_WaterMeshScale.z * tmpvar_11.y) + (_Time.y * _Normal02_V_Speed));
  highp vec4 tmpvar_13;
  tmpvar_13.z = 0.0;
  tmpvar_13.xy = tmpvar_10;
  tmpvar_13.w = _NormalMapBias;
  mediump vec4 tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal01, tmpvar_10, tmpvar_13.w);
  tmpvar_14 = tmpvar_15;
  mediump vec3 normal_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = ((tmpvar_14.xyz * 2.0) - 1.0);
  normal_16.z = tmpvar_17.z;
  normal_16.xy = (tmpvar_17.xy * _NormalMapScale);
  highp vec4 tmpvar_18;
  tmpvar_18.z = 0.0;
  tmpvar_18.xy = tmpvar_12;
  tmpvar_18.w = _NormalMapBias;
  mediump vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_Normal02, tmpvar_12, tmpvar_18.w);
  tmpvar_19 = tmpvar_20;
  mediump vec3 normal_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = ((tmpvar_19.xyz * 2.0) - 1.0);
  normal_21.z = tmpvar_22.z;
  normal_21.xy = (tmpvar_22.xy * _NormalMapScale);
  mediump vec3 tmpvar_23;
  tmpvar_23 = (normal_16 + normal_21);
  temp_output_17_0_8 = tmpvar_23;
  normalLocal32_7 = temp_output_17_0_8;
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (((
    (temp_output_17_0_8.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD3.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD3.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w)))
   - xlv_TEXCOORD3.w), 0.0, 1.0));
  highp vec4 tmpvar_27;
  tmpvar_27 = (tmpvar_26 + xlv_TEXCOORD3);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp vec4 tmpvar_30;
  tmpvar_30 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_29) + _ZBufferParams.w))) - xlv_TEXCOORD3.w)
  , 0.0, 1.0) * tmpvar_26) + xlv_TEXCOORD3);
  lowp vec4 tmpvar_31;
  tmpvar_31 = texture2DProj (_CustomDepthTexture, tmpvar_30);
  highp float z_32;
  z_32 = tmpvar_31.x;
  highp float tmpvar_33;
  tmpvar_33 = ((1.0/((
    (_ZBufferParams.z * z_32)
   + _ZBufferParams.w))) - xlv_TEXCOORD3.w);
  highp vec3 tmpvar_34;
  tmpvar_34.y = 1.0;
  tmpvar_34.x = temp_output_17_0_8.x;
  tmpvar_34.z = temp_output_17_0_8.y;
  highp float tmpvar_35;
  tmpvar_35 = dot (normalize(tmpvar_34), normalize((_ES_SunDirection + 
    normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz))
  )));
  highp float tmpvar_36;
  tmpvar_36 = (_Gloss * 128.0);
  ifLocalVar175_6 = 0.0;
  if ((_ES_SunDirection.y <= 0.0)) {
    ifLocalVar175_6 = 0.0;
  } else {
    ifLocalVar175_6 = pow (max (tmpvar_35, 0.0001), tmpvar_36);
  };
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_37;
  tmpvar_37 = (1.0/(_ShoreTransparency));
  highp float tmpvar_38;
  tmpvar_38 = pow (max (clamp (
    (tmpvar_33 * tmpvar_37)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec2 P_39;
  P_39 = (tmpvar_30 / xlv_TEXCOORD3.w).xy;
  lowp vec4 tmpvar_40;
  tmpvar_40 = texture2D (_BeforeAlphaTexture, P_39);
  refraColor59_4 = tmpvar_40;
  highp vec4 tmpvar_41;
  tmpvar_41 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_38)) * refraColor59_4);
  highp vec4 tmpvar_42;
  tmpvar_42.w = 0.0;
  tmpvar_42.xyz = temp_output_17_0_8;
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (((
    ((tmpvar_42 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD3.w))
   * 
    clamp ((tmpvar_33 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD3) / xlv_TEXCOORD3.w).xy;
  tmpvar_43 = texture2D (_ReflectionTex, P_44);
  tex2DNode433_3 = tmpvar_43;
  normalLocal32_7.xz = temp_output_17_0_8.xy;
  normalLocal32_7.y = 1.0;
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD2.xy * _FoamTexture_ST.xy) + _FoamTexture_ST.zw);
  highp float tmpvar_46;
  tmpvar_46 = (_Time.y * (0.06 * _FoamSpeed));
  highp float tmpvar_47;
  tmpvar_47 = (_Time.y * (_FoamSpeed * 0.04));
  highp vec2 tmpvar_48;
  tmpvar_48.x = (tmpvar_45.x + tmpvar_46);
  tmpvar_48.y = (tmpvar_45.y + tmpvar_47);
  highp vec2 tmpvar_49;
  tmpvar_49.x = (tmpvar_46 * -0.8);
  tmpvar_49.y = (tmpvar_47 * 0.7);
  highp vec2 P_50;
  P_50 = ((tmpvar_45 * vec2(0.6, 0.6)) + tmpvar_49);
  lowp float tmpvar_51;
  tmpvar_51 = clamp ((texture2D (_FoamTexture, P_50).x + -0.1), 0.0, 1.0);
  clampResult308_2 = tmpvar_51;
  mediump float tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp ((0.1 / _OpacityByDepth), 0.0, 1.0);
  tmpvar_52 = tmpvar_53;
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  highp vec3 tmpvar_55;
  tmpvar_55 = (_WorldSpaceCameraPos - xlv_TEXCOORD4.xyz);
  tmpvar_54.xyz = (((
    clamp ((_SpecularIntensity * ifLocalVar175_6), 0.0, 16.0)
   * ase_lightColor_5.xyz) * clamp (
    (((tmpvar_33 - 1.0) * 0.1) * tmpvar_37)
  , 0.0, 1.0)) * pow (max (
    (1.0 - dot (normalize(tmpvar_55), normalize(xlv_TEXCOORD5.xyz)))
  , 0.0001), _SpecularPower));
  lowp vec4 tmpvar_56;
  tmpvar_56 = texture2D (_FoamTexture, tmpvar_48);
  highp vec3 tmpvar_57;
  tmpvar_57 = ((tmpvar_54 + mix (tmpvar_41, 
    mix (mix (tmpvar_41, _DeepColor, vec4(pow (max (
      clamp ((tmpvar_33 * (0.1 / _DeepColorDepth)), 0.0, 1.0)
    , 0.0001), _DeepColorFade))), tex2DNode433_3, vec4(clamp (((_ReflectionIntensity * 
      pow (max ((1.0 - dot (
        normalize(tmpvar_55)
      , 
        normalize(normalLocal32_7)
      )), 0.0001), _FresnelPower)
    ) * clamp (
      (tmpvar_33 * (1.0/(_ShoreReflectionFade)))
    , 0.0, 1.0)), 0.0, 1.0)))
  , vec4(tmpvar_38))) + ((
    ((tmpvar_56.x * clampResult308_2) * clamp (((1.0/(_FoamFade)) * tmpvar_33), 0.0, 1.0))
   * 
    (1.0 - clamp ((tmpvar_33 * (1.0/(
      (_FoamWidth * clamp (((
        (xlv_TEXCOORD2.z - _ProjectionParams.y)
       - _FoamFadeOffset) / _FoamFadeDistance), 0.0, 1.0))
    ))), 0.0, 1.0))
  ) * _FoamColor)).xyz;
  aseOutColor_1 = tmpvar_57;
  mediump vec4 tmpvar_58;
  tmpvar_58.xyz = aseOutColor_1;
  tmpvar_58.w = clamp (tmpvar_52, 0.0, 1.0);
  gl_FragData[0] = tmpvar_58;
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
CustomEditor "MiHoYoASEMaterialInspector"
}