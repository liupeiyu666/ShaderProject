//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Dissolution_2Color_Particle" {
Properties {
_DissolveTex ("DissolveTex", 2D) = "white" { }
_DissolveTex_Vspeed ("DissolveTex_Vspeed", Float) = 0
_DissolveTex_Uspeed ("DissolveTex_Uspeed", Float) = 0
[Toggle] _DissolveTexUVRandomToggle ("DissolveTexUVRandomToggle", Float) = 0
[Toggle(_NOISETEXTOGGLE_ON)] _NoiseTexToggle ("NoiseTexToggle", Float) = 0
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseTex_Vspeed ("NoiseTex_Vspeed", Float) = 0
_NoiseTex_Uspeed ("NoiseTex_Uspeed", Float) = 0
_Noise_Brightness ("Noise_Brightness", Float) = 0.2
_Noise_Offset ("Noise_Offset", Float) = 0.5
[Toggle] _NoiseTexUVRandomToggle ("NoiseTexUVRandomToggle", Float) = 0
_BaseTex ("BaseTex", 2D) = "white" { }
[Toggle] _RChannelAsOpacityToggle ("RChannelAsOpacityToggle", Float) = 0
[Toggle] _ParticlesColorToggle ("ParticlesColorToggle", Float) = 0
_LerpColorA ("LerpColorA", Color) = (1,0.9326572,0.3897059,0)
_LerpColorB ("LerpColorB", Color) = (1,0.2689655,0,0)
_LerpBrightness ("LerpBrightness", Range(0, 20)) = 1
[Toggle] _MainColorToggle ("MainColorToggle", Float) = 0
_MainColor ("MainColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
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
  GpuProgramID 50526
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
uniform highp vec4 _texcoord2_ST;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord1.xy * _texcoord2_ST.xy) + _texcoord2_ST.zw);
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_3));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_COLOR0 = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform highp float _ColorBrightness;
uniform highp float _ParticlesColorToggle;
uniform highp vec4 _LerpColorA;
uniform highp vec4 _LerpColorB;
uniform highp float _LerpBrightness;
uniform sampler2D _DissolveTex;
uniform highp float _DissolveTexUVRandomToggle;
uniform highp float _DissolveTex_Uspeed;
uniform highp vec4 _DissolveTex_ST;
uniform highp float _DissolveTex_Vspeed;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform highp float _MainColorToggle;
uniform highp vec4 _MainColor;
uniform highp vec4 _DayColor;
uniform highp float _RChannelAsOpacityToggle;
varying highp vec4 xlv_TEXCOORD0;
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
  highp float ifLocalVar37_7;
  highp float staticSwitch94_8;
  highp vec4 staticSwitch95_9;
  highp vec4 staticSwitch117_10;
  highp vec4 tex2DNode9_11;
  highp vec4 tex2DNode34_12;
  highp vec2 staticSwitch100_13;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0.xy * _DissolveTex_ST.xy) + _DissolveTex_ST.zw);
  highp vec2 tmpvar_15;
  tmpvar_15.x = ((_Time.y * _DissolveTex_Uspeed) + tmpvar_14.x);
  tmpvar_15.y = (tmpvar_14.y + (_Time.y * _DissolveTex_Vspeed));
  staticSwitch100_13 = vec2(0.0, 0.0);
  if ((_DissolveTexUVRandomToggle == 1.0)) {
    staticSwitch100_13 = (tmpvar_15 + xlv_TEXCOORD0.zw);
  } else {
    staticSwitch100_13 = tmpvar_15;
  };
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_DissolveTex, staticSwitch100_13);
  tex2DNode34_12 = tmpvar_16;
  highp vec2 tmpvar_17;
  tmpvar_17 = ((xlv_TEXCOORD0.xy * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_18;
  tmpvar_18 = texture2D (_BaseTex, tmpvar_17);
  tex2DNode9_11 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = mix (_LerpColorA, _LerpColorB, vec4(clamp ((_LerpBrightness * 
    (tex2DNode34_12.x * tex2DNode9_11.y)
  ), 0.0, 1.0)));
  staticSwitch117_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MainColorToggle == 1.0)) {
    staticSwitch117_10 = _MainColor;
  } else {
    staticSwitch117_10 = tmpvar_4;
  };
  staticSwitch95_9 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_ParticlesColorToggle == 1.0)) {
    highp vec4 tmpvar_20;
    tmpvar_20.w = 0.0;
    tmpvar_20.xyz = staticSwitch117_10.xyz;
    staticSwitch95_9 = tmpvar_20;
  } else {
    staticSwitch95_9 = tmpvar_19;
  };
  tmpvar_5 = ((_ColorBrightness * staticSwitch95_9) * _DayColor).xyz;
  staticSwitch94_8 = 0.0;
  if ((_RChannelAsOpacityToggle == 1.0)) {
    staticSwitch94_8 = tex2DNode9_11.x;
  } else {
    staticSwitch94_8 = tex2DNode9_11.w;
  };
  ifLocalVar37_7 = 0.0;
  if (((tex2DNode34_12.x * staticSwitch94_8) <= (1.0 - staticSwitch117_10.w))) {
    ifLocalVar37_7 = 0.0;
  } else {
    ifLocalVar37_7 = 1.0;
  };
  tmpvar_6 = ifLocalVar37_7;
  tmpvar_2 = tmpvar_5;
  tmpvar_3 = tmpvar_6;
  lowp vec4 tmpvar_21;
  tmpvar_21.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_21.w = tmpvar_6;
  c_1.w = tmpvar_21.w;
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
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_NOISETEXTOGGLE_ON" }
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
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_NOISETEXTOGGLE_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}