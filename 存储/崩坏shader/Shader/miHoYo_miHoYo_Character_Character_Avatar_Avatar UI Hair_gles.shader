//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Avatar/Avatar UI Hair" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_EnvColor ("Env Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_LightMapTex ("Light Map Tex (RGB)", 2D) = "gray" { }
_LightSpecColor ("Light Specular Color", Color) = (1,1,1,1)
_LightArea ("Light Area Threshold", Range(0, 1)) = 0.51
_SecondShadow ("Second Shadow Threshold", Range(0, 1)) = 0.51
_FirstShadowMultColor ("First Shadow Multiply Color", Color) = (0.9,0.7,0.75,1)
_SecondShadowMultColor ("Second Shadow Multiply Color", Color) = (0.75,0.6,0.65,1)
_Shininess ("Specular Shininess", Range(0.1, 100)) = 10
_SpecMulti ("Specular Multiply Factor", Range(0, 1)) = 0.1
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
_MaxOutlineZOffset ("Max Outline Z Offset", Range(0, 100)) = 1
_OutlineCamStart ("Outline Camera Adjustment Start Distance", Range(0, 10000)) = 1000
_DirectionalFadeDirection ("Directional Fade Direction (world space)", Vector) = (0,-1,0,0)
_DirectionalFadeOffset ("Directional Fade Offset (object space)", Float) = 0
_DirectionalFadeRange ("Directional Fade Range", Range(0.01, 2)) = 0.1
_DirectionalFadeValue ("Directional Fade Value", Range(0, 1)) = 1
[Toggle(LOOKUP_COLOR)] _LookupColor ("Lookup Color", Float) = 0
[Toggle(LOOKUP_COLOR_BILINEAR)] _LookupColorBilinear ("Lookup Color Bilinear", Float) = 0
_factorTex ("Factor Tex", 2D) = "white" { }
_indexTex ("Index Tex", 2D) = "white" { }
_tableTex ("Lookup Tex", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
}
SubShader {
 LOD 200
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 53189
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
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
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _MainTex;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 baseTexColor_3;
  mediump vec3 tex_Light_Color_4;
  mediump vec4 outColor_5;
  outColor_5 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_4 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0).xyz;
  baseTexColor_3 = tmpvar_7;
  mediump float threshold_8;
  mediump float D_9;
  mediump vec3 diffColor_10;
  diffColor_10 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (xlv_COLOR0.x * tex_Light_Color_4.y);
  D_9 = tmpvar_11;
  threshold_8 = 0.0;
  if ((tmpvar_11 < 0.09)) {
    threshold_8 = ((xlv_COLOR1 + tmpvar_11) * 0.5);
    if ((threshold_8 < _SecondShadow)) {
      diffColor_10 = (baseTexColor_3 * _SecondShadowMultColor);
    } else {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_11 >= 0.5)) {
      D_9 = ((tmpvar_11 * 1.2) - 0.1);
    } else {
      D_9 = ((D_9 * 1.25) - 0.125);
    };
    threshold_8 = ((xlv_COLOR1 + D_9) * 0.5);
    if ((threshold_8 < _LightArea)) {
      diffColor_10 = (baseTexColor_3 * _FirstShadowMultColor);
    } else {
      diffColor_10 = baseTexColor_3;
    };
  };
  outColor_5.xyz = diffColor_10;
  mediump vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_14;
  mediump vec3 color_15;
  mediump vec3 H_16;
  H_16 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_17;
    highp vec3 tmpvar_18;
    tmpvar_18 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_17 = tmpvar_18;
    H_16 = normalize((_CustomLightDir.xyz + V_17));
  };
  mediump float tmpvar_19;
  tmpvar_19 = pow (max (dot (tmpvar_12, H_16), 0.0), _Shininess);
  if ((tmpvar_19 >= (1.0 - tex_Light_Color_4.z))) {
    color_15 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_4.x);
  } else {
    color_15 = vec3(0.0, 0.0, 0.0);
  };
  outColor_5.xyz = (diffColor_10 + color_15);
  outColor_5.w = xlv_TEXCOORD3;
  outColor_5.xyz = (outColor_5.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_5;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, uv_6);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, uv_6);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_4.xyz = diffColor_21;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (tmpvar_23, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_3.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_21 + color_26);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, uv_6);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, uv_6);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_4.xyz = diffColor_21;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (tmpvar_23, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_3.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_21 + color_26);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  highp vec2 uv_6;
  uv_6 = xlv_TEXCOORD0;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_factorTex, uv_6);
  mediump vec4 tmpvar_8;
  tmpvar_8 = tmpvar_7;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_indexTex, uv_6);
  mediump float tmpvar_10;
  tmpvar_10 = tmpvar_9.w;
  mediump vec2 tmpvar_11;
  tmpvar_11.y = 0.0;
  tmpvar_11.x = tmpvar_10;
  lowp vec3 tmpvar_12;
  tmpvar_12 = texture2D (_tableTex, tmpvar_11).xyz;
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12;
  mediump vec2 tmpvar_14;
  tmpvar_14.y = 1.0;
  tmpvar_14.x = tmpvar_10;
  lowp vec3 tmpvar_15;
  tmpvar_15 = texture2D (_tableTex, tmpvar_14).xyz;
  mediump vec3 tmpvar_16;
  tmpvar_16 = tmpvar_15;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = mix (tmpvar_13, tmpvar_16, tmpvar_8.xxx);
  tmpvar_17.w = tmpvar_8.y;
  mediump vec3 tmpvar_18;
  tmpvar_18 = tmpvar_17.xyz;
  mediump float threshold_19;
  mediump float D_20;
  mediump vec3 diffColor_21;
  diffColor_21 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_22;
  tmpvar_22 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_20 = tmpvar_22;
  threshold_19 = 0.0;
  if ((tmpvar_22 < 0.09)) {
    threshold_19 = ((xlv_COLOR1 + tmpvar_22) * 0.5);
    if ((threshold_19 < _SecondShadow)) {
      diffColor_21 = (tmpvar_17.xyz * _SecondShadowMultColor);
    } else {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_22 >= 0.5)) {
      D_20 = ((tmpvar_22 * 1.2) - 0.1);
    } else {
      D_20 = ((D_20 * 1.25) - 0.125);
    };
    threshold_19 = ((xlv_COLOR1 + D_20) * 0.5);
    if ((threshold_19 < _LightArea)) {
      diffColor_21 = (tmpvar_17.xyz * _FirstShadowMultColor);
    } else {
      diffColor_21 = tmpvar_18;
    };
  };
  outColor_4.xyz = diffColor_21;
  mediump vec3 tmpvar_23;
  tmpvar_23 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_25;
  mediump vec3 color_26;
  mediump vec3 H_27;
  H_27 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_28;
    highp vec3 tmpvar_29;
    tmpvar_29 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_28 = tmpvar_29;
    H_27 = normalize((_CustomLightDir.xyz + V_28));
  };
  mediump float tmpvar_30;
  tmpvar_30 = pow (max (dot (tmpvar_23, H_27), 0.0), _Shininess);
  if ((tmpvar_30 >= (1.0 - tex_Light_Color_3.z))) {
    color_26 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_26 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_21 + color_26);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((uv_7 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_6 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_6.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_6.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_4.xyz = diffColor_64;
  mediump vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (tmpvar_66, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_3.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_64 + color_69);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((uv_7 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_6 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_6.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_6.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_4.xyz = diffColor_64;
  mediump vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (tmpvar_66, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_3.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_64 + color_69);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _CustomLightDir;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  mediump vec2 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = _glesVertex.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_4 = (tmpvar_7.xyz / tmpvar_7.w);
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_3 = tmpvar_9;
  mediump vec3 L_10;
  L_10 = _WorldSpaceLightPos0.xyz;
  if ((_CustomLightDir.w > 0.5)) {
    L_10 = _CustomLightDir.xyz;
  };
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  gl_Position = tmpvar_5;
  xlv_COLOR0 = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = tmpvar_11;
  xlv_COLOR1 = ((dot (tmpvar_3, L_10) * 0.4975) + 0.5);
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform mediump vec4 _Color;
uniform mediump vec4 _EnvColor;
uniform sampler2D _LightMapTex;
uniform mediump float _LightArea;
uniform mediump float _SecondShadow;
uniform mediump vec3 _FirstShadowMultColor;
uniform mediump vec3 _SecondShadowMultColor;
uniform mediump float _Shininess;
uniform mediump float _SpecMulti;
uniform mediump vec3 _LightSpecColor;
uniform mediump vec4 _CustomLightDir;
uniform sampler2D _factorTex;
uniform sampler2D _indexTex;
uniform sampler2D _tableTex;
uniform highp vec4 _indexTex_TexelSize;
varying mediump vec4 xlv_COLOR0;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying mediump float xlv_TEXCOORD3;
varying mediump float xlv_COLOR1;
void main ()
{
  mediump vec3 H_1;
  mediump vec3 V_2;
  mediump vec3 tex_Light_Color_3;
  mediump vec4 outColor_4;
  outColor_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_LightMapTex, xlv_TEXCOORD0).xyz;
  tex_Light_Color_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 uv_7;
  uv_7 = xlv_TEXCOORD0;
  highp vec2 pixelSize_8;
  pixelSize_8 = (1.0/(_indexTex_TexelSize.zw));
  highp vec2 tmpvar_9;
  tmpvar_9 = ((uv_7 * _indexTex_TexelSize.zw) - 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10 = floor(tmpvar_9);
  highp vec2 tmpvar_11;
  tmpvar_11 = fract(tmpvar_9);
  highp vec2 uv_12;
  uv_12 = ((tmpvar_10 + vec2(0.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_factorTex, uv_12);
  mediump vec4 tmpvar_14;
  tmpvar_14 = tmpvar_13;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_indexTex, uv_12);
  mediump float tmpvar_16;
  tmpvar_16 = tmpvar_15.w;
  mediump vec2 tmpvar_17;
  tmpvar_17.y = 0.0;
  tmpvar_17.x = tmpvar_16;
  lowp vec3 tmpvar_18;
  tmpvar_18 = texture2D (_tableTex, tmpvar_17).xyz;
  mediump vec3 tmpvar_19;
  tmpvar_19 = tmpvar_18;
  mediump vec2 tmpvar_20;
  tmpvar_20.y = 1.0;
  tmpvar_20.x = tmpvar_16;
  lowp vec3 tmpvar_21;
  tmpvar_21 = texture2D (_tableTex, tmpvar_20).xyz;
  mediump vec3 tmpvar_22;
  tmpvar_22 = tmpvar_21;
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = mix (tmpvar_19, tmpvar_22, tmpvar_14.xxx);
  tmpvar_23.w = tmpvar_14.y;
  highp vec2 uv_24;
  uv_24 = ((tmpvar_10 + vec2(1.5, 0.5)) * pixelSize_8);
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_factorTex, uv_24);
  mediump vec4 tmpvar_26;
  tmpvar_26 = tmpvar_25;
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_indexTex, uv_24);
  mediump float tmpvar_28;
  tmpvar_28 = tmpvar_27.w;
  mediump vec2 tmpvar_29;
  tmpvar_29.y = 0.0;
  tmpvar_29.x = tmpvar_28;
  lowp vec3 tmpvar_30;
  tmpvar_30 = texture2D (_tableTex, tmpvar_29).xyz;
  mediump vec3 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  mediump vec2 tmpvar_32;
  tmpvar_32.y = 1.0;
  tmpvar_32.x = tmpvar_28;
  lowp vec3 tmpvar_33;
  tmpvar_33 = texture2D (_tableTex, tmpvar_32).xyz;
  mediump vec3 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  mediump vec4 tmpvar_35;
  tmpvar_35.xyz = mix (tmpvar_31, tmpvar_34, tmpvar_26.xxx);
  tmpvar_35.w = tmpvar_26.y;
  highp vec2 uv_36;
  uv_36 = ((tmpvar_10 + vec2(0.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_factorTex, uv_36);
  mediump vec4 tmpvar_38;
  tmpvar_38 = tmpvar_37;
  lowp vec4 tmpvar_39;
  tmpvar_39 = texture2D (_indexTex, uv_36);
  mediump float tmpvar_40;
  tmpvar_40 = tmpvar_39.w;
  mediump vec2 tmpvar_41;
  tmpvar_41.y = 0.0;
  tmpvar_41.x = tmpvar_40;
  lowp vec3 tmpvar_42;
  tmpvar_42 = texture2D (_tableTex, tmpvar_41).xyz;
  mediump vec3 tmpvar_43;
  tmpvar_43 = tmpvar_42;
  mediump vec2 tmpvar_44;
  tmpvar_44.y = 1.0;
  tmpvar_44.x = tmpvar_40;
  lowp vec3 tmpvar_45;
  tmpvar_45 = texture2D (_tableTex, tmpvar_44).xyz;
  mediump vec3 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = mix (tmpvar_43, tmpvar_46, tmpvar_38.xxx);
  tmpvar_47.w = tmpvar_38.y;
  highp vec2 uv_48;
  uv_48 = ((tmpvar_10 + vec2(1.5, 1.5)) * pixelSize_8);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_factorTex, uv_48);
  mediump vec4 tmpvar_50;
  tmpvar_50 = tmpvar_49;
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_indexTex, uv_48);
  mediump float tmpvar_52;
  tmpvar_52 = tmpvar_51.w;
  mediump vec2 tmpvar_53;
  tmpvar_53.y = 0.0;
  tmpvar_53.x = tmpvar_52;
  lowp vec3 tmpvar_54;
  tmpvar_54 = texture2D (_tableTex, tmpvar_53).xyz;
  mediump vec3 tmpvar_55;
  tmpvar_55 = tmpvar_54;
  mediump vec2 tmpvar_56;
  tmpvar_56.y = 1.0;
  tmpvar_56.x = tmpvar_52;
  lowp vec3 tmpvar_57;
  tmpvar_57 = texture2D (_tableTex, tmpvar_56).xyz;
  mediump vec3 tmpvar_58;
  tmpvar_58 = tmpvar_57;
  mediump vec4 tmpvar_59;
  tmpvar_59.xyz = mix (tmpvar_55, tmpvar_58, tmpvar_50.xxx);
  tmpvar_59.w = tmpvar_50.y;
  highp vec4 tmpvar_60;
  tmpvar_60 = mix (mix (tmpvar_23, tmpvar_35, tmpvar_11.xxxx), mix (tmpvar_47, tmpvar_59, tmpvar_11.xxxx), tmpvar_11.yyyy);
  tmpvar_6 = tmpvar_60;
  mediump vec3 tmpvar_61;
  tmpvar_61 = tmpvar_6.xyz;
  mediump float threshold_62;
  mediump float D_63;
  mediump vec3 diffColor_64;
  diffColor_64 = vec3(1.0, 1.0, 1.0);
  mediump float tmpvar_65;
  tmpvar_65 = (xlv_COLOR0.x * tex_Light_Color_3.y);
  D_63 = tmpvar_65;
  threshold_62 = 0.0;
  if ((tmpvar_65 < 0.09)) {
    threshold_62 = ((xlv_COLOR1 + tmpvar_65) * 0.5);
    if ((threshold_62 < _SecondShadow)) {
      diffColor_64 = (tmpvar_6.xyz * _SecondShadowMultColor);
    } else {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    };
  } else {
    if ((tmpvar_65 >= 0.5)) {
      D_63 = ((tmpvar_65 * 1.2) - 0.1);
    } else {
      D_63 = ((D_63 * 1.25) - 0.125);
    };
    threshold_62 = ((xlv_COLOR1 + D_63) * 0.5);
    if ((threshold_62 < _LightArea)) {
      diffColor_64 = (tmpvar_6.xyz * _FirstShadowMultColor);
    } else {
      diffColor_64 = tmpvar_61;
    };
  };
  outColor_4.xyz = diffColor_64;
  mediump vec3 tmpvar_66;
  tmpvar_66 = normalize(xlv_TEXCOORD1);
  highp vec3 tmpvar_67;
  tmpvar_67 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  V_2 = tmpvar_67;
  highp vec3 tmpvar_68;
  tmpvar_68 = normalize((_WorldSpaceLightPos0.xyz + V_2));
  H_1 = tmpvar_68;
  mediump vec3 color_69;
  mediump vec3 H_70;
  H_70 = H_1;
  if ((_CustomLightDir.w > 0.5)) {
    mediump vec3 V_71;
    highp vec3 tmpvar_72;
    tmpvar_72 = normalize((H_1 - _WorldSpaceLightPos0.xyz));
    V_71 = tmpvar_72;
    H_70 = normalize((_CustomLightDir.xyz + V_71));
  };
  mediump float tmpvar_73;
  tmpvar_73 = pow (max (dot (tmpvar_66, H_70), 0.0), _Shininess);
  if ((tmpvar_73 >= (1.0 - tex_Light_Color_3.z))) {
    color_69 = ((_LightSpecColor * _SpecMulti) * tex_Light_Color_3.x);
  } else {
    color_69 = vec3(0.0, 0.0, 0.0);
  };
  outColor_4.xyz = (diffColor_64 + color_69);
  outColor_4.w = xlv_TEXCOORD3;
  outColor_4.xyz = (outColor_4.xyz * (_Color * _EnvColor).xyz);
  gl_FragData[0] = outColor_4;
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
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LOOKUP_COLOR" "LOOKUP_COLOR_BILINEAR" }
""
}
}
}
 Pass {
  Name "COMPLEX"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  Cull Front
  GpuProgramID 117459
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_5;
  tmpvar_5 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixMV[0].xyz;
  tmpvar_6[1] = unity_MatrixMV[1].xyz;
  tmpvar_6[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_7.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(N_1);
  N_1 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_9));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_8.xy * tmpvar_10));
  tmpvar_4.xyz = _OutlineColor.xyz;
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  tmpvar_4.w = tmpvar_11;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_5;
  tmpvar_5 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixMV[0].xyz;
  tmpvar_6[1] = unity_MatrixMV[1].xyz;
  tmpvar_6[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_7.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(N_1);
  N_1 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_9));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_8.xy * tmpvar_10));
  tmpvar_4.xyz = _OutlineColor.xyz;
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  tmpvar_4.w = tmpvar_11;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _MaxOutlineZOffset;
uniform mediump float _Scale;
uniform highp vec4 _DirectionalFadeDirection;
uniform highp float _DirectionalFadeOffset;
uniform highp float _DirectionalFadeRange;
uniform highp float _DirectionalFadeValue;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 N_1;
  mediump float S_2;
  highp vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  tmpvar_3 = (unity_MatrixMV * _glesVertex);
  tmpvar_3 = (tmpvar_3 / tmpvar_3.w);
  highp float tmpvar_5;
  tmpvar_5 = (-(tmpvar_3.z) / unity_CameraProjection[1].y);
  S_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixMV[0].xyz;
  tmpvar_6[1] = unity_MatrixMV[1].xyz;
  tmpvar_6[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * _glesTANGENT.xyz);
  N_1.xy = tmpvar_7.xy;
  N_1.z = 0.01;
  mediump vec3 tmpvar_8;
  tmpvar_8 = normalize(N_1);
  N_1 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = pow ((S_2 / _Scale), 0.5);
  S_2 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = ((_OutlineWidth * _Scale) * (_glesColor.w * tmpvar_9));
  tmpvar_3.xyz = (tmpvar_3.xyz + ((
    (normalize(tmpvar_3.xyz) * _MaxOutlineZOffset)
   * _Scale) * (_glesColor.z - 0.5)));
  tmpvar_3.xy = (tmpvar_3.xy + (tmpvar_8.xy * tmpvar_10));
  tmpvar_4.xyz = _OutlineColor.xyz;
  mediump float tmpvar_11;
  highp vec4 direction_12;
  highp mat3 tmpvar_13;
  tmpvar_13[0] = unity_WorldToObject[0].xyz;
  tmpvar_13[1] = unity_WorldToObject[1].xyz;
  tmpvar_13[2] = unity_WorldToObject[2].xyz;
  direction_12.xyz = (tmpvar_13 * _DirectionalFadeDirection.xyz);
  direction_12.w = _DirectionalFadeOffset;
  highp float tmpvar_14;
  tmpvar_14 = mix (1.0, _DirectionalFadeValue, clamp ((
    dot (_glesVertex, direction_12)
   / _DirectionalFadeRange), 0.0, 1.0));
  tmpvar_11 = tmpvar_14;
  tmpvar_4.w = tmpvar_11;
  tmpvar_3 = (glstate_matrix_projection * tmpvar_3);
  gl_Position = tmpvar_3;
  xlv_COLOR0 = tmpvar_4;
  xlv_TEXCOORD3 = vec4(0.0, 0.0, 0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.w = xlv_COLOR0.w;
  mediump float x_2;
  x_2 = (xlv_COLOR0.w - 0.01);
  if ((x_2 < 0.0)) {
    discard;
  };
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_3;
    scrpos_3 = xlv_TEXCOORD3;
    mediump float a_4;
    a_4 = xlv_TEXCOORD3.z;
    if ((a_4 < 0.95)) {
      scrpos_3.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_4 = (a_4 * 17.0);
      highp float tmpvar_5;
      tmpvar_5 = (scrpos_3.y / 4.0);
      highp float tmpvar_6;
      tmpvar_6 = (fract(abs(tmpvar_5)) * 4.0);
      highp float tmpvar_7;
      if ((tmpvar_5 >= 0.0)) {
        tmpvar_7 = tmpvar_6;
      } else {
        tmpvar_7 = -(tmpvar_6);
      };
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_3.x / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float x_11;
      x_11 = ((a_4 - _DITHERMATRIX[
        int(tmpvar_7)
      ][
        int(tmpvar_10)
      ]) - 0.01);
      if ((x_11 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (xlv_COLOR0.w, 0.0, 1.0);
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
 Pass {
  Name "CONSTANT_REPLACE_NOCUTOFF"
  LOD 200
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "OutlineType" = "Complex" "QUEUE" = "Transparent+1" "Reflected" = "Reflected" "RenderType" = "Transparent" }
  GpuProgramID 134194
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump float _BloomFactor;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_glesVertex * 0.5);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_2.x + (tmpvar_2.z * tmpvar_2.z));
  tmpvar_3.y = ((tmpvar_2.y + (0.5 * tmpvar_2.z)) + ((0.5 * tmpvar_2.x) * tmpvar_2.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = ((tmpvar_3 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump float outBloomFactor_3;
  outBloomFactor_3 = color_1.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_2 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_2 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_6;
    tmpvar_6 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_3 = tmpvar_6;
  } else {
    if ((intensity_2 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_3 = (outBloomFactor_3 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_glesVertex * 0.5);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_2.x + (tmpvar_2.z * tmpvar_2.z));
  tmpvar_3.y = ((tmpvar_2.y + (0.5 * tmpvar_2.z)) + ((0.5 * tmpvar_2.x) * tmpvar_2.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = ((tmpvar_3 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump float outBloomFactor_3;
  outBloomFactor_3 = color_1.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_2 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_2 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_6;
    tmpvar_6 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_3 = tmpvar_6;
  } else {
    if ((intensity_2 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_3 = (outBloomFactor_3 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_3;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _SPNoiseTex_ST;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (_glesVertex * 0.5);
  highp vec2 tmpvar_3;
  tmpvar_3.x = (tmpvar_2.x + (tmpvar_2.z * tmpvar_2.z));
  tmpvar_3.y = ((tmpvar_2.y + (0.5 * tmpvar_2.z)) + ((0.5 * tmpvar_2.x) * tmpvar_2.x));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD1 = ((tmpvar_3 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  color_1.w = _BloomFactor;
  mediump float intensity_2;
  mediump float outBloomFactor_3;
  outBloomFactor_3 = color_1.w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_2 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_2 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_6;
    tmpvar_6 = mix (_BloomFactor, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_2) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_3 = tmpvar_6;
  } else {
    if ((intensity_2 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_3 = (outBloomFactor_3 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_3;
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
}