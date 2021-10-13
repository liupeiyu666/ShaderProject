//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCSmokeTrailV1" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,0,0)
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_DisNoise ("DisNoise", Range(-5, 2)) = -1
_DarkDisCt ("DarkDisCt", Range(-2, 0)) = 0
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_SmoothstepA ("Smoothstep(A)", Range(-1, 1)) = 0
_LightColor ("LightColor", Color) = (1,1,1,1)
_DarkColor ("DarkColor", Color) = (1,1,1,0)
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-0.1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 24075
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17.xyz;
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17.xyz;
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = tmpvar_17.xyz;
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = mix (tmpvar_17.xyz, vec3(dot (tmpvar_17.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = mix (tmpvar_17.xyz, vec3(dot (tmpvar_17.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisTexture_ST;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Rim_Switch;
uniform mediump vec4 _LightColor;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform mediump float _DisNoise;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _DarkColor;
uniform mediump vec3 _RimColor;
uniform mediump float _DarkDisCt;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1);
  tex2DNode10_3 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = ((3.0 * xlv_COLOR.w) + _DisNoise);
  lowp float tmpvar_6;
  tmpvar_6 = (texture2D (_DisTexture, xlv_TEXCOORD1).z * (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y));
  temp_output_231_0_2 = tmpvar_6;
  mediump float tmpvar_7;
  mediump float edge0_8;
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - _Smoothstep);
  edge0_8 = (tmpvar_9 - _SmoothstepA);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    (tmpvar_5 + temp_output_231_0_2)
   - edge0_8) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_8)), 0.0, 1.0);
  tmpvar_7 = (tmpvar_10 * (tmpvar_10 * (3.0 - 
    (2.0 * tmpvar_10)
  )));
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tex2DNode10_3.z * _DarkColor);
  mediump float tmpvar_12;
  tmpvar_12 = ((tmpvar_5 + temp_output_231_0_2) + _DarkDisCt);
  mediump float tmpvar_13;
  mediump float tmpvar_14;
  tmpvar_14 = clamp (((
    (tmpvar_12 + _Rim)
   - tmpvar_9) / (_Smoothstep - tmpvar_9)), 0.0, 1.0);
  tmpvar_13 = (tmpvar_14 * (tmpvar_14 * (3.0 - 
    (2.0 * tmpvar_14)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix (tmpvar_11, (tex2DNode10_3.y * _RimColor), vec3(tmpvar_13));
  } else {
    staticSwitch220_1 = tmpvar_11;
  };
  mediump float edge0_15;
  edge0_15 = (1.0 - _Smoothstep);
  mediump float tmpvar_16;
  tmpvar_16 = clamp (((tmpvar_12 - edge0_15) / (_Smoothstep - edge0_15)), 0.0, 1.0);
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (
    (tex2DNode10_3.x * _LightColor.xyz)
   * xlv_COLOR.xyz), vec3((tmpvar_16 * 
    (tmpvar_16 * (3.0 - (2.0 * tmpvar_16)))
  ))));
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = mix (tmpvar_17.xyz, vec3(dot (tmpvar_17.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_18.w = clamp (clamp ((
    (_LightColor.w * tex2DNode10_3.w)
   * tmpvar_7), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_18;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}