//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/DLCSmokeV1_Soft" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,1,1)
[Toggle(_DISTEXG_SWITCH_ON)] _DisTexG_Switch ("DisTex(G)_Switch", Float) = 0
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
_DepthCt ("DepthCt", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 35353
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_20.xyz;
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_20.xyz;
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = tmpvar_20.xyz;
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = mix (tmpvar_20.xyz, vec3(dot (tmpvar_20.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = mix (tmpvar_20.xyz, vec3(dot (tmpvar_20.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec2 tmpvar_5;
  tmpvar_5 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_5 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_5 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
  xlv_TEXCOORD3 = o_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform highp float _DisTexG_Switch;
uniform highp float _Rim_Switch;
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform sampler2D _CustomDepthTexture;
uniform highp float _DepthCt;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump float aseOutAlpha_1;
  mediump vec3 staticSwitch220_2;
  mediump float staticSwitch249_3;
  mediump vec4 tex2DNode10_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_4 = tmpvar_5;
  staticSwitch249_3 = 0.0;
  if ((_DisTexG_Switch > 0.0)) {
    lowp vec4 tmpvar_6;
    tmpvar_6 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    lowp vec4 tmpvar_7;
    tmpvar_7 = texture2D (_DisTexture, xlv_TEXCOORD0.xy);
    staticSwitch249_3 = (tmpvar_6.x + tmpvar_7.y);
  } else {
    lowp vec4 tmpvar_8;
    tmpvar_8 = texture2D (_DisTexture, xlv_TEXCOORD0.zw);
    staticSwitch249_3 = tmpvar_8.x;
  };
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_9.z * staticSwitch249_3);
  mediump float tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = (1.0 - _Smoothstep);
  mediump float tmpvar_13;
  tmpvar_13 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_10)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_11 = (tmpvar_13 * (tmpvar_13 * (3.0 - 
    (2.0 * tmpvar_13)
  )));
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tex2DNode10_4.z * xlv_TEXCOORD2);
  mediump float tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD1.x + tmpvar_10) + xlv_TEXCOORD1.y);
  mediump float tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (((
    (tmpvar_15 + _Rim)
   - tmpvar_12) / (_Smoothstep - tmpvar_12)), 0.0, 1.0);
  tmpvar_16 = (tmpvar_17 * (tmpvar_17 * (3.0 - 
    (2.0 * tmpvar_17)
  )));
  staticSwitch220_2 = vec3(0.0, 0.0, 0.0);
  if ((_Rim_Switch > 0.0)) {
    staticSwitch220_2 = mix (tmpvar_14, (tex2DNode10_4.y * _RimColor), vec3(tmpvar_16));
  } else {
    staticSwitch220_2 = tmpvar_14;
  };
  mediump float edge0_18;
  edge0_18 = (1.0 - _Smoothstep);
  mediump float tmpvar_19;
  tmpvar_19 = clamp (((tmpvar_15 - edge0_18) / (_Smoothstep - edge0_18)), 0.0, 1.0);
  mediump vec4 tmpvar_20;
  tmpvar_20.w = 0.0;
  tmpvar_20.xyz = (_SmokeBrightness * mix (staticSwitch220_2, (tex2DNode10_4.x * xlv_COLOR.xyz), vec3((tmpvar_19 * 
    (tmpvar_19 * (3.0 - (2.0 * tmpvar_19)))
  ))));
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_22;
  z_22 = tmpvar_21.x;
  highp float tmpvar_23;
  tmpvar_23 = clamp (abs((
    ((1.0/(((_ZBufferParams.z * z_22) + _ZBufferParams.w))) - (1.0/(((_ZBufferParams.z * 
      (xlv_TEXCOORD3 / xlv_TEXCOORD3.w)
    .z) + _ZBufferParams.w))))
   / _DepthCt)), 0.0, 1.0);
  aseOutAlpha_1 = ((xlv_COLOR.w * tex2DNode10_4.w) * (tmpvar_11 * tmpvar_23));
  mediump float tmpvar_24;
  tmpvar_24 = clamp (aseOutAlpha_1, 0.0, 1.0);
  aseOutAlpha_1 = tmpvar_24;
  mediump vec4 tmpvar_25;
  tmpvar_25.xyz = mix (tmpvar_20.xyz, vec3(dot (tmpvar_20.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_25.w = tmpvar_24;
  gl_FragData[0] = tmpvar_25;
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
Fallback "Diffuse"
CustomEditor "ASEMaterialInspector"
}