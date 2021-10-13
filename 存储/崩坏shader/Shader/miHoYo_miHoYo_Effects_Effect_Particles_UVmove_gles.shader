//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/UVmove" {
Properties {
[Toggle] _NoiseTexToggle ("NoiseTexToggle", Float) = 0
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_NoiseTex01_Uspeed ("NoiseTex01_Uspeed", Float) = 1
_NoiseTex01_Vspeed ("NoiseTex01_Vspeed", Float) = 1
[Toggle] _2NoiseTexToggle ("2NoiseTexToggle", Float) = 0
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_NoiseTex02_Uspeed ("NoiseTex02_Uspeed", Float) = 1
_NoiseTex02_Vspeed ("NoiseTex02_Vspeed", Float) = 1
_Noise_Brightness ("Noise_Brightness", Float) = 1
_Noise_Offset ("Noise_Offset", Float) = 0
[Toggle] _MaskTexToggle ("MaskTexToggle", Float) = 0
_MaskTexture ("MaskTexture", 2D) = "white" { }
_BaseTex ("BaseTex", 2D) = "white" { }
_BaseTex_Uspeed ("BaseTex_Uspeed", Float) = 1
_BaseTex_Vspeed ("BaseTex_Vspeed", Float) = 1
[Toggle] _MainColorToggle ("MainColorToggle", Float) = 0
_MainColor ("MainColor", Color) = (1,1,1,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_AlphaBrightness ("AlphaBrightness", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
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
  GpuProgramID 17591
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
  gl_FragData[0] = c_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = unity_WorldToObject[0].xyz;
  tmpvar_2[1] = unity_WorldToObject[1].xyz;
  tmpvar_2[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_2));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform sampler2D _BaseTex;
uniform highp float _NoiseTexToggle;
uniform highp vec4 _BaseTex_ST;
uniform highp float _BaseTex_Uspeed;
uniform highp float _BaseTex_Vspeed;
uniform highp float _Noise_Brightness;
uniform highp float _2NoiseTexToggle;
uniform sampler2D _NoiseTex01;
uniform highp vec4 _NoiseTex01_ST;
uniform highp float _NoiseTex01_Uspeed;
uniform highp float _NoiseTex01_Vspeed;
uniform sampler2D _NoiseTex02;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _NoiseTex02_Uspeed;
uniform highp float _NoiseTex02_Vspeed;
uniform highp float _Noise_Offset;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _MaskTexToggle;
uniform sampler2D _MaskTexture;
uniform highp vec4 _MaskTexture_ST;
uniform highp float _AlphaBrightness;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_3 = 0.0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_5 = tmpvar_2;
  tmpvar_6 = tmpvar_3;
  highp float staticSwitch182_7;
  highp vec4 staticSwitch183_8;
  highp vec4 tex2DNode1_9;
  highp vec2 staticSwitch181_10;
  highp float staticSwitch180_11;
  highp vec4 tex2DNode120_12;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  highp vec2 tmpvar_14;
  tmpvar_14.x = (tmpvar_13.x + (_Time.y * _BaseTex_Uspeed));
  tmpvar_14.y = ((_Time.y * _BaseTex_Vspeed) + tmpvar_13.y);
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _NoiseTex01_ST.xy) + _NoiseTex01_ST.zw);
  highp vec2 tmpvar_16;
  tmpvar_16.x = (tmpvar_15.x + (_Time.y * _NoiseTex01_Uspeed));
  tmpvar_16.y = (tmpvar_15.y + (_Time.y * _NoiseTex01_Vspeed));
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_NoiseTex01, tmpvar_16);
  tex2DNode120_12 = tmpvar_17;
  highp vec2 tmpvar_18;
  tmpvar_18 = ((xlv_TEXCOORD0 * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw);
  highp vec2 tmpvar_19;
  tmpvar_19.x = (tmpvar_18.x + (_Time.y * _NoiseTex02_Uspeed));
  tmpvar_19.y = (tmpvar_18.y + (_Time.y * _NoiseTex02_Vspeed));
  staticSwitch180_11 = 0.0;
  if ((_2NoiseTexToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NoiseTex02, tmpvar_19);
    staticSwitch180_11 = (tex2DNode120_12.x * tmpvar_20.x);
  } else {
    staticSwitch180_11 = tex2DNode120_12.x;
  };
  staticSwitch181_10 = vec2(0.0, 0.0);
  if ((_NoiseTexToggle == 1.0)) {
    staticSwitch181_10 = ((_Noise_Brightness * (staticSwitch180_11 + _Noise_Offset)) + tmpvar_14);
  } else {
    staticSwitch181_10 = tmpvar_14;
  };
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_BaseTex, staticSwitch181_10);
  tex2DNode1_9 = tmpvar_21;
  staticSwitch183_8 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch183_8 = _MainColor;
  } else {
    staticSwitch183_8 = tmpvar_4;
  };
  highp vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = staticSwitch183_8.xyz;
  tmpvar_5 = ((_ColorBrightness * tex2DNode1_9) * (tmpvar_22 * _DayColor)).xyz;
  highp float tmpvar_23;
  tmpvar_23 = (tex2DNode1_9.w * staticSwitch183_8.w);
  highp vec2 tmpvar_24;
  tmpvar_24 = ((xlv_TEXCOORD0 * _MaskTexture_ST.xy) + _MaskTexture_ST.zw);
  staticSwitch182_7 = 0.0;
  if ((_MaskTexToggle == 1.0)) {
    lowp vec4 tmpvar_25;
    tmpvar_25 = texture2D (_MaskTexture, tmpvar_24);
    staticSwitch182_7 = (tmpvar_23 * tmpvar_25.x);
  } else {
    staticSwitch182_7 = tmpvar_23;
  };
  highp float tmpvar_26;
  tmpvar_26 = clamp ((_DayColor.w * (staticSwitch182_7 * _AlphaBrightness)), 0.0, 1.0);
  tmpvar_6 = tmpvar_26;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_27;
  tmpvar_27.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_27.w = tmpvar_6;
  c_1.w = tmpvar_27.w;
  c_1.xyz = tmpvar_5;
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