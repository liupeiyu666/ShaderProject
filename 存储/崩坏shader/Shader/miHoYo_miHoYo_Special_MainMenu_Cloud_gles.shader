//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/MainMenu/Cloud" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_TileSize ("Tile Size", Vector) = (1,1,0,1)
_EmitterWidth ("Emitter Width", Float) = 1
_AspectRatio ("Aspect Ratio", Float) = 1
_BrightColor ("Bright Color", Color) = (1,1,1,1)
_DarkColor ("Dark Color", Color) = (1,1,1,1)
_SecondDarkColor ("Second Dark Color", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_FlashColor ("Flash Color", Color) = (1,1,1,1)
_FlashAttenFactors ("Flash Attenuation Factors", Vector) = (1,0,0,0)
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 20693
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec2 _TileSize;
uniform highp float _EmitterWidth;
uniform highp float _AspectRatio;
uniform highp vec4 _FlashPoint00;
uniform highp vec4 _FlashPoint01;
uniform highp vec4 _FlashPoint02;
uniform highp vec4 _FlashPoint03;
uniform highp vec4 _FlashPoint04;
uniform highp vec4 _FlashPoint05;
uniform highp vec4 _FlashAttenFactors;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_6 / tmpvar_6.w);
  highp float ret_9;
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_FlashPoint00.xyz - tmpvar_6.xyz);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  ret_9 = (_FlashPoint00.w / ((_FlashAttenFactors.x + 
    (tmpvar_10 * _FlashAttenFactors.y)
  ) + (
    (tmpvar_10 * tmpvar_10)
   * _FlashAttenFactors.z)));
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (_FlashPoint01.xyz - tmpvar_6.xyz);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  ret_9 = (ret_9 + (_FlashPoint01.w / (
    (_FlashAttenFactors.x + (tmpvar_12 * _FlashAttenFactors.y))
   + 
    ((tmpvar_12 * tmpvar_12) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_FlashPoint02.xyz - tmpvar_6.xyz);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  ret_9 = (ret_9 + (_FlashPoint02.w / (
    (_FlashAttenFactors.x + (tmpvar_14 * _FlashAttenFactors.y))
   + 
    ((tmpvar_14 * tmpvar_14) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_FlashPoint03.xyz - tmpvar_6.xyz);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  ret_9 = (ret_9 + (_FlashPoint03.w / (
    (_FlashAttenFactors.x + (tmpvar_16 * _FlashAttenFactors.y))
   + 
    ((tmpvar_16 * tmpvar_16) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_FlashPoint04.xyz - tmpvar_6.xyz);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  ret_9 = (ret_9 + (_FlashPoint04.w / (
    (_FlashAttenFactors.x + (tmpvar_18 * _FlashAttenFactors.y))
   + 
    ((tmpvar_18 * tmpvar_18) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_FlashPoint05.xyz - tmpvar_6.xyz);
  tmpvar_20 = sqrt(dot (tmpvar_21, tmpvar_21));
  ret_9 = (ret_9 + (_FlashPoint05.w / (
    (_FlashAttenFactors.x + (tmpvar_20 * _FlashAttenFactors.y))
   + 
    ((tmpvar_20 * tmpvar_20) * _FlashAttenFactors.z)
  )));
  tmpvar_8 = ret_9;
  highp float tmpvar_22;
  tmpvar_22 = ((_glesColor.y * _EmitterWidth) / _glesColor.z);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22;
  tmpvar_23.y = (tmpvar_22 * _AspectRatio);
  highp vec4 vert_24;
  vert_24.w = tmpvar_6.w;
  highp vec2 offset_25;
  offset_25 = (((_glesMultiTexCoord0.xy * 2.0) - 1.0) * tmpvar_23);
  highp vec4 v_26;
  v_26.x = tmpvar_2.x;
  v_26.y = tmpvar_3.x;
  v_26.z = tmpvar_4.x;
  v_26.w = tmpvar_5.x;
  highp vec4 v_27;
  v_27.x = tmpvar_2.y;
  v_27.y = tmpvar_3.y;
  v_27.z = tmpvar_4.y;
  v_27.w = tmpvar_5.y;
  vert_24.xyz = (tmpvar_6.xyz + ((v_26.xyz * offset_25.x) + (v_27.xyz * offset_25.y)));
  tmpvar_6 = vert_24;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp int tmpvar_28;
  tmpvar_28 = int(((_glesColor.x * _TileSize.x) * _TileSize.y));
  highp vec2 tmpvar_29;
  tmpvar_29.x = (float(mod (float(tmpvar_28), _TileSize.x)));
  tmpvar_29.y = floor((float(tmpvar_28) / _TileSize.x));
  tmpvar_7 = ((tmpvar_7 + tmpvar_29) / _TileSize);
  gl_Position = (unity_MatrixVP * vert_24);
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump vec4 _FlashColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.xyz = (outColor_1.xyz + (_FlashColor * xlv_TEXCOORD1).xyz);
  outColor_1.w = (texColor_2.w * xlv_COLOR0.w);
  outColor_1.w = clamp (outColor_1.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec2 _TileSize;
uniform highp float _EmitterWidth;
uniform highp float _AspectRatio;
uniform highp vec4 _FlashPoint00;
uniform highp vec4 _FlashPoint01;
uniform highp vec4 _FlashPoint02;
uniform highp vec4 _FlashPoint03;
uniform highp vec4 _FlashPoint04;
uniform highp vec4 _FlashPoint05;
uniform highp vec4 _FlashAttenFactors;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_6 / tmpvar_6.w);
  highp float ret_9;
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_FlashPoint00.xyz - tmpvar_6.xyz);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  ret_9 = (_FlashPoint00.w / ((_FlashAttenFactors.x + 
    (tmpvar_10 * _FlashAttenFactors.y)
  ) + (
    (tmpvar_10 * tmpvar_10)
   * _FlashAttenFactors.z)));
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (_FlashPoint01.xyz - tmpvar_6.xyz);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  ret_9 = (ret_9 + (_FlashPoint01.w / (
    (_FlashAttenFactors.x + (tmpvar_12 * _FlashAttenFactors.y))
   + 
    ((tmpvar_12 * tmpvar_12) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_FlashPoint02.xyz - tmpvar_6.xyz);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  ret_9 = (ret_9 + (_FlashPoint02.w / (
    (_FlashAttenFactors.x + (tmpvar_14 * _FlashAttenFactors.y))
   + 
    ((tmpvar_14 * tmpvar_14) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_FlashPoint03.xyz - tmpvar_6.xyz);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  ret_9 = (ret_9 + (_FlashPoint03.w / (
    (_FlashAttenFactors.x + (tmpvar_16 * _FlashAttenFactors.y))
   + 
    ((tmpvar_16 * tmpvar_16) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_FlashPoint04.xyz - tmpvar_6.xyz);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  ret_9 = (ret_9 + (_FlashPoint04.w / (
    (_FlashAttenFactors.x + (tmpvar_18 * _FlashAttenFactors.y))
   + 
    ((tmpvar_18 * tmpvar_18) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_FlashPoint05.xyz - tmpvar_6.xyz);
  tmpvar_20 = sqrt(dot (tmpvar_21, tmpvar_21));
  ret_9 = (ret_9 + (_FlashPoint05.w / (
    (_FlashAttenFactors.x + (tmpvar_20 * _FlashAttenFactors.y))
   + 
    ((tmpvar_20 * tmpvar_20) * _FlashAttenFactors.z)
  )));
  tmpvar_8 = ret_9;
  highp float tmpvar_22;
  tmpvar_22 = ((_glesColor.y * _EmitterWidth) / _glesColor.z);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22;
  tmpvar_23.y = (tmpvar_22 * _AspectRatio);
  highp vec4 vert_24;
  vert_24.w = tmpvar_6.w;
  highp vec2 offset_25;
  offset_25 = (((_glesMultiTexCoord0.xy * 2.0) - 1.0) * tmpvar_23);
  highp vec4 v_26;
  v_26.x = tmpvar_2.x;
  v_26.y = tmpvar_3.x;
  v_26.z = tmpvar_4.x;
  v_26.w = tmpvar_5.x;
  highp vec4 v_27;
  v_27.x = tmpvar_2.y;
  v_27.y = tmpvar_3.y;
  v_27.z = tmpvar_4.y;
  v_27.w = tmpvar_5.y;
  vert_24.xyz = (tmpvar_6.xyz + ((v_26.xyz * offset_25.x) + (v_27.xyz * offset_25.y)));
  tmpvar_6 = vert_24;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp int tmpvar_28;
  tmpvar_28 = int(((_glesColor.x * _TileSize.x) * _TileSize.y));
  highp vec2 tmpvar_29;
  tmpvar_29.x = (float(mod (float(tmpvar_28), _TileSize.x)));
  tmpvar_29.y = floor((float(tmpvar_28) / _TileSize.x));
  tmpvar_7 = ((tmpvar_7 + tmpvar_29) / _TileSize);
  gl_Position = (unity_MatrixVP * vert_24);
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump vec4 _FlashColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.xyz = (outColor_1.xyz + (_FlashColor * xlv_TEXCOORD1).xyz);
  outColor_1.w = (texColor_2.w * xlv_COLOR0.w);
  outColor_1.w = clamp (outColor_1.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixInvV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp vec2 _TileSize;
uniform highp float _EmitterWidth;
uniform highp float _AspectRatio;
uniform highp vec4 _FlashPoint00;
uniform highp vec4 _FlashPoint01;
uniform highp vec4 _FlashPoint02;
uniform highp vec4 _FlashPoint03;
uniform highp vec4 _FlashPoint04;
uniform highp vec4 _FlashPoint05;
uniform highp vec4 _FlashAttenFactors;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  highp mat4 m_1;
  m_1 = (unity_WorldToObject * unity_MatrixInvV);
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.x = m_1[0].x;
  tmpvar_2.y = m_1[1].x;
  tmpvar_2.z = m_1[2].x;
  tmpvar_2.w = m_1[3].x;
  tmpvar_3.x = m_1[0].y;
  tmpvar_3.y = m_1[1].y;
  tmpvar_3.z = m_1[2].y;
  tmpvar_3.w = m_1[3].y;
  tmpvar_4.x = m_1[0].z;
  tmpvar_4.y = m_1[1].z;
  tmpvar_4.z = m_1[2].z;
  tmpvar_4.w = m_1[3].z;
  tmpvar_5.x = m_1[0].w;
  tmpvar_5.y = m_1[1].w;
  tmpvar_5.z = m_1[2].w;
  tmpvar_5.w = m_1[3].w;
  highp vec4 tmpvar_6;
  mediump vec2 tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex);
  tmpvar_6 = (tmpvar_6 / tmpvar_6.w);
  highp float ret_9;
  highp float tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_FlashPoint00.xyz - tmpvar_6.xyz);
  tmpvar_10 = sqrt(dot (tmpvar_11, tmpvar_11));
  ret_9 = (_FlashPoint00.w / ((_FlashAttenFactors.x + 
    (tmpvar_10 * _FlashAttenFactors.y)
  ) + (
    (tmpvar_10 * tmpvar_10)
   * _FlashAttenFactors.z)));
  highp float tmpvar_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = (_FlashPoint01.xyz - tmpvar_6.xyz);
  tmpvar_12 = sqrt(dot (tmpvar_13, tmpvar_13));
  ret_9 = (ret_9 + (_FlashPoint01.w / (
    (_FlashAttenFactors.x + (tmpvar_12 * _FlashAttenFactors.y))
   + 
    ((tmpvar_12 * tmpvar_12) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = (_FlashPoint02.xyz - tmpvar_6.xyz);
  tmpvar_14 = sqrt(dot (tmpvar_15, tmpvar_15));
  ret_9 = (ret_9 + (_FlashPoint02.w / (
    (_FlashAttenFactors.x + (tmpvar_14 * _FlashAttenFactors.y))
   + 
    ((tmpvar_14 * tmpvar_14) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (_FlashPoint03.xyz - tmpvar_6.xyz);
  tmpvar_16 = sqrt(dot (tmpvar_17, tmpvar_17));
  ret_9 = (ret_9 + (_FlashPoint03.w / (
    (_FlashAttenFactors.x + (tmpvar_16 * _FlashAttenFactors.y))
   + 
    ((tmpvar_16 * tmpvar_16) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_FlashPoint04.xyz - tmpvar_6.xyz);
  tmpvar_18 = sqrt(dot (tmpvar_19, tmpvar_19));
  ret_9 = (ret_9 + (_FlashPoint04.w / (
    (_FlashAttenFactors.x + (tmpvar_18 * _FlashAttenFactors.y))
   + 
    ((tmpvar_18 * tmpvar_18) * _FlashAttenFactors.z)
  )));
  highp float tmpvar_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = (_FlashPoint05.xyz - tmpvar_6.xyz);
  tmpvar_20 = sqrt(dot (tmpvar_21, tmpvar_21));
  ret_9 = (ret_9 + (_FlashPoint05.w / (
    (_FlashAttenFactors.x + (tmpvar_20 * _FlashAttenFactors.y))
   + 
    ((tmpvar_20 * tmpvar_20) * _FlashAttenFactors.z)
  )));
  tmpvar_8 = ret_9;
  highp float tmpvar_22;
  tmpvar_22 = ((_glesColor.y * _EmitterWidth) / _glesColor.z);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22;
  tmpvar_23.y = (tmpvar_22 * _AspectRatio);
  highp vec4 vert_24;
  vert_24.w = tmpvar_6.w;
  highp vec2 offset_25;
  offset_25 = (((_glesMultiTexCoord0.xy * 2.0) - 1.0) * tmpvar_23);
  highp vec4 v_26;
  v_26.x = tmpvar_2.x;
  v_26.y = tmpvar_3.x;
  v_26.z = tmpvar_4.x;
  v_26.w = tmpvar_5.x;
  highp vec4 v_27;
  v_27.x = tmpvar_2.y;
  v_27.y = tmpvar_3.y;
  v_27.z = tmpvar_4.y;
  v_27.w = tmpvar_5.y;
  vert_24.xyz = (tmpvar_6.xyz + ((v_26.xyz * offset_25.x) + (v_27.xyz * offset_25.y)));
  tmpvar_6 = vert_24;
  tmpvar_7 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp int tmpvar_28;
  tmpvar_28 = int(((_glesColor.x * _TileSize.x) * _TileSize.y));
  highp vec2 tmpvar_29;
  tmpvar_29.x = (float(mod (float(tmpvar_28), _TileSize.x)));
  tmpvar_29.y = floor((float(tmpvar_28) / _TileSize.x));
  tmpvar_7 = ((tmpvar_7 + tmpvar_29) / _TileSize);
  gl_Position = (unity_MatrixVP * vert_24);
  xlv_TEXCOORD0 = tmpvar_7;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_8;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump vec4 _BrightColor;
uniform mediump vec4 _DarkColor;
uniform mediump vec4 _SecondDarkColor;
uniform mediump vec4 _RimColor;
uniform mediump vec4 _FlashColor;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
varying mediump float xlv_TEXCOORD1;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec4 texColor_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_3;
  texColor_2.xyz = texColor_2.xyz;
  outColor_1.xyz = _BrightColor.xyz;
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_4, _DarkColor, vec4((texColor_2.x * _DarkColor.w))).xyz;
  mediump vec4 tmpvar_5;
  tmpvar_5.w = 0.0;
  tmpvar_5.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_5, _SecondDarkColor, vec4((texColor_2.y * _SecondDarkColor.w))).xyz;
  mediump vec4 tmpvar_6;
  tmpvar_6.w = 0.0;
  tmpvar_6.xyz = outColor_1.xyz;
  outColor_1.xyz = mix (tmpvar_6, _RimColor, vec4((texColor_2.z * _RimColor.w))).xyz;
  outColor_1.xyz = (outColor_1.xyz * _EmissionScaler);
  outColor_1.xyz = (outColor_1.xyz + (_FlashColor * xlv_TEXCOORD1).xyz);
  outColor_1.w = (texColor_2.w * xlv_COLOR0.w);
  outColor_1.w = clamp (outColor_1.w, 0.0, 1.0);
  gl_FragData[0] = outColor_1;
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
}