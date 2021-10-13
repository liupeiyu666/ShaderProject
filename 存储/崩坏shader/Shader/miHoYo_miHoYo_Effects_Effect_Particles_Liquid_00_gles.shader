//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Liquid_00" {
Properties {
_LiquidTex ("LiquidTex", 2D) = "white" { }
_Normalmap ("Normalmap", 2D) = "bump" { }
_NormalBrightness ("NormalBrightness", Range(-1, 4)) = 1
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap ("Matcap", 2D) = "white" { }
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 2
_Color ("Color", Color) = (1.5,1.5,1.5,0)
[Toggle] _UspeedToggle ("UspeedToggle", Float) = 0
_Uspeed ("Uspeed", Float) = 0
[Toggle] _MaskTexToggle ("MaskTexToggle", Float) = 0
_TextureMask ("TextureMask", 2D) = "white" { }
[Toggle] _NoiseToggle ("NoiseToggle", Float) = 0
[Toggle] _NoiseRandomToggle ("NoiseRandomToggle", Float) = 0
_Noise_Tex ("Noise_Tex", 2D) = "white" { }
_Noise_Uspeed ("Noise_Uspeed", Float) = 0
_Noise_Vspeed ("Noise_Vspeed", Float) = 0
_Noise_Offset ("Noise_Offset", Float) = 0.5
_Noise_Brightness ("Noise_Brightness", Float) = 0.1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
_texcoord2 ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 19871
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  tmpvar_4.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_4.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp vec4 _Color;
uniform sampler2D _Matcap;
uniform sampler2D _Normalmap;
uniform highp float _NoiseToggle;
uniform sampler2D _Noise_Tex;
uniform highp float _NoiseRandomToggle;
uniform highp float _Noise_Uspeed;
uniform highp vec4 _Noise_Tex_ST;
uniform highp float _Noise_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _Noise_Brightness;
uniform highp vec4 _Normalmap_ST;
uniform highp float _UspeedToggle;
uniform highp float _Uspeed;
uniform highp float _NormalBrightness;
uniform highp float _MatcapSize;
uniform highp vec4 _DayColor;
uniform sampler2D _LiquidTex;
uniform highp vec4 _LiquidTex_ST;
uniform highp float _MaskTexToggle;
uniform sampler2D _TextureMask;
uniform highp vec4 _TextureMask_ST;
uniform highp float _AlphaBrightness;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec3 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_4 = xlv_TEXCOORD1.xyz;
  tmpvar_5 = xlv_TEXCOORD2.xyz;
  tmpvar_6 = xlv_TEXCOORD3.xyz;
  tmpvar_7 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = tmpvar_2;
  tmpvar_9 = tmpvar_3;
  highp float ifLocalVar119_10;
  highp float staticSwitch264_11;
  highp vec4 tex2DNode151_12;
  highp vec4 tex2DNode86_13;
  highp vec2 staticSwitch265_14;
  highp float staticSwitch266_15;
  highp vec2 staticSwitch267_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _Noise_Tex_ST.xy) + _Noise_Tex_ST.zw);
  highp vec2 tmpvar_18;
  tmpvar_18.x = ((_Time.y * _Noise_Uspeed) + tmpvar_17.x);
  tmpvar_18.y = (tmpvar_17.y + (_Time.y * _Noise_Vspeed));
  staticSwitch267_16 = vec2(0.0, 0.0);
  if ((_NoiseRandomToggle == 1.0)) {
    staticSwitch267_16 = (tmpvar_18 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch267_16 = tmpvar_18;
  };
  staticSwitch266_15 = 0.0;
  if ((_NoiseToggle == 1.0)) {
    lowp vec4 tmpvar_19;
    tmpvar_19 = texture2D (_Noise_Tex, staticSwitch267_16);
    staticSwitch266_15 = ((tmpvar_19.x - _Noise_Offset) * _Noise_Brightness);
  } else {
    staticSwitch266_15 = 0.0;
  };
  highp vec2 tmpvar_20;
  tmpvar_20 = ((xlv_TEXCOORD0.xy * _Normalmap_ST.xy) + _Normalmap_ST.zw);
  highp float tmpvar_21;
  tmpvar_21 = (_Time.y * _Uspeed);
  staticSwitch265_14 = vec2(0.0, 0.0);
  if ((_UspeedToggle == 1.0)) {
    staticSwitch265_14 = (tmpvar_21 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch265_14 = vec2(0.0, 0.0);
  };
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_20.x + staticSwitch265_14).x;
  tmpvar_22.y = tmpvar_20.y;
  highp float tmpvar_23;
  tmpvar_23 = (1.0 - tmpvar_7.w);
  highp vec2 P_24;
  P_24 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_25;
  tmpvar_25 = ((texture2D (_Normalmap, P_24).xyz * 2.0) - 1.0);
  highp vec2 P_26;
  P_26 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_27;
  tmpvar_27 = ((texture2D (_Normalmap, P_26).xyz * 2.0) - 1.0);
  highp vec2 P_28;
  P_28 = (staticSwitch266_15 + tmpvar_22);
  lowp vec3 tmpvar_29;
  tmpvar_29 = ((texture2D (_Normalmap, P_28).xyz * 2.0) - 1.0);
  highp vec3 tmpvar_30;
  tmpvar_30.x = dot (tmpvar_4, (tmpvar_25 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.y = dot (tmpvar_5, (tmpvar_27 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  tmpvar_30.z = dot (tmpvar_6, (tmpvar_29 * (1.0 + 
    (_NormalBrightness * tmpvar_23)
  )));
  highp mat3 tmpvar_31;
  tmpvar_31[0] = unity_MatrixV[0].xyz;
  tmpvar_31[1] = unity_MatrixV[1].xyz;
  tmpvar_31[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (((
    (tmpvar_31 * tmpvar_30)
  .xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_32 = texture2D (_Matcap, P_33);
  tex2DNode86_13 = tmpvar_32;
  highp vec4 tmpvar_34;
  tmpvar_34 = clamp ((_ColorBrightness * (_Color * tex2DNode86_13)), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.05, 1.05, 1.05, 1.05));
  tmpvar_8 = (tmpvar_34 * _DayColor).xyz;
  highp vec2 tmpvar_35;
  tmpvar_35 = ((xlv_TEXCOORD0.xy * _LiquidTex_ST.xy) + _LiquidTex_ST.zw);
  highp vec2 tmpvar_36;
  tmpvar_36.x = (staticSwitch265_14 + tmpvar_35.x).x;
  tmpvar_36.y = tmpvar_35.y;
  lowp vec4 tmpvar_37;
  highp vec2 P_38;
  P_38 = (staticSwitch266_15 + tmpvar_36);
  tmpvar_37 = texture2D (_LiquidTex, P_38);
  tex2DNode151_12 = tmpvar_37;
  highp vec2 tmpvar_39;
  tmpvar_39 = ((xlv_TEXCOORD0.xy * _TextureMask_ST.xy) + _TextureMask_ST.zw);
  staticSwitch264_11 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_40;
    tmpvar_40 = texture2D (_TextureMask, tmpvar_39);
    staticSwitch264_11 = (tex2DNode151_12.x * tmpvar_40.x);
  } else {
    staticSwitch264_11 = tex2DNode151_12.x;
  };
  ifLocalVar119_10 = 0.0;
  if ((staticSwitch264_11 <= tmpvar_23)) {
    ifLocalVar119_10 = 0.0;
  } else {
    ifLocalVar119_10 = 1.0;
  };
  highp float tmpvar_41;
  tmpvar_41 = clamp (((_DayColor.w * tex2DNode151_12.y) * (
    (ifLocalVar119_10 * _AlphaBrightness)
   * tmpvar_7.x)), 0.0, 1.0);
  tmpvar_9 = tmpvar_41;
  tmpvar_2 = tmpvar_8;
  tmpvar_3 = tmpvar_9;
  lowp vec4 tmpvar_42;
  tmpvar_42.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_42.w = tmpvar_9;
  c_1.w = tmpvar_42.w;
  c_1.xyz = tmpvar_8;
  gl_FragData[0] = c_1;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}