//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCRefDepV1" {
Properties {
_BloomFactor ("Bloom Factor", Float) = 1
_MainColor ("MainColor", Color) = (0.9044118,0.9044118,0.9044118,0)
_ChromaticAberration ("ChromaticAberration", Range(-0.5, 0.5)) = 0.05
_ChromaticAberrationIndensity ("ChromaticAberrationIndensity", Float) = -20
_Opacity ("Opacity", Range(0, 1)) = 1
_FresnelPower ("Fresnel Power", Float) = 0
_FresnelScale ("Fresnel Scale", Float) = 0
_FresnelReFrection ("FresnelReFrection", Vector) = (0,1,5,0)
_DepthFadeTex ("DepthFadeTex", 2D) = "white" { }
_Depth ("Depth", Float) = 0.68
_DepthFadeColor1 ("DepthFadeColor1", Color) = (0,0.6542087,0.9779412,0)
_DepthFadeColor1Indensity ("DepthFadeColor1Indensity", Float) = 1
_DepthFadeColor2 ("DepthFadeColor2", Color) = (0.02205884,0.6358014,1,0)
_DepthFadeColor2Indensity ("DepthFadeColor2Indensity", Float) = 15
_RimColor ("RimColor", Color) = (0,0.462069,1,0)
_RimColorIndensity ("RimColorIndensity", Float) = 4
_DisTexture ("DisTexture", 2D) = "white" { }
_DisAmount ("DisAmount", Range(0, 2)) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 61501
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  tmpvar_4.xyz = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
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
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = o_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _DisAmount;
uniform sampler2D _DisTexture;
uniform highp vec4 _DisTexture_ST;
uniform mediump float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec3 _FresnelReFrection;
uniform highp float _ChromaticAberration;
uniform highp float _ChromaticAberrationIndensity;
uniform highp vec4 _MainColor;
uniform highp float _FresnelScale;
uniform highp float _FresnelPower;
uniform highp vec4 _RimColor;
uniform highp float _RimColorIndensity;
uniform sampler2D _CameraDepthTexture;
uniform mediump float _Depth;
uniform mediump vec4 _DepthFadeColor1;
uniform highp float _DepthFadeColor1Indensity;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform mediump vec4 _DepthFadeColor2;
uniform highp float _DepthFadeColor2Indensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode127_3;
  highp vec4 ase_screenPosNorm138_4;
  highp vec4 screenColor85_5;
  highp vec4 screenColor103_6;
  highp vec4 screenColor45_7;
  highp vec4 screenColor13_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp float tmpvar_11;
  tmpvar_11 = (_FresnelReFrection.x + (_FresnelReFrection.y * pow (
    (1.0 - dot (xlv_TEXCOORD4.xyz, tmpvar_10))
  , _FresnelReFrection.z)));
  highp vec4 o_12;
  o_12.xzw = xlv_TEXCOORD5.xzw;
  o_12.y = (xlv_TEXCOORD5.w * 0.5);
  o_12.y = (((xlv_TEXCOORD5.y - o_12.y) * _ProjectionParams.x) + o_12.y);
  highp vec4 tmpvar_13;
  tmpvar_13 = (o_12 / xlv_TEXCOORD5.w);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (tmpvar_11 + tmpvar_13).xy;
  tmpvar_14 = texture2D (_BeforeAlphaTexture, P_15);
  screenColor13_8 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.x = (tmpvar_13.x + _ChromaticAberration);
  tmpvar_16.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_11 + tmpvar_16).xy;
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  screenColor45_7 = tmpvar_17;
  highp vec4 tmpvar_19;
  tmpvar_19.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_19.x = (1.0 - screenColor45_7.x);
  highp vec4 tmpvar_20;
  tmpvar_20.x = ((tmpvar_13.x + _ChromaticAberration) + 0.06);
  tmpvar_20.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_11 + tmpvar_20).xy;
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  screenColor103_6 = tmpvar_21;
  highp vec4 tmpvar_23;
  tmpvar_23.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_23.x = (1.0 - screenColor103_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24.x = ((tmpvar_13.x + _ChromaticAberration) + 0.03);
  tmpvar_24.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_11 + tmpvar_24).xy;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, P_26);
  screenColor85_5 = tmpvar_25;
  highp vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_27.x = (1.0 - screenColor85_5.x);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.x = clamp ((tmpvar_19 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.y = clamp ((tmpvar_23 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.z = clamp ((tmpvar_27 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  highp float tmpvar_29;
  tmpvar_29 = (_FresnelScale * pow ((1.0 - 
    dot (xlv_TEXCOORD4.xyz, tmpvar_10)
  ), _FresnelPower));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (screenColor13_8 + tmpvar_28).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (xlv_TEXCOORD6 / xlv_TEXCOORD6.w);
  ase_screenPosNorm138_4.xyw = tmpvar_31.xyw;
  ase_screenPosNorm138_4.z = ((tmpvar_31.z * 0.5) + 0.5);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6);
  highp float z_33;
  z_33 = tmpvar_32.x;
  highp float tmpvar_34;
  tmpvar_34 = abs(((
    (1.0/(((_ZBufferParams.z * z_33) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm138_4.z) + _ZBufferParams.w)))
  ) / _Depth));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DepthFadeTex, tmpvar_35);
  tex2DNode127_3 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DisTexture, tmpvar_9);
  highp float tmpvar_38;
  tmpvar_38 = (float((tmpvar_37.x >= _DisAmount)) * _Opacity);
  aseOutAlpha_2 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (mix ((tmpvar_30 * _MainColor), (
    (tmpvar_29 * _RimColor)
   * _RimColorIndensity), vec4(tmpvar_29)) + ((
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (_DepthFadeColor1 * _DepthFadeColor1Indensity)
  ) + (
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (tex2DNode127_3 + (_DepthFadeColor2 * _DepthFadeColor2Indensity))
  ))).xyz;
  aseOutColor_1 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = aseOutColor_1;
  tmpvar_41.w = tmpvar_40;
  gl_FragData[0] = tmpvar_41;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  tmpvar_4.xyz = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
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
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = o_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _DisAmount;
uniform sampler2D _DisTexture;
uniform highp vec4 _DisTexture_ST;
uniform mediump float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec3 _FresnelReFrection;
uniform highp float _ChromaticAberration;
uniform highp float _ChromaticAberrationIndensity;
uniform highp vec4 _MainColor;
uniform highp float _FresnelScale;
uniform highp float _FresnelPower;
uniform highp vec4 _RimColor;
uniform highp float _RimColorIndensity;
uniform sampler2D _CameraDepthTexture;
uniform mediump float _Depth;
uniform mediump vec4 _DepthFadeColor1;
uniform highp float _DepthFadeColor1Indensity;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform mediump vec4 _DepthFadeColor2;
uniform highp float _DepthFadeColor2Indensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode127_3;
  highp vec4 ase_screenPosNorm138_4;
  highp vec4 screenColor85_5;
  highp vec4 screenColor103_6;
  highp vec4 screenColor45_7;
  highp vec4 screenColor13_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp float tmpvar_11;
  tmpvar_11 = (_FresnelReFrection.x + (_FresnelReFrection.y * pow (
    (1.0 - dot (xlv_TEXCOORD4.xyz, tmpvar_10))
  , _FresnelReFrection.z)));
  highp vec4 o_12;
  o_12.xzw = xlv_TEXCOORD5.xzw;
  o_12.y = (xlv_TEXCOORD5.w * 0.5);
  o_12.y = (((xlv_TEXCOORD5.y - o_12.y) * _ProjectionParams.x) + o_12.y);
  highp vec4 tmpvar_13;
  tmpvar_13 = (o_12 / xlv_TEXCOORD5.w);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (tmpvar_11 + tmpvar_13).xy;
  tmpvar_14 = texture2D (_BeforeAlphaTexture, P_15);
  screenColor13_8 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.x = (tmpvar_13.x + _ChromaticAberration);
  tmpvar_16.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_11 + tmpvar_16).xy;
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  screenColor45_7 = tmpvar_17;
  highp vec4 tmpvar_19;
  tmpvar_19.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_19.x = (1.0 - screenColor45_7.x);
  highp vec4 tmpvar_20;
  tmpvar_20.x = ((tmpvar_13.x + _ChromaticAberration) + 0.06);
  tmpvar_20.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_11 + tmpvar_20).xy;
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  screenColor103_6 = tmpvar_21;
  highp vec4 tmpvar_23;
  tmpvar_23.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_23.x = (1.0 - screenColor103_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24.x = ((tmpvar_13.x + _ChromaticAberration) + 0.03);
  tmpvar_24.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_11 + tmpvar_24).xy;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, P_26);
  screenColor85_5 = tmpvar_25;
  highp vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_27.x = (1.0 - screenColor85_5.x);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.x = clamp ((tmpvar_19 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.y = clamp ((tmpvar_23 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.z = clamp ((tmpvar_27 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  highp float tmpvar_29;
  tmpvar_29 = (_FresnelScale * pow ((1.0 - 
    dot (xlv_TEXCOORD4.xyz, tmpvar_10)
  ), _FresnelPower));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (screenColor13_8 + tmpvar_28).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (xlv_TEXCOORD6 / xlv_TEXCOORD6.w);
  ase_screenPosNorm138_4.xyw = tmpvar_31.xyw;
  ase_screenPosNorm138_4.z = ((tmpvar_31.z * 0.5) + 0.5);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6);
  highp float z_33;
  z_33 = tmpvar_32.x;
  highp float tmpvar_34;
  tmpvar_34 = abs(((
    (1.0/(((_ZBufferParams.z * z_33) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm138_4.z) + _ZBufferParams.w)))
  ) / _Depth));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DepthFadeTex, tmpvar_35);
  tex2DNode127_3 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DisTexture, tmpvar_9);
  highp float tmpvar_38;
  tmpvar_38 = (float((tmpvar_37.x >= _DisAmount)) * _Opacity);
  aseOutAlpha_2 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (mix ((tmpvar_30 * _MainColor), (
    (tmpvar_29 * _RimColor)
   * _RimColorIndensity), vec4(tmpvar_29)) + ((
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (_DepthFadeColor1 * _DepthFadeColor1Indensity)
  ) + (
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (tex2DNode127_3 + (_DepthFadeColor2 * _DepthFadeColor2Indensity))
  ))).xyz;
  aseOutColor_1 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = aseOutColor_1;
  tmpvar_41.w = tmpvar_40;
  gl_FragData[0] = tmpvar_41;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = tmpvar_1.w;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_3.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = unity_WorldToObject[0].xyz;
  tmpvar_5[1] = unity_WorldToObject[1].xyz;
  tmpvar_5[2] = unity_WorldToObject[2].xyz;
  tmpvar_4.xyz = normalize((_glesNormal * tmpvar_5));
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
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
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = tmpvar_2.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_16));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = tmpvar_4;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = o_13;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform highp float _DisAmount;
uniform sampler2D _DisTexture;
uniform highp vec4 _DisTexture_ST;
uniform mediump float _Opacity;
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec3 _FresnelReFrection;
uniform highp float _ChromaticAberration;
uniform highp float _ChromaticAberrationIndensity;
uniform highp vec4 _MainColor;
uniform highp float _FresnelScale;
uniform highp float _FresnelPower;
uniform highp vec4 _RimColor;
uniform highp float _RimColorIndensity;
uniform sampler2D _CameraDepthTexture;
uniform mediump float _Depth;
uniform mediump vec4 _DepthFadeColor1;
uniform highp float _DepthFadeColor1Indensity;
uniform sampler2D _DepthFadeTex;
uniform highp vec4 _DepthFadeTex_ST;
uniform mediump vec4 _DepthFadeColor2;
uniform highp float _DepthFadeColor2Indensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode127_3;
  highp vec4 ase_screenPosNorm138_4;
  highp vec4 screenColor85_5;
  highp vec4 screenColor103_6;
  highp vec4 screenColor45_7;
  highp vec4 screenColor13_8;
  highp vec2 tmpvar_9;
  tmpvar_9 = ((xlv_TEXCOORD0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw);
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp float tmpvar_11;
  tmpvar_11 = (_FresnelReFrection.x + (_FresnelReFrection.y * pow (
    (1.0 - dot (xlv_TEXCOORD4.xyz, tmpvar_10))
  , _FresnelReFrection.z)));
  highp vec4 o_12;
  o_12.xzw = xlv_TEXCOORD5.xzw;
  o_12.y = (xlv_TEXCOORD5.w * 0.5);
  o_12.y = (((xlv_TEXCOORD5.y - o_12.y) * _ProjectionParams.x) + o_12.y);
  highp vec4 tmpvar_13;
  tmpvar_13 = (o_12 / xlv_TEXCOORD5.w);
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (tmpvar_11 + tmpvar_13).xy;
  tmpvar_14 = texture2D (_BeforeAlphaTexture, P_15);
  screenColor13_8 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.x = (tmpvar_13.x + _ChromaticAberration);
  tmpvar_16.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_11 + tmpvar_16).xy;
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  screenColor45_7 = tmpvar_17;
  highp vec4 tmpvar_19;
  tmpvar_19.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_19.x = (1.0 - screenColor45_7.x);
  highp vec4 tmpvar_20;
  tmpvar_20.x = ((tmpvar_13.x + _ChromaticAberration) + 0.06);
  tmpvar_20.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_11 + tmpvar_20).xy;
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  screenColor103_6 = tmpvar_21;
  highp vec4 tmpvar_23;
  tmpvar_23.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_23.x = (1.0 - screenColor103_6.x);
  highp vec4 tmpvar_24;
  tmpvar_24.x = ((tmpvar_13.x + _ChromaticAberration) + 0.03);
  tmpvar_24.yzw = tmpvar_13.yzw;
  lowp vec4 tmpvar_25;
  highp vec2 P_26;
  P_26 = (tmpvar_11 + tmpvar_24).xy;
  tmpvar_25 = texture2D (_BeforeAlphaTexture, P_26);
  screenColor85_5 = tmpvar_25;
  highp vec4 tmpvar_27;
  tmpvar_27.yzw = vec3(0.0, 0.0, 0.0);
  tmpvar_27.x = (1.0 - screenColor85_5.x);
  highp vec4 tmpvar_28;
  tmpvar_28.w = 0.0;
  tmpvar_28.x = clamp ((tmpvar_19 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.y = clamp ((tmpvar_23 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  tmpvar_28.z = clamp ((tmpvar_27 * (tmpvar_11 * _ChromaticAberrationIndensity)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 0.0, 0.0, 0.0)).x;
  highp float tmpvar_29;
  tmpvar_29 = (_FresnelScale * pow ((1.0 - 
    dot (xlv_TEXCOORD4.xyz, tmpvar_10)
  ), _FresnelPower));
  highp vec4 tmpvar_30;
  tmpvar_30.w = 0.0;
  tmpvar_30.xyz = (screenColor13_8 + tmpvar_28).xyz;
  highp vec4 tmpvar_31;
  tmpvar_31 = (xlv_TEXCOORD6 / xlv_TEXCOORD6.w);
  ase_screenPosNorm138_4.xyw = tmpvar_31.xyw;
  ase_screenPosNorm138_4.z = ((tmpvar_31.z * 0.5) + 0.5);
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD6);
  highp float z_33;
  z_33 = tmpvar_32.x;
  highp float tmpvar_34;
  tmpvar_34 = abs(((
    (1.0/(((_ZBufferParams.z * z_33) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm138_4.z) + _ZBufferParams.w)))
  ) / _Depth));
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _DepthFadeTex_ST.xy) + _DepthFadeTex_ST.zw);
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_DepthFadeTex, tmpvar_35);
  tex2DNode127_3 = tmpvar_36;
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_DisTexture, tmpvar_9);
  highp float tmpvar_38;
  tmpvar_38 = (float((tmpvar_37.x >= _DisAmount)) * _Opacity);
  aseOutAlpha_2 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (mix ((tmpvar_30 * _MainColor), (
    (tmpvar_29 * _RimColor)
   * _RimColorIndensity), vec4(tmpvar_29)) + ((
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (_DepthFadeColor1 * _DepthFadeColor1Indensity)
  ) + (
    clamp ((1.0 + ((-2.64 - tmpvar_34) / 4.49)), 0.0, 1.0)
   * 
    (tex2DNode127_3 + (_DepthFadeColor2 * _DepthFadeColor2Indensity))
  ))).xyz;
  aseOutColor_1 = tmpvar_39;
  mediump float tmpvar_40;
  tmpvar_40 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.xyz = aseOutColor_1;
  tmpvar_41.w = tmpvar_40;
  gl_FragData[0] = tmpvar_41;
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
  Name "CONSTANT_MAX"
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 80412
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump float tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_2 = tmpvar_1.w;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp float x_2;
  x_2 = (texture2D (_MainTex, xlv_TEXCOORD0).w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.w = (_BloomFactor * xlv_TEXCOORD1);
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
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "TEXTURE_SCALE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "TEXTURE_SCALE" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}