//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/Ice" {
Properties {
_Highlight_Color ("Highlight_Color", Color) = (0.7334559,0.8970082,0.9779412,1)
_Fresnal_Scale ("Fresnal_Scale", Float) = 6.97
_Fresnal_Power ("Fresnal_Power", Float) = 5.68
_IceLightColor ("IceLightColor", Color) = (0.5073529,0.9692103,1,1)
_IceDarkColor ("IceDarkColor", Color) = (0.1098039,0.1686275,0.172549,1)
_CubeMap ("CubeMap", Cube) = "white" { }
_CubeMapBrightness ("CubeMapBrightness", Float) = 1
_MatCapTex ("MatCapTex", 2D) = "white" { }
_MatCapSize ("MatCapSize", Range(0, 2)) = 1
_MatCapColor ("MatCapColor", Color) = (1,1,1,1)
_NormalMap ("NormalMap", 2D) = "white" { }
_NormalIntensity ("NormalIntensity", Color) = (1,1,0.916,1)
[Toggle(_GRADIENTCOLORTOGGLE_ON)] _GradientColorToggle ("GradientColorToggle", Float) = 0
_GradientColor ("GradientColor", Color) = (0.2352941,0.4304256,1,0)
_GradientRange ("GradientRange", Float) = 1
_GradientOffset ("GradientOffset", Float) = 0
_DayColor ("DayColor", Color) = (1,1,1,1)
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
  Tags { "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 8818
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
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
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
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 staticSwitch133_3;
  highp vec3 tex2DNode19_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(xlv_TEXCOORD3.xyz);
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_NormalMap, tmpvar_6).xyz * 2.0) - 1.0);
  tex2DNode19_4 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = tex2DNode19_4;
  highp vec4 tmpvar_9;
  tmpvar_9 = (_NormalIntensity * tmpvar_8);
  highp vec3 tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_13;
  tmpvar_13.x = tmpvar_10.x;
  tmpvar_13.y = tmpvar_12.x;
  tmpvar_13.z = tmpvar_11.x;
  highp vec3 tmpvar_14;
  tmpvar_14.x = tmpvar_10.y;
  tmpvar_14.y = tmpvar_12.y;
  tmpvar_14.z = tmpvar_11.y;
  highp vec3 tmpvar_15;
  tmpvar_15.x = tmpvar_10.z;
  tmpvar_15.y = tmpvar_12.z;
  tmpvar_15.z = tmpvar_11.z;
  highp vec3 tmpvar_16;
  tmpvar_16.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_16.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_16.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp float tmpvar_17;
  tmpvar_17 = pow (max ((1.0 - 
    dot (tmpvar_16, tmpvar_5)
  ), 0.0001), 3.0);
  highp vec3 tmpvar_18;
  tmpvar_18.x = dot (tmpvar_13, tmpvar_9.xyz);
  tmpvar_18.y = dot (tmpvar_14, tmpvar_9.xyz);
  tmpvar_18.z = dot (tmpvar_15, tmpvar_9.xyz);
  highp vec3 I_19;
  I_19 = -(tmpvar_5);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize((I_19 - (2.0 * 
    (dot (tmpvar_18, I_19) * tmpvar_18)
  )));
  lowp vec4 tmpvar_21;
  tmpvar_21 = textureCube (_CubeMap, tmpvar_20);
  highp vec4 tmpvar_22;
  tmpvar_22 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_21.x * _CubeMapBrightness), 0.0, 1.0)));
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (tmpvar_22, (_GradientColor * tmpvar_22), vec4(clamp ((
    (xlv_TEXCOORD0.xy * vec2(_GradientRange))
   + vec2(_GradientOffset)).y, 0.0, 1.0)));
  staticSwitch133_3 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_GradientColorToggle > 0.0)) {
    staticSwitch133_3 = tmpvar_23;
  } else {
    staticSwitch133_3 = tmpvar_22;
  };
  highp vec3 tmpvar_24;
  tmpvar_24.x = dot (tmpvar_13, tex2DNode19_4);
  tmpvar_24.y = dot (tmpvar_14, tex2DNode19_4);
  tmpvar_24.z = dot (tmpvar_15, tex2DNode19_4);
  highp mat3 tmpvar_25;
  tmpvar_25[0] = unity_MatrixV[0].xyz;
  tmpvar_25[1] = unity_MatrixV[1].xyz;
  tmpvar_25[2] = unity_MatrixV[2].xyz;
  lowp vec4 tmpvar_26;
  highp vec2 P_27;
  P_27 = (((
    (tmpvar_25 * tmpvar_24)
  .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
  tmpvar_26 = texture2D (_MatCapTex, P_27);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((_Highlight_Color * 
    pow (max (clamp ((tmpvar_17 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
  ) + staticSwitch133_3) + (tmpvar_26 * _MatCapColor));
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * _DayColor.w) * xlv_COLOR.w).x;
  aseOutAlpha_2 = tmpvar_29;
  highp vec3 tmpvar_30;
  tmpvar_30 = ((tmpvar_28 * _DayColor) * xlv_COLOR).xyz;
  aseOutColor_1 = tmpvar_30;
  mediump float tmpvar_31;
  tmpvar_31 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_31;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = aseOutColor_1;
  tmpvar_32.w = tmpvar_31;
  gl_FragData[0] = tmpvar_32;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _MHYZBias;
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
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = normalize((_WorldSpaceCameraPos - (unity_ObjectToWorld * _glesVertex).xyz));
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _glesVertex.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  tmpvar_1.xyw = tmpvar_10.xyw;
  tmpvar_1.z = (tmpvar_10.z + (_MHYZBias * tmpvar_10.w));
  gl_Position = tmpvar_1;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform highp vec4 unity_DebugViewInfo;
uniform highp float _GradientColorToggle;
uniform highp vec4 _Highlight_Color;
uniform highp vec4 _NormalIntensity;
uniform sampler2D _NormalMap;
uniform highp vec4 _NormalMap_ST;
uniform highp float _Fresnal_Scale;
uniform highp float _Fresnal_Power;
uniform highp vec4 _IceDarkColor;
uniform highp vec4 _IceLightColor;
uniform lowp samplerCube _CubeMap;
uniform highp float _CubeMapBrightness;
uniform highp vec4 _GradientColor;
uniform highp float _GradientRange;
uniform highp float _GradientOffset;
uniform sampler2D _MatCapTex;
uniform highp float _MatCapSize;
uniform mediump vec4 _MatCapColor;
uniform highp vec4 _DayColor;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec4 tmpvar_1;
  mediump vec3 aseOutColor_2;
  mediump float aseOutAlpha_3;
  highp vec4 staticSwitch133_4;
  highp vec3 tex2DNode19_5;
  if (((unity_DebugViewInfo.x == 100.0) || (unity_DebugViewInfo.x == 102.0))) {
    tmpvar_1 = vec4(0.1, 0.1, 0.1, 0.0);
  } else {
    highp vec3 tmpvar_6;
    tmpvar_6 = normalize(xlv_TEXCOORD3.xyz);
    highp vec2 tmpvar_7;
    tmpvar_7 = ((xlv_TEXCOORD0.xy * _NormalMap_ST.xy) + _NormalMap_ST.zw);
    lowp vec3 tmpvar_8;
    tmpvar_8 = ((texture2D (_NormalMap, tmpvar_7).xyz * 2.0) - 1.0);
    tex2DNode19_5 = tmpvar_8;
    highp vec4 tmpvar_9;
    tmpvar_9.w = 0.0;
    tmpvar_9.xyz = tex2DNode19_5;
    highp vec4 tmpvar_10;
    tmpvar_10 = (_NormalIntensity * tmpvar_9);
    highp vec3 tmpvar_11;
    tmpvar_11 = xlv_TEXCOORD4.xyz;
    highp vec3 tmpvar_12;
    tmpvar_12 = xlv_TEXCOORD5.xyz;
    highp vec3 tmpvar_13;
    tmpvar_13 = xlv_TEXCOORD6.xyz;
    highp vec3 tmpvar_14;
    tmpvar_14.x = tmpvar_11.x;
    tmpvar_14.y = tmpvar_13.x;
    tmpvar_14.z = tmpvar_12.x;
    highp vec3 tmpvar_15;
    tmpvar_15.x = tmpvar_11.y;
    tmpvar_15.y = tmpvar_13.y;
    tmpvar_15.z = tmpvar_12.y;
    highp vec3 tmpvar_16;
    tmpvar_16.x = tmpvar_11.z;
    tmpvar_16.y = tmpvar_13.z;
    tmpvar_16.z = tmpvar_12.z;
    highp vec3 tmpvar_17;
    tmpvar_17.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_17.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_17.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp float tmpvar_18;
    tmpvar_18 = pow (max ((1.0 - 
      dot (tmpvar_17, tmpvar_6)
    ), 0.0001), 3.0);
    highp vec3 tmpvar_19;
    tmpvar_19.x = dot (tmpvar_14, tmpvar_10.xyz);
    tmpvar_19.y = dot (tmpvar_15, tmpvar_10.xyz);
    tmpvar_19.z = dot (tmpvar_16, tmpvar_10.xyz);
    highp vec3 I_20;
    I_20 = -(tmpvar_6);
    highp vec3 tmpvar_21;
    tmpvar_21 = normalize((I_20 - (2.0 * 
      (dot (tmpvar_19, I_20) * tmpvar_19)
    )));
    lowp vec4 tmpvar_22;
    tmpvar_22 = textureCube (_CubeMap, tmpvar_21);
    highp vec4 tmpvar_23;
    tmpvar_23 = mix (_IceDarkColor, _IceLightColor, vec4(clamp ((tmpvar_22.x * _CubeMapBrightness), 0.0, 1.0)));
    highp vec4 tmpvar_24;
    tmpvar_24 = mix (tmpvar_23, (_GradientColor * tmpvar_23), vec4(clamp ((
      (xlv_TEXCOORD0.xy * vec2(_GradientRange))
     + vec2(_GradientOffset)).y, 0.0, 1.0)));
    staticSwitch133_4 = vec4(0.0, 0.0, 0.0, 0.0);
    if ((_GradientColorToggle > 0.0)) {
      staticSwitch133_4 = tmpvar_24;
    } else {
      staticSwitch133_4 = tmpvar_23;
    };
    highp vec3 tmpvar_25;
    tmpvar_25.x = dot (tmpvar_14, tex2DNode19_5);
    tmpvar_25.y = dot (tmpvar_15, tex2DNode19_5);
    tmpvar_25.z = dot (tmpvar_16, tex2DNode19_5);
    highp mat3 tmpvar_26;
    tmpvar_26[0] = unity_MatrixV[0].xyz;
    tmpvar_26[1] = unity_MatrixV[1].xyz;
    tmpvar_26[2] = unity_MatrixV[2].xyz;
    lowp vec4 tmpvar_27;
    highp vec2 P_28;
    P_28 = (((
      (tmpvar_26 * tmpvar_25)
    .xy * _MatCapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_27 = texture2D (_MatCapTex, P_28);
    highp vec4 tmpvar_29;
    tmpvar_29 = (((_Highlight_Color * 
      pow (max (clamp ((tmpvar_18 * _Fresnal_Scale), 0.0, 1.0), 0.0001), _Fresnal_Power)
    ) + staticSwitch133_4) + (tmpvar_27 * _MatCapColor));
    highp float tmpvar_30;
    tmpvar_30 = ((tmpvar_29 * _DayColor.w) * xlv_COLOR.w).x;
    aseOutAlpha_3 = tmpvar_30;
    highp vec3 tmpvar_31;
    tmpvar_31 = ((tmpvar_29 * _DayColor) * xlv_COLOR).xyz;
    aseOutColor_2 = tmpvar_31;
    mediump float tmpvar_32;
    tmpvar_32 = clamp (aseOutAlpha_3, 0.0, 1.0);
    aseOutAlpha_3 = tmpvar_32;
    mediump vec4 tmpvar_33;
    tmpvar_33.xyz = aseOutColor_2;
    tmpvar_33.w = tmpvar_32;
    tmpvar_1 = tmpvar_33;
  };
  gl_FragData[0] = tmpvar_1;
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
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "UNITY_DEBUG_VIEW_ON" "UNITY_DEBUG_VIEW_SIMPLE_COLOR_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}