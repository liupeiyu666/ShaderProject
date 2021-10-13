//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCSmokeSwirlV1" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,0,0)
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_SmoothstepA ("Smoothstep(A)", Range(-1, 1)) = 0
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-0.1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
_SwirlTexture ("SwirlTexture", 2D) = "white" { }
_SwirlTexUV ("SwirlTexUV", Vector) = (0,0,0,0)
_SwirlItensity ("SwirlItensity", Float) = 1
[Toggle(_SWIRL_MAINTEX_ON)] _Swirl_MainTex ("Swirl_MainTex", Float) = 0
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
  GpuProgramID 2960
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _SwirlTexUV;
uniform highp vec4 _SwirlTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2.xy = (((_glesMultiTexCoord0.xy * _SwirlTexture_ST.xy) + _SwirlTexture_ST.zw) + fract((_SwirlTexUV * _Time.y)));
  tmpvar_2.zw = (((_glesMultiTexCoord0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Swirl_MainTex;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform sampler2D _SwirlTexture;
uniform mediump float _SwirlItensity;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  mediump vec2 staticSwitch261_4;
  mediump vec4 tex2DNode43_5;
  mediump vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = (1.0 - xlv_TEXCOORD0.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_SwirlTexture, xlv_TEXCOORD1.xy);
  tex2DNode43_5 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (((tex2DNode43_5.xy - vec2(0.5, 0.5)) * _SwirlItensity) * xlv_TEXCOORD2.w);
  staticSwitch261_4 = vec2(0.0, 0.0);
  if ((_Swirl_MainTex > 0.0)) {
    staticSwitch261_4 = tmpvar_8;
  } else {
    staticSwitch261_4 = vec2(0.0, 0.0);
  };
  mediump vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + staticSwitch261_4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainSmokeTexture, tmpvar_9);
  tex2DNode10_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.z;
  tmpvar_11.y = (1.0 - xlv_TEXCOORD1.w);
  highp vec2 P_12;
  P_12 = (tmpvar_11 + tmpvar_8);
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_DisTexture, tmpvar_9).z * texture2D (_DisTexture, P_12).x);
  temp_output_231_0_2 = tmpvar_13;
  mediump float tmpvar_14;
  mediump float edge0_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Smoothstep);
  edge0_15 = (tmpvar_16 - _SmoothstepA);
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (xlv_TEXCOORD0.z + temp_output_231_0_2)
   - edge0_15) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_15)), 0.0, 1.0);
  tmpvar_14 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  mediump float tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + (xlv_TEXCOORD0.w + _Rim))
   - tmpvar_16) / (_Smoothstep - tmpvar_16)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix ((tex2DNode10_3.z * xlv_TEXCOORD2.xyz), (tex2DNode10_3.y * _RimColor), vec3(tmpvar_18));
  } else {
    staticSwitch220_1 = (tex2DNode10_3.z * xlv_TEXCOORD2.xyz);
  };
  mediump float edge0_20;
  edge0_20 = (1.0 - _Smoothstep);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + xlv_TEXCOORD0.w)
   - edge0_20) / (_Smoothstep - edge0_20)), 0.0, 1.0);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (tex2DNode10_3.x * xlv_COLOR.xyz), vec3((tmpvar_21 * 
    (tmpvar_21 * (3.0 - (2.0 * tmpvar_21)))
  ))));
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22.xyz;
  tmpvar_23.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_3.w)
   * 
    (tmpvar_14 * _Opaqueness)
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_23;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _SwirlTexUV;
uniform highp vec4 _SwirlTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2.xy = (((_glesMultiTexCoord0.xy * _SwirlTexture_ST.xy) + _SwirlTexture_ST.zw) + fract((_SwirlTexUV * _Time.y)));
  tmpvar_2.zw = (((_glesMultiTexCoord0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Swirl_MainTex;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform sampler2D _SwirlTexture;
uniform mediump float _SwirlItensity;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  mediump vec2 staticSwitch261_4;
  mediump vec4 tex2DNode43_5;
  mediump vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = (1.0 - xlv_TEXCOORD0.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_SwirlTexture, xlv_TEXCOORD1.xy);
  tex2DNode43_5 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (((tex2DNode43_5.xy - vec2(0.5, 0.5)) * _SwirlItensity) * xlv_TEXCOORD2.w);
  staticSwitch261_4 = vec2(0.0, 0.0);
  if ((_Swirl_MainTex > 0.0)) {
    staticSwitch261_4 = tmpvar_8;
  } else {
    staticSwitch261_4 = vec2(0.0, 0.0);
  };
  mediump vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + staticSwitch261_4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainSmokeTexture, tmpvar_9);
  tex2DNode10_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.z;
  tmpvar_11.y = (1.0 - xlv_TEXCOORD1.w);
  highp vec2 P_12;
  P_12 = (tmpvar_11 + tmpvar_8);
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_DisTexture, tmpvar_9).z * texture2D (_DisTexture, P_12).x);
  temp_output_231_0_2 = tmpvar_13;
  mediump float tmpvar_14;
  mediump float edge0_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Smoothstep);
  edge0_15 = (tmpvar_16 - _SmoothstepA);
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (xlv_TEXCOORD0.z + temp_output_231_0_2)
   - edge0_15) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_15)), 0.0, 1.0);
  tmpvar_14 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  mediump float tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + (xlv_TEXCOORD0.w + _Rim))
   - tmpvar_16) / (_Smoothstep - tmpvar_16)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix ((tex2DNode10_3.z * xlv_TEXCOORD2.xyz), (tex2DNode10_3.y * _RimColor), vec3(tmpvar_18));
  } else {
    staticSwitch220_1 = (tex2DNode10_3.z * xlv_TEXCOORD2.xyz);
  };
  mediump float edge0_20;
  edge0_20 = (1.0 - _Smoothstep);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + xlv_TEXCOORD0.w)
   - edge0_20) / (_Smoothstep - edge0_20)), 0.0, 1.0);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (tex2DNode10_3.x * xlv_COLOR.xyz), vec3((tmpvar_21 * 
    (tmpvar_21 * (3.0 - (2.0 * tmpvar_21)))
  ))));
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22.xyz;
  tmpvar_23.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_3.w)
   * 
    (tmpvar_14 * _Opaqueness)
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_23;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec2 _SwirlTexUV;
uniform highp vec4 _SwirlTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_1.zw = _glesMultiTexCoord1.xy;
  tmpvar_2.xy = (((_glesMultiTexCoord0.xy * _SwirlTexture_ST.xy) + _SwirlTexture_ST.zw) + fract((_SwirlTexUV * _Time.y)));
  tmpvar_2.zw = (((_glesMultiTexCoord0.xy * _DisTexture_ST.xy) + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp float _Swirl_MainTex;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform sampler2D _SwirlTexture;
uniform mediump float _SwirlItensity;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _Opaqueness;
varying mediump vec4 xlv_COLOR;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 staticSwitch220_1;
  mediump float temp_output_231_0_2;
  mediump vec4 tex2DNode10_3;
  mediump vec2 staticSwitch261_4;
  mediump vec4 tex2DNode43_5;
  mediump vec2 tmpvar_6;
  tmpvar_6.x = xlv_TEXCOORD0.x;
  tmpvar_6.y = (1.0 - xlv_TEXCOORD0.y);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_SwirlTexture, xlv_TEXCOORD1.xy);
  tex2DNode43_5 = tmpvar_7;
  mediump vec2 tmpvar_8;
  tmpvar_8 = (((tex2DNode43_5.xy - vec2(0.5, 0.5)) * _SwirlItensity) * xlv_TEXCOORD2.w);
  staticSwitch261_4 = vec2(0.0, 0.0);
  if ((_Swirl_MainTex > 0.0)) {
    staticSwitch261_4 = tmpvar_8;
  } else {
    staticSwitch261_4 = vec2(0.0, 0.0);
  };
  mediump vec2 tmpvar_9;
  tmpvar_9 = (tmpvar_6 + staticSwitch261_4);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainSmokeTexture, tmpvar_9);
  tex2DNode10_3 = tmpvar_10;
  highp vec2 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.z;
  tmpvar_11.y = (1.0 - xlv_TEXCOORD1.w);
  highp vec2 P_12;
  P_12 = (tmpvar_11 + tmpvar_8);
  lowp float tmpvar_13;
  tmpvar_13 = (texture2D (_DisTexture, tmpvar_9).z * texture2D (_DisTexture, P_12).x);
  temp_output_231_0_2 = tmpvar_13;
  mediump float tmpvar_14;
  mediump float edge0_15;
  mediump float tmpvar_16;
  tmpvar_16 = (1.0 - _Smoothstep);
  edge0_15 = (tmpvar_16 - _SmoothstepA);
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (xlv_TEXCOORD0.z + temp_output_231_0_2)
   - edge0_15) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_15)), 0.0, 1.0);
  tmpvar_14 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  mediump float tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + (xlv_TEXCOORD0.w + _Rim))
   - tmpvar_16) / (_Smoothstep - tmpvar_16)), 0.0, 1.0);
  tmpvar_18 = (tmpvar_19 * (tmpvar_19 * (3.0 - 
    (2.0 * tmpvar_19)
  )));
  staticSwitch220_1 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_1 = mix ((tex2DNode10_3.z * xlv_TEXCOORD2.xyz), (tex2DNode10_3.y * _RimColor), vec3(tmpvar_18));
  } else {
    staticSwitch220_1 = (tex2DNode10_3.z * xlv_TEXCOORD2.xyz);
  };
  mediump float edge0_20;
  edge0_20 = (1.0 - _Smoothstep);
  mediump float tmpvar_21;
  tmpvar_21 = clamp (((
    ((xlv_TEXCOORD0.z + temp_output_231_0_2) + xlv_TEXCOORD0.w)
   - edge0_20) / (_Smoothstep - edge0_20)), 0.0, 1.0);
  mediump vec4 tmpvar_22;
  tmpvar_22.w = 0.0;
  tmpvar_22.xyz = (_SmokeBrightness * mix (staticSwitch220_1, (tex2DNode10_3.x * xlv_COLOR.xyz), vec3((tmpvar_21 * 
    (tmpvar_21 * (3.0 - (2.0 * tmpvar_21)))
  ))));
  mediump vec4 tmpvar_23;
  tmpvar_23.xyz = tmpvar_22.xyz;
  tmpvar_23.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_3.w)
   * 
    (tmpvar_14 * _Opaqueness)
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_23;
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
CustomEditor "ASEMaterialInspector"
}