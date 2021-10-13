//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Water_Transparent" {
Properties {
_ShallowColor ("ShallowColor", Color) = (0,1,0.5862069,0)
_DeepColor ("DeepColor", Color) = (0,0,0,0)
_ShoreTransparency ("ShoreTransparency", Range(0, 10)) = 0.04
_ShoreFade ("ShoreFade", Range(0, 5)) = 5
_DeepColorDepth ("DeepColorDepth", Range(0, 10)) = 0.04
_DeepColorFade ("DeepColorFade", Range(0, 5)) = 1
_Normal01 ("Normal01", 2D) = "white" { }
_Normal01_U_Speed ("Normal01_U_Speed", Float) = 0
_Normal01_V_Speed ("Normal01_V_Speed", Float) = 0
_Normal02 ("Normal02", 2D) = "bump" { }
_Normal02_U_Speed ("Normal02_U_Speed", Float) = 0
_Normal02_V_Speed ("Normal02_V_Speed", Float) = 0
_DistortionIntensity ("DistortionIntensity", Color) = (1,1,1,0)
_NormalMapScale ("NormalMapScale", Float) = 1
_ReflectionIntensity ("ReflectionIntensity", Range(0, 1)) = 0.6
_ShoreReflectionFade ("ShoreReflectionFade", Range(0, 10)) = 2.6
_FresnelPower ("FresnelPower", Range(0, 5)) = 5
_SSRDistortion ("SSRDistortion", Float) = 2
_SSRDistortion_Shore ("SSRDistortion_Shore", Float) = 0.01
_RefractionIntensity ("RefractionIntensity", Float) = 0
[Toggle(USE_SUNDIR)] _UseSundir ("Use Sun Dir", Float) = 1
_ES_SunDirection ("Sun Dir", Vector) = (1,1,1,1)
_Gloss ("Gloss", Float) = 1
_SpecularIntensity ("SpecularIntensity", Float) = 1
_SpecularPower ("SpecularPower", Range(0, 10)) = 1
_CausticTex ("CausticTex", 2D) = "white" { }
_CausticIntensity ("CausticIntensity", Float) = 1
_CausticColor ("CausticColor", Color) = (1,1,1,0)
_CausticTiling ("CausticTiling", Range(0, 1)) = 1
_CausticDistortionSpeed ("CausticDistortionSpeed", Range(0.1, 1)) = 1
_CausticDistortionTiling ("CausticDistortionTiling", Range(0, 1)) = 0.03588236
_CausticDistortionValue ("CausticDistortionValue", Range(0, 1)) = 0.1
_CausticFade ("CausticFade", Range(0.01, 10)) = 1
_CausticFadePower ("CausticFadePower", Range(0.1, 10)) = 0.1
_CausticDepth ("CausticDepth", Range(0.01, 50)) = 0.5
_CausticDistance ("CausticDistance", Float) = 2
_CausticOffset ("CausticOffset", Float) = 0
_OpacityByDepth ("OpacityByDepth", Range(0, 10)) = 0.04
_ReflectionTex ("Reflection Tex", 2D) = "white" { }
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 63444
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode353_2;
  highp vec4 tex2DNode345_3;
  highp vec3 specColor183_4;
  highp vec4 ase_lightColor_5;
  highp vec3 temp_output_17_0_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_7.x);
  tmpvar_8.y = (tmpvar_7.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_9.x);
  tmpvar_10.y = (tmpvar_9.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal01, tmpvar_8);
  mediump vec4 packednormal_12;
  packednormal_12 = tmpvar_11;
  mediump vec3 normal_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((packednormal_12.xyz * 2.0) - 1.0);
  normal_13.z = tmpvar_14.z;
  normal_13.xy = (tmpvar_14.xy * _NormalMapScale);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal02, tmpvar_10);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump vec3 normal_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_17.z = tmpvar_18.z;
  normal_17.xy = (tmpvar_18.xy * _NormalMapScale);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (normal_13 + normal_17);
  temp_output_17_0_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_21;
  z_21 = tmpvar_20.x;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = (((
    (temp_output_17_0_6.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_21) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, tmpvar_23);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_22) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, tmpvar_26);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp float tmpvar_29;
  tmpvar_29 = ((1.0/((
    (_ZBufferParams.z * z_28)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_30;
  tmpvar_30 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_4 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_33;
    tmpvar_33.y = 1.0;
    tmpvar_33.x = temp_output_17_0_6.x;
    tmpvar_33.z = temp_output_17_0_6.y;
    specColor183_4 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_33), normalize((_ES_SunDirection + tmpvar_32)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_5.xyz) * clamp (
      (((tmpvar_29 - 1.0) * 0.1) * tmpvar_30)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_31))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_34;
  tmpvar_34 = pow (max (clamp (
    (tmpvar_29 * tmpvar_30)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _ES_SunDirection;
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = tmpvar_31;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_38;
  z_38 = tmpvar_37.x;
  highp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((1.0/((
    (_ZBufferParams.x * z_38)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_CameraToWorld * tmpvar_39);
  highp vec2 tmpvar_41;
  tmpvar_41 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_42;
  tmpvar_42 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (tmpvar_41 + tmpvar_42);
  tmpvar_43 = texture2D (_CausticTex, P_44);
  tex2DNode345_3 = tmpvar_43;
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = ((tmpvar_41 * vec2(1.5, 1.5)) - tmpvar_42);
  tmpvar_45 = texture2D (_CausticTex, P_46);
  tex2DNode353_2 = tmpvar_45;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 0.0;
  tmpvar_47.xyz = (ase_lightColor_5.xyz * clamp (dot (tmpvar_35, tmpvar_36), 0.0, 1.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((_CausticTiling * (tmpvar_40.xz / tmpvar_40.w)) + (_CausticDistortionValue * mix (tex2DNode345_3.yz, tex2DNode353_2.yz, vec2(0.6, 0.6))));
  tmpvar_48 = texture2D (_CausticTex, P_49);
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (tmpvar_26 / xlv_TEXCOORD2.w).xy;
  tmpvar_50 = texture2D (_RefractionTex, P_51);
  highp vec4 tmpvar_52;
  tmpvar_52 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_34)) * ((
    ((((tmpvar_47 * _CausticColor) * (_CausticIntensity * tmpvar_48.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_29), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_29 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_50));
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((tmpvar_29 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = specColor183_4;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 + mix (tmpvar_52, mix (tmpvar_52, _DeepColor, vec4(
    pow (max (clamp ((tmpvar_29 * 
      (0.1 / _DeepColorDepth)
    ), 0.0, 1.0), 0.0001), _DeepColorFade)
  )), vec4(tmpvar_34))).xyz;
  aseOutColor_1 = tmpvar_56;
  mediump vec4 tmpvar_57;
  tmpvar_57.xyz = aseOutColor_1;
  tmpvar_57.w = clamp (tmpvar_53, 0.0, 1.0);
  gl_FragData[0] = tmpvar_57;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode353_2;
  highp vec4 tex2DNode345_3;
  highp vec3 specColor183_4;
  highp vec4 ase_lightColor_5;
  highp vec3 temp_output_17_0_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_7.x);
  tmpvar_8.y = (tmpvar_7.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_9.x);
  tmpvar_10.y = (tmpvar_9.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal01, tmpvar_8);
  mediump vec4 packednormal_12;
  packednormal_12 = tmpvar_11;
  mediump vec3 normal_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((packednormal_12.xyz * 2.0) - 1.0);
  normal_13.z = tmpvar_14.z;
  normal_13.xy = (tmpvar_14.xy * _NormalMapScale);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal02, tmpvar_10);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump vec3 normal_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_17.z = tmpvar_18.z;
  normal_17.xy = (tmpvar_18.xy * _NormalMapScale);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (normal_13 + normal_17);
  temp_output_17_0_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_21;
  z_21 = tmpvar_20.x;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = (((
    (temp_output_17_0_6.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_21) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, tmpvar_23);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_22) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, tmpvar_26);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp float tmpvar_29;
  tmpvar_29 = ((1.0/((
    (_ZBufferParams.z * z_28)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_30;
  tmpvar_30 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_4 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_33;
    tmpvar_33.y = 1.0;
    tmpvar_33.x = temp_output_17_0_6.x;
    tmpvar_33.z = temp_output_17_0_6.y;
    specColor183_4 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_33), normalize((_ES_SunDirection + tmpvar_32)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_5.xyz) * clamp (
      (((tmpvar_29 - 1.0) * 0.1) * tmpvar_30)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_31))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_34;
  tmpvar_34 = pow (max (clamp (
    (tmpvar_29 * tmpvar_30)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _ES_SunDirection;
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = tmpvar_31;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_38;
  z_38 = tmpvar_37.x;
  highp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((1.0/((
    (_ZBufferParams.x * z_38)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_CameraToWorld * tmpvar_39);
  highp vec2 tmpvar_41;
  tmpvar_41 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_42;
  tmpvar_42 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (tmpvar_41 + tmpvar_42);
  tmpvar_43 = texture2D (_CausticTex, P_44);
  tex2DNode345_3 = tmpvar_43;
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = ((tmpvar_41 * vec2(1.5, 1.5)) - tmpvar_42);
  tmpvar_45 = texture2D (_CausticTex, P_46);
  tex2DNode353_2 = tmpvar_45;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 0.0;
  tmpvar_47.xyz = (ase_lightColor_5.xyz * clamp (dot (tmpvar_35, tmpvar_36), 0.0, 1.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((_CausticTiling * (tmpvar_40.xz / tmpvar_40.w)) + (_CausticDistortionValue * mix (tex2DNode345_3.yz, tex2DNode353_2.yz, vec2(0.6, 0.6))));
  tmpvar_48 = texture2D (_CausticTex, P_49);
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (tmpvar_26 / xlv_TEXCOORD2.w).xy;
  tmpvar_50 = texture2D (_RefractionTex, P_51);
  highp vec4 tmpvar_52;
  tmpvar_52 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_34)) * ((
    ((((tmpvar_47 * _CausticColor) * (_CausticIntensity * tmpvar_48.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_29), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_29 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_50));
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((tmpvar_29 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = specColor183_4;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 + mix (tmpvar_52, mix (tmpvar_52, _DeepColor, vec4(
    pow (max (clamp ((tmpvar_29 * 
      (0.1 / _DeepColorDepth)
    ), 0.0, 1.0), 0.0001), _DeepColorFade)
  )), vec4(tmpvar_34))).xyz;
  aseOutColor_1 = tmpvar_56;
  mediump vec4 tmpvar_57;
  tmpvar_57.xyz = aseOutColor_1;
  tmpvar_57.w = clamp (tmpvar_53, 0.0, 1.0);
  gl_FragData[0] = tmpvar_57;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
uniform highp vec4 _DeepColor;
uniform highp float _DeepColorDepth;
uniform highp float _DeepColorFade;
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode353_2;
  highp vec4 tex2DNode345_3;
  highp vec3 specColor183_4;
  highp vec4 ase_lightColor_5;
  highp vec3 temp_output_17_0_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_8;
  tmpvar_8.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_7.x);
  tmpvar_8.y = (tmpvar_7.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_10;
  tmpvar_10.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_9.x);
  tmpvar_10.y = (tmpvar_9.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_Normal01, tmpvar_8);
  mediump vec4 packednormal_12;
  packednormal_12 = tmpvar_11;
  mediump vec3 normal_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = ((packednormal_12.xyz * 2.0) - 1.0);
  normal_13.z = tmpvar_14.z;
  normal_13.xy = (tmpvar_14.xy * _NormalMapScale);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_Normal02, tmpvar_10);
  mediump vec4 packednormal_16;
  packednormal_16 = tmpvar_15;
  mediump vec3 normal_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = ((packednormal_16.xyz * 2.0) - 1.0);
  normal_17.z = tmpvar_18.z;
  normal_17.xy = (tmpvar_18.xy * _NormalMapScale);
  mediump vec3 tmpvar_19;
  tmpvar_19 = (normal_13 + normal_17);
  temp_output_17_0_6 = tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_21;
  z_21 = tmpvar_20.x;
  highp vec4 tmpvar_22;
  tmpvar_22.zw = vec2(0.0, 0.0);
  tmpvar_22.xy = (((
    (temp_output_17_0_6.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_21) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_23;
  tmpvar_23 = (tmpvar_22 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_24;
  tmpvar_24 = texture2DProj (_CustomDepthTexture, tmpvar_23);
  highp float z_25;
  z_25 = tmpvar_24.x;
  highp vec4 tmpvar_26;
  tmpvar_26 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_25) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_22) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2DProj (_CustomDepthTexture, tmpvar_26);
  highp float z_28;
  z_28 = tmpvar_27.x;
  highp float tmpvar_29;
  tmpvar_29 = ((1.0/((
    (_ZBufferParams.z * z_28)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_5 = _LightColor0;
  highp float tmpvar_30;
  tmpvar_30 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_31;
  tmpvar_31 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_4 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_33;
    tmpvar_33.y = 1.0;
    tmpvar_33.x = temp_output_17_0_6.x;
    tmpvar_33.z = temp_output_17_0_6.y;
    specColor183_4 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_33), normalize((_ES_SunDirection + tmpvar_32)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_5.xyz) * clamp (
      (((tmpvar_29 - 1.0) * 0.1) * tmpvar_30)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_31))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_34;
  tmpvar_34 = pow (max (clamp (
    (tmpvar_29 * tmpvar_30)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = _ES_SunDirection;
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = tmpvar_31;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_38;
  z_38 = tmpvar_37.x;
  highp vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((1.0/((
    (_ZBufferParams.x * z_38)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_40;
  tmpvar_40 = (unity_CameraToWorld * tmpvar_39);
  highp vec2 tmpvar_41;
  tmpvar_41 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_42;
  tmpvar_42 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (tmpvar_41 + tmpvar_42);
  tmpvar_43 = texture2D (_CausticTex, P_44);
  tex2DNode345_3 = tmpvar_43;
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = ((tmpvar_41 * vec2(1.5, 1.5)) - tmpvar_42);
  tmpvar_45 = texture2D (_CausticTex, P_46);
  tex2DNode353_2 = tmpvar_45;
  highp vec4 tmpvar_47;
  tmpvar_47.w = 0.0;
  tmpvar_47.xyz = (ase_lightColor_5.xyz * clamp (dot (tmpvar_35, tmpvar_36), 0.0, 1.0));
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = ((_CausticTiling * (tmpvar_40.xz / tmpvar_40.w)) + (_CausticDistortionValue * mix (tex2DNode345_3.yz, tex2DNode353_2.yz, vec2(0.6, 0.6))));
  tmpvar_48 = texture2D (_CausticTex, P_49);
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (tmpvar_26 / xlv_TEXCOORD2.w).xy;
  tmpvar_50 = texture2D (_RefractionTex, P_51);
  highp vec4 tmpvar_52;
  tmpvar_52 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_34)) * ((
    ((((tmpvar_47 * _CausticColor) * (_CausticIntensity * tmpvar_48.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_29), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_29 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_50));
  mediump float tmpvar_53;
  highp float tmpvar_54;
  tmpvar_54 = clamp ((tmpvar_29 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_53 = tmpvar_54;
  highp vec4 tmpvar_55;
  tmpvar_55.w = 0.0;
  tmpvar_55.xyz = specColor183_4;
  highp vec3 tmpvar_56;
  tmpvar_56 = (tmpvar_55 + mix (tmpvar_52, mix (tmpvar_52, _DeepColor, vec4(
    pow (max (clamp ((tmpvar_29 * 
      (0.1 / _DeepColorDepth)
    ), 0.0, 1.0), 0.0001), _DeepColorFade)
  )), vec4(tmpvar_34))).xyz;
  aseOutColor_1 = tmpvar_56;
  mediump vec4 tmpvar_57;
  tmpvar_57.xyz = aseOutColor_1;
  tmpvar_57.w = clamp (tmpvar_53, 0.0, 1.0);
  gl_FragData[0] = tmpvar_57;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
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
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode433_2;
  highp vec4 tex2DNode353_3;
  highp vec4 tex2DNode345_4;
  highp vec3 specColor183_5;
  highp vec4 ase_lightColor_6;
  highp vec3 temp_output_17_0_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_8.x);
  tmpvar_9.y = (tmpvar_8.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_10.x);
  tmpvar_11.y = (tmpvar_10.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Normal01, tmpvar_9);
  mediump vec4 packednormal_13;
  packednormal_13 = tmpvar_12;
  mediump vec3 normal_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((packednormal_13.xyz * 2.0) - 1.0);
  normal_14.z = tmpvar_15.z;
  normal_14.xy = (tmpvar_15.xy * _NormalMapScale);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal02, tmpvar_11);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * _NormalMapScale);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (normal_14 + normal_18);
  temp_output_17_0_7 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = (((
    (temp_output_17_0_7.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, tmpvar_24);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_26) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_23) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp float tmpvar_30;
  tmpvar_30 = ((1.0/((
    (_ZBufferParams.z * z_29)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_6 = _LightColor0;
  highp float tmpvar_31;
  tmpvar_31 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_5 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_34;
    tmpvar_34.y = 1.0;
    tmpvar_34.x = temp_output_17_0_7.x;
    tmpvar_34.z = temp_output_17_0_7.y;
    specColor183_5 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_34), normalize((_ES_SunDirection + tmpvar_33)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_6.xyz) * clamp (
      (((tmpvar_30 - 1.0) * 0.1) * tmpvar_31)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_32))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_35;
  tmpvar_35 = pow (max (clamp (
    (tmpvar_30 * tmpvar_31)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = _ES_SunDirection;
  highp vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = tmpvar_32;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_39;
  z_39 = tmpvar_38.x;
  highp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((1.0/((
    (_ZBufferParams.x * z_39)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_CameraToWorld * tmpvar_40);
  highp vec2 tmpvar_42;
  tmpvar_42 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_43;
  tmpvar_43 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (tmpvar_42 + tmpvar_43);
  tmpvar_44 = texture2D (_CausticTex, P_45);
  tex2DNode345_4 = tmpvar_44;
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((tmpvar_42 * vec2(1.5, 1.5)) - tmpvar_43);
  tmpvar_46 = texture2D (_CausticTex, P_47);
  tex2DNode353_3 = tmpvar_46;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 0.0;
  tmpvar_48.xyz = (ase_lightColor_6.xyz * clamp (dot (tmpvar_36, tmpvar_37), 0.0, 1.0));
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((_CausticTiling * (tmpvar_41.xz / tmpvar_41.w)) + (_CausticDistortionValue * mix (tex2DNode345_4.yz, tex2DNode353_3.yz, vec2(0.6, 0.6))));
  tmpvar_49 = texture2D (_CausticTex, P_50);
  lowp vec4 tmpvar_51;
  highp vec2 P_52;
  P_52 = (tmpvar_27 / xlv_TEXCOORD2.w).xy;
  tmpvar_51 = texture2D (_RefractionTex, P_52);
  highp vec4 tmpvar_53;
  tmpvar_53 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_35)) * ((
    ((((tmpvar_48 * _CausticColor) * (_CausticIntensity * tmpvar_49.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_30), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_30 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_51));
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  tmpvar_54.xyz = temp_output_17_0_7;
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((
    ((tmpvar_54 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD2.w))
   * 
    clamp ((tmpvar_30 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD2) / xlv_TEXCOORD2.w).xy;
  tmpvar_55 = texture2D (_ReflectionTex, P_56);
  tex2DNode433_2 = tmpvar_55;
  mediump float tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((tmpvar_30 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_57 = tmpvar_58;
  highp vec4 tmpvar_59;
  tmpvar_59.w = 0.0;
  tmpvar_59.xyz = specColor183_5;
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_59 + mix (tmpvar_53, mix (
    mix (tmpvar_53, _DeepColor, vec4(pow (max (clamp (
      (tmpvar_30 * (0.1 / _DeepColorDepth))
    , 0.0, 1.0), 0.0001), _DeepColorFade)))
  , tex2DNode433_2, vec4(
    clamp (((_ReflectionIntensity * pow (
      max ((1.0 - dot (normalize(
        (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
      ), temp_output_17_0_7)), 0.0001)
    , _FresnelPower)) * clamp ((tmpvar_30 * 
      (1.0/(_ShoreReflectionFade))
    ), 0.0, 1.0)), 0.0, 1.0)
  )), vec4(tmpvar_35))).xyz;
  aseOutColor_1 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = aseOutColor_1;
  tmpvar_61.w = clamp (tmpvar_57, 0.0, 1.0);
  gl_FragData[0] = tmpvar_61;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
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
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode433_2;
  highp vec4 tex2DNode353_3;
  highp vec4 tex2DNode345_4;
  highp vec3 specColor183_5;
  highp vec4 ase_lightColor_6;
  highp vec3 temp_output_17_0_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_8.x);
  tmpvar_9.y = (tmpvar_8.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_10.x);
  tmpvar_11.y = (tmpvar_10.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Normal01, tmpvar_9);
  mediump vec4 packednormal_13;
  packednormal_13 = tmpvar_12;
  mediump vec3 normal_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((packednormal_13.xyz * 2.0) - 1.0);
  normal_14.z = tmpvar_15.z;
  normal_14.xy = (tmpvar_15.xy * _NormalMapScale);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal02, tmpvar_11);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * _NormalMapScale);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (normal_14 + normal_18);
  temp_output_17_0_7 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = (((
    (temp_output_17_0_7.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, tmpvar_24);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_26) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_23) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp float tmpvar_30;
  tmpvar_30 = ((1.0/((
    (_ZBufferParams.z * z_29)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_6 = _LightColor0;
  highp float tmpvar_31;
  tmpvar_31 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_5 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_34;
    tmpvar_34.y = 1.0;
    tmpvar_34.x = temp_output_17_0_7.x;
    tmpvar_34.z = temp_output_17_0_7.y;
    specColor183_5 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_34), normalize((_ES_SunDirection + tmpvar_33)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_6.xyz) * clamp (
      (((tmpvar_30 - 1.0) * 0.1) * tmpvar_31)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_32))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_35;
  tmpvar_35 = pow (max (clamp (
    (tmpvar_30 * tmpvar_31)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = _ES_SunDirection;
  highp vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = tmpvar_32;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_39;
  z_39 = tmpvar_38.x;
  highp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((1.0/((
    (_ZBufferParams.x * z_39)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_CameraToWorld * tmpvar_40);
  highp vec2 tmpvar_42;
  tmpvar_42 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_43;
  tmpvar_43 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (tmpvar_42 + tmpvar_43);
  tmpvar_44 = texture2D (_CausticTex, P_45);
  tex2DNode345_4 = tmpvar_44;
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((tmpvar_42 * vec2(1.5, 1.5)) - tmpvar_43);
  tmpvar_46 = texture2D (_CausticTex, P_47);
  tex2DNode353_3 = tmpvar_46;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 0.0;
  tmpvar_48.xyz = (ase_lightColor_6.xyz * clamp (dot (tmpvar_36, tmpvar_37), 0.0, 1.0));
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((_CausticTiling * (tmpvar_41.xz / tmpvar_41.w)) + (_CausticDistortionValue * mix (tex2DNode345_4.yz, tex2DNode353_3.yz, vec2(0.6, 0.6))));
  tmpvar_49 = texture2D (_CausticTex, P_50);
  lowp vec4 tmpvar_51;
  highp vec2 P_52;
  P_52 = (tmpvar_27 / xlv_TEXCOORD2.w).xy;
  tmpvar_51 = texture2D (_RefractionTex, P_52);
  highp vec4 tmpvar_53;
  tmpvar_53 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_35)) * ((
    ((((tmpvar_48 * _CausticColor) * (_CausticIntensity * tmpvar_49.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_30), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_30 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_51));
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  tmpvar_54.xyz = temp_output_17_0_7;
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((
    ((tmpvar_54 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD2.w))
   * 
    clamp ((tmpvar_30 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD2) / xlv_TEXCOORD2.w).xy;
  tmpvar_55 = texture2D (_ReflectionTex, P_56);
  tex2DNode433_2 = tmpvar_55;
  mediump float tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((tmpvar_30 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_57 = tmpvar_58;
  highp vec4 tmpvar_59;
  tmpvar_59.w = 0.0;
  tmpvar_59.xyz = specColor183_5;
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_59 + mix (tmpvar_53, mix (
    mix (tmpvar_53, _DeepColor, vec4(pow (max (clamp (
      (tmpvar_30 * (0.1 / _DeepColorDepth))
    , 0.0, 1.0), 0.0001), _DeepColorFade)))
  , tex2DNode433_2, vec4(
    clamp (((_ReflectionIntensity * pow (
      max ((1.0 - dot (normalize(
        (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
      ), temp_output_17_0_7)), 0.0001)
    , _FresnelPower)) * clamp ((tmpvar_30 * 
      (1.0/(_ShoreReflectionFade))
    ), 0.0, 1.0)), 0.0, 1.0)
  )), vec4(tmpvar_35))).xyz;
  aseOutColor_1 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = aseOutColor_1;
  tmpvar_61.w = clamp (tmpvar_57, 0.0, 1.0);
  gl_FragData[0] = tmpvar_61;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  highp vec4 o_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = (tmpvar_8 * 0.5);
  highp vec2 tmpvar_12;
  tmpvar_12.x = tmpvar_11.x;
  tmpvar_12.y = (tmpvar_11.y * _ProjectionParams.x);
  o_10.xy = (tmpvar_12 + tmpvar_11.w);
  o_10.zw = tmpvar_8.zw;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_glesNormal * tmpvar_13));
  tmpvar_4.xyz = tmpvar_14;
  tmpvar_5.xyz = (((unity_MatrixV * unity_ObjectToWorld) * _glesVertex).xyz * vec3(-1.0, -1.0, 1.0));
  highp vec4 tmpvar_15;
  tmpvar_15.w = 1.0;
  tmpvar_15.xyz = tmpvar_1.xyz;
  tmpvar_2.z = -((unity_MatrixV * (unity_ObjectToWorld * tmpvar_15)).z);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  tmpvar_6.xyz = tmpvar_17;
  tmpvar_7.xyz = (((tmpvar_14.yzx * tmpvar_17.zxy) - (tmpvar_14.zxy * tmpvar_17.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.xy = _glesMultiTexCoord0.xy;
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_6.w = 0.0;
  tmpvar_7.w = 0.0;
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_18));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_10;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = tmpvar_5;
  xlv_TEXCOORD6 = tmpvar_6;
  xlv_TEXCOORD7 = tmpvar_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp mat4 unity_CameraToWorld;
uniform lowp vec4 _LightColor0;
uniform sampler2D _CustomDepthTexture;
uniform mediump float _NormalMapScale;
uniform sampler2D _Normal01;
uniform highp float _Normal01_U_Speed;
uniform highp vec4 _Normal01_ST;
uniform highp float _Normal01_V_Speed;
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
uniform highp vec4 _CausticColor;
uniform highp float _CausticIntensity;
uniform sampler2D _CausticTex;
uniform highp float _CausticTiling;
uniform highp float _CausticDistortionValue;
uniform highp float _CausticDistortionTiling;
uniform highp float _CausticDistortionSpeed;
uniform highp float _CausticFade;
uniform highp float _CausticFadePower;
uniform highp float _CausticDepth;
uniform highp float _CausticDistance;
uniform highp float _CausticOffset;
uniform sampler2D _RefractionTex;
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
uniform mediump float _UseSundir;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec4 tex2DNode433_2;
  highp vec4 tex2DNode353_3;
  highp vec4 tex2DNode345_4;
  highp vec3 specColor183_5;
  highp vec4 ase_lightColor_6;
  highp vec3 temp_output_17_0_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = ((xlv_TEXCOORD1.xy * _Normal01_ST.xy) + _Normal01_ST.zw);
  highp vec2 tmpvar_9;
  tmpvar_9.x = ((_Time.y * _Normal01_U_Speed) + tmpvar_8.x);
  tmpvar_9.y = (tmpvar_8.y + (_Time.y * _Normal01_V_Speed));
  highp vec2 tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.xy * _Normal02_ST.xy) + _Normal02_ST.zw);
  highp vec2 tmpvar_11;
  tmpvar_11.x = ((_Time.y * _Normal02_U_Speed) + tmpvar_10.x);
  tmpvar_11.y = (tmpvar_10.y + (_Time.y * _Normal02_V_Speed));
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_Normal01, tmpvar_9);
  mediump vec4 packednormal_13;
  packednormal_13 = tmpvar_12;
  mediump vec3 normal_14;
  mediump vec3 tmpvar_15;
  tmpvar_15 = ((packednormal_13.xyz * 2.0) - 1.0);
  normal_14.z = tmpvar_15.z;
  normal_14.xy = (tmpvar_15.xy * _NormalMapScale);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_Normal02, tmpvar_11);
  mediump vec4 packednormal_17;
  packednormal_17 = tmpvar_16;
  mediump vec3 normal_18;
  mediump vec3 tmpvar_19;
  tmpvar_19 = ((packednormal_17.xyz * 2.0) - 1.0);
  normal_18.z = tmpvar_19.z;
  normal_18.xy = (tmpvar_19.xy * _NormalMapScale);
  mediump vec3 tmpvar_20;
  tmpvar_20 = (normal_14 + normal_18);
  temp_output_17_0_7 = tmpvar_20;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = (((
    (temp_output_17_0_7.xy * _RefractionIntensity)
   * 
    clamp ((4.0 * (1.0/(xlv_TEXCOORD2.w))), 0.0, 1.0)
  ) * xlv_TEXCOORD2.w) * clamp ((
    (1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w)))
   - xlv_TEXCOORD2.w), 0.0, 1.0));
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_23 + xlv_TEXCOORD2);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_CustomDepthTexture, tmpvar_24);
  highp float z_26;
  z_26 = tmpvar_25.x;
  highp vec4 tmpvar_27;
  tmpvar_27 = ((clamp (
    ((1.0/(((_ZBufferParams.z * z_26) + _ZBufferParams.w))) - xlv_TEXCOORD2.w)
  , 0.0, 1.0) * tmpvar_23) + xlv_TEXCOORD2);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2DProj (_CustomDepthTexture, tmpvar_27);
  highp float z_29;
  z_29 = tmpvar_28.x;
  highp float tmpvar_30;
  tmpvar_30 = ((1.0/((
    (_ZBufferParams.z * z_29)
   + _ZBufferParams.w))) - xlv_TEXCOORD2.w);
  ase_lightColor_6 = _LightColor0;
  highp float tmpvar_31;
  tmpvar_31 = (1.0/(_ShoreTransparency));
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(xlv_TEXCOORD4.xyz);
  highp vec3 tmpvar_33;
  tmpvar_33 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  specColor183_5 = vec3(0.0, 0.0, 0.0);
  if ((_UseSundir > 0.0)) {
    highp vec3 tmpvar_34;
    tmpvar_34.y = 1.0;
    tmpvar_34.x = temp_output_17_0_7.x;
    tmpvar_34.z = temp_output_17_0_7.y;
    specColor183_5 = (((
      clamp ((_SpecularIntensity * pow (max (
        dot (normalize(tmpvar_34), normalize((_ES_SunDirection + tmpvar_33)))
      , 0.0001), (_Gloss * 128.0))), 0.0, 16.0)
     * ase_lightColor_6.xyz) * clamp (
      (((tmpvar_30 - 1.0) * 0.1) * tmpvar_31)
    , 0.0, 1.0)) * pow (max (
      (1.0 - dot (normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)), tmpvar_32))
    , 0.0001), _SpecularPower));
  };
  highp float tmpvar_35;
  tmpvar_35 = pow (max (clamp (
    (tmpvar_30 * tmpvar_31)
  , 0.0, 1.0), 0.0001), _ShoreFade);
  highp vec4 tmpvar_36;
  tmpvar_36.w = 0.0;
  tmpvar_36.xyz = _ES_SunDirection;
  highp vec4 tmpvar_37;
  tmpvar_37.w = 0.0;
  tmpvar_37.xyz = tmpvar_32;
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_39;
  z_39 = tmpvar_38.x;
  highp vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = ((1.0/((
    (_ZBufferParams.x * z_39)
   + _ZBufferParams.y))) * (xlv_TEXCOORD5.xyz * (_ProjectionParams.z / xlv_TEXCOORD5.z)));
  highp vec4 tmpvar_41;
  tmpvar_41 = (unity_CameraToWorld * tmpvar_40);
  highp vec2 tmpvar_42;
  tmpvar_42 = (xlv_TEXCOORD1.xy * vec2((_CausticDistortionTiling * 200.0)));
  highp float tmpvar_43;
  tmpvar_43 = (_Time.y * _CausticDistortionSpeed);
  lowp vec4 tmpvar_44;
  highp vec2 P_45;
  P_45 = (tmpvar_42 + tmpvar_43);
  tmpvar_44 = texture2D (_CausticTex, P_45);
  tex2DNode345_4 = tmpvar_44;
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = ((tmpvar_42 * vec2(1.5, 1.5)) - tmpvar_43);
  tmpvar_46 = texture2D (_CausticTex, P_47);
  tex2DNode353_3 = tmpvar_46;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 0.0;
  tmpvar_48.xyz = (ase_lightColor_6.xyz * clamp (dot (tmpvar_36, tmpvar_37), 0.0, 1.0));
  lowp vec4 tmpvar_49;
  highp vec2 P_50;
  P_50 = ((_CausticTiling * (tmpvar_41.xz / tmpvar_41.w)) + (_CausticDistortionValue * mix (tex2DNode345_4.yz, tex2DNode353_3.yz, vec2(0.6, 0.6))));
  tmpvar_49 = texture2D (_CausticTex, P_50);
  lowp vec4 tmpvar_51;
  highp vec2 P_52;
  P_52 = (tmpvar_27 / xlv_TEXCOORD2.w).xy;
  tmpvar_51 = texture2D (_RefractionTex, P_52);
  highp vec4 tmpvar_53;
  tmpvar_53 = (mix (vec4(1.0, 1.0, 1.0, 1.0), _ShallowColor, vec4(tmpvar_35)) * ((
    ((((tmpvar_48 * _CausticColor) * (_CausticIntensity * tmpvar_49.x)) * pow (max (
      clamp (((1.0/(_CausticFade)) * tmpvar_30), 0.0, 1.0)
    , 0.0001), _CausticFadePower)) * (1.0 - clamp ((tmpvar_30 * 
      (1.0/(_CausticDepth))
    ), 0.0, 1.0)))
   * 
    (1.0 - clamp (((
      (xlv_TEXCOORD1.z - _ProjectionParams.y)
     - _CausticOffset) / _CausticDistance), 0.0, 1.0))
  ) + tmpvar_51));
  highp vec4 tmpvar_54;
  tmpvar_54.w = 0.0;
  tmpvar_54.xyz = temp_output_17_0_7;
  lowp vec4 tmpvar_55;
  highp vec2 P_56;
  P_56 = (((
    ((tmpvar_54 * _DistortionIntensity) * (_SSRDistortion * xlv_TEXCOORD2.w))
   * 
    clamp ((tmpvar_30 * _SSRDistortion_Shore), 0.0, 1.0)
  ) + xlv_TEXCOORD2) / xlv_TEXCOORD2.w).xy;
  tmpvar_55 = texture2D (_ReflectionTex, P_56);
  tex2DNode433_2 = tmpvar_55;
  mediump float tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp ((tmpvar_30 * (0.1 / _OpacityByDepth)), 0.0, 1.0);
  tmpvar_57 = tmpvar_58;
  highp vec4 tmpvar_59;
  tmpvar_59.w = 0.0;
  tmpvar_59.xyz = specColor183_5;
  highp vec3 tmpvar_60;
  tmpvar_60 = (tmpvar_59 + mix (tmpvar_53, mix (
    mix (tmpvar_53, _DeepColor, vec4(pow (max (clamp (
      (tmpvar_30 * (0.1 / _DeepColorDepth))
    , 0.0, 1.0), 0.0001), _DeepColorFade)))
  , tex2DNode433_2, vec4(
    clamp (((_ReflectionIntensity * pow (
      max ((1.0 - dot (normalize(
        (_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz)
      ), temp_output_17_0_7)), 0.0001)
    , _FresnelPower)) * clamp ((tmpvar_30 * 
      (1.0/(_ShoreReflectionFade))
    ), 0.0, 1.0)), 0.0, 1.0)
  )), vec4(tmpvar_35))).xyz;
  aseOutColor_1 = tmpvar_60;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = aseOutColor_1;
  tmpvar_61.w = clamp (tmpvar_57, 0.0, 1.0);
  gl_FragData[0] = tmpvar_61;
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
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_USE_REFLECTION" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_USE_REFLECTION" }
""
}
}
}
}
}