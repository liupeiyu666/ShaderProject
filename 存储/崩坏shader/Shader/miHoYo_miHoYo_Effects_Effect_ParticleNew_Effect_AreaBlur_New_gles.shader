//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AreaBlur_New" {
Properties {
_MainMaskTex ("MainMaskTex", 2D) = "white" { }
_MainMaskIntensity ("MainMaskIntensity", Float) = 1
_Color ("Main Color", Color) = (1,1,1,1)
_ColorIntensity ("ColorIntensity", Float) = 1
_Size ("Size", Range(0, 20)) = 1
_Offset ("Offset", Range(0, 0.1)) = 0.01
}
SubShader {
 Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Name "BACKBLURHOR"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 5972
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesNormal * _Offset);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (_glesVertex + tmpvar_3).xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.y = -(tmpvar_4.y);
  tmpvar_1.xy = ((tmpvar_6 + tmpvar_4.w) * 0.5);
  tmpvar_1.zw = tmpvar_4.zw;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
uniform highp float _Size;
uniform highp float _ColorIntensity;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernelx_7;
  kernelx_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_7) * _Size));
  tmpvar_8.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernelx_11;
  kernelx_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_11) * _Size));
  tmpvar_12.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernelx_15;
  kernelx_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_15) * _Size));
  tmpvar_16.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernelx_19;
  kernelx_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_19) * _Size));
  tmpvar_20.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernelx_23;
  kernelx_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_23) * _Size));
  tmpvar_24.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernelx_27;
  kernelx_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_27) * _Size));
  tmpvar_28.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernelx_31;
  kernelx_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_31) * _Size));
  tmpvar_32.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesNormal * _Offset);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (_glesVertex + tmpvar_3).xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.y = -(tmpvar_4.y);
  tmpvar_1.xy = ((tmpvar_6 + tmpvar_4.w) * 0.5);
  tmpvar_1.zw = tmpvar_4.zw;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
uniform highp float _Size;
uniform highp float _ColorIntensity;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernelx_7;
  kernelx_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_7) * _Size));
  tmpvar_8.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernelx_11;
  kernelx_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_11) * _Size));
  tmpvar_12.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernelx_15;
  kernelx_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_15) * _Size));
  tmpvar_16.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernelx_19;
  kernelx_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_19) * _Size));
  tmpvar_20.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernelx_23;
  kernelx_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_23) * _Size));
  tmpvar_24.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernelx_27;
  kernelx_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_27) * _Size));
  tmpvar_28.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernelx_31;
  kernelx_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_31) * _Size));
  tmpvar_32.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 0.0;
  tmpvar_3.xyz = (_glesNormal * _Offset);
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = (_glesVertex + tmpvar_3).xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_4.x;
  tmpvar_6.y = -(tmpvar_4.y);
  tmpvar_1.xy = ((tmpvar_6 + tmpvar_4.w) * 0.5);
  tmpvar_1.zw = tmpvar_4.zw;
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
uniform highp float _Size;
uniform highp float _ColorIntensity;
uniform highp vec4 _Color;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernelx_7;
  kernelx_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_7) * _Size));
  tmpvar_8.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernelx_11;
  kernelx_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_11) * _Size));
  tmpvar_12.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernelx_15;
  kernelx_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_15) * _Size));
  tmpvar_16.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernelx_19;
  kernelx_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_19) * _Size));
  tmpvar_20.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernelx_23;
  kernelx_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_23) * _Size));
  tmpvar_24.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernelx_27;
  kernelx_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_27) * _Size));
  tmpvar_28.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernelx_31;
  kernelx_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernelx_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = (xlv_TEXCOORD0.x + ((_BeforeAlphaTexture_TexelSize.x * kernelx_31) * _Size));
  tmpvar_32.yzw = xlv_TEXCOORD0.yzw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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
  Name "BACKBLURVER"
  Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "ALWAYS" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 107430
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = (tmpvar_1 * _Offset).xyz;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (_glesVertex + tmpvar_4).xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_5.x;
  tmpvar_7.y = -(tmpvar_5.y);
  tmpvar_2.xy = ((tmpvar_7 + tmpvar_5.w) * 0.5);
  tmpvar_2.zw = tmpvar_5.zw;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform highp float _Size;
uniform highp vec4 _Color;
uniform highp float _ColorIntensity;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernely_7;
  kernely_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.x;
  tmpvar_8.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_7) * _Size));
  tmpvar_8.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernely_11;
  kernely_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_11) * _Size));
  tmpvar_12.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernely_15;
  kernely_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD0.x;
  tmpvar_16.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_15) * _Size));
  tmpvar_16.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernely_19;
  kernely_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_19) * _Size));
  tmpvar_20.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernely_23;
  kernely_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_23) * _Size));
  tmpvar_24.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernely_27;
  kernely_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = xlv_TEXCOORD0.x;
  tmpvar_28.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_27) * _Size));
  tmpvar_28.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernely_31;
  kernely_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = xlv_TEXCOORD0.x;
  tmpvar_32.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_31) * _Size));
  tmpvar_32.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = (tmpvar_1 * _Offset).xyz;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (_glesVertex + tmpvar_4).xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_5.x;
  tmpvar_7.y = -(tmpvar_5.y);
  tmpvar_2.xy = ((tmpvar_7 + tmpvar_5.w) * 0.5);
  tmpvar_2.zw = tmpvar_5.zw;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform highp float _Size;
uniform highp vec4 _Color;
uniform highp float _ColorIntensity;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernely_7;
  kernely_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.x;
  tmpvar_8.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_7) * _Size));
  tmpvar_8.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernely_11;
  kernely_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_11) * _Size));
  tmpvar_12.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernely_15;
  kernely_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD0.x;
  tmpvar_16.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_15) * _Size));
  tmpvar_16.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernely_19;
  kernely_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_19) * _Size));
  tmpvar_20.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernely_23;
  kernely_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_23) * _Size));
  tmpvar_24.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernely_27;
  kernely_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = xlv_TEXCOORD0.x;
  tmpvar_28.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_27) * _Size));
  tmpvar_28.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernely_31;
  kernely_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = xlv_TEXCOORD0.x;
  tmpvar_32.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_31) * _Size));
  tmpvar_32.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainMaskTex_ST;
uniform highp float _Offset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 0.0;
  tmpvar_1.xyz = _glesNormal;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 0.0;
  tmpvar_4.xyz = (tmpvar_1 * _Offset).xyz;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = (_glesVertex + tmpvar_4).xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_5.x;
  tmpvar_7.y = -(tmpvar_5.y);
  tmpvar_2.xy = ((tmpvar_7 + tmpvar_5.w) * 0.5);
  tmpvar_2.zw = tmpvar_5.zw;
  tmpvar_3.xy = ((_glesMultiTexCoord0.xy * _MainMaskTex_ST.xy) + _MainMaskTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp vec4 _BeforeAlphaTexture_TexelSize;
uniform highp float _Size;
uniform highp vec4 _Color;
uniform highp float _ColorIntensity;
uniform sampler2D _MainMaskTex;
uniform highp float _MainMaskIntensity;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp float decayFactor_1;
  highp vec4 col5_2;
  mediump vec4 maskTex_3;
  mediump vec4 sum_4;
  sum_4 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainMaskTex, xlv_TEXCOORD1.xy);
  maskTex_3 = tmpvar_5;
  mediump vec4 tmpvar_6;
  highp float kernely_7;
  kernely_7 = -3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_7 = 0.0;
  };
  highp vec4 tmpvar_8;
  tmpvar_8.x = xlv_TEXCOORD0.x;
  tmpvar_8.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_7) * _Size));
  tmpvar_8.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2DProj (_BeforeAlphaTexture, tmpvar_8);
  tmpvar_6 = (tmpvar_9 * 0.09);
  sum_4 = tmpvar_6;
  mediump vec4 tmpvar_10;
  highp float kernely_11;
  kernely_11 = -2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_11 = 0.0;
  };
  highp vec4 tmpvar_12;
  tmpvar_12.x = xlv_TEXCOORD0.x;
  tmpvar_12.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_11) * _Size));
  tmpvar_12.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_BeforeAlphaTexture, tmpvar_12);
  tmpvar_10 = (tmpvar_13 * 0.12);
  sum_4 = (tmpvar_6 + tmpvar_10);
  mediump vec4 tmpvar_14;
  highp float kernely_15;
  kernely_15 = -1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_15 = 0.0;
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = xlv_TEXCOORD0.x;
  tmpvar_16.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_15) * _Size));
  tmpvar_16.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_BeforeAlphaTexture, tmpvar_16);
  tmpvar_14 = (tmpvar_17 * 0.15);
  sum_4 = (sum_4 + tmpvar_14);
  mediump vec4 tmpvar_18;
  highp float kernely_19;
  kernely_19 = 0.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_19 = 0.0;
  };
  highp vec4 tmpvar_20;
  tmpvar_20.x = xlv_TEXCOORD0.x;
  tmpvar_20.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_19) * _Size));
  tmpvar_20.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2DProj (_BeforeAlphaTexture, tmpvar_20);
  tmpvar_18 = (tmpvar_21 * 0.18);
  sum_4 = (sum_4 + tmpvar_18);
  mediump vec4 tmpvar_22;
  highp float kernely_23;
  kernely_23 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_23 = 0.0;
  };
  highp vec4 tmpvar_24;
  tmpvar_24.x = xlv_TEXCOORD0.x;
  tmpvar_24.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_23) * _Size));
  tmpvar_24.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2DProj (_BeforeAlphaTexture, tmpvar_24);
  tmpvar_22 = (tmpvar_25 * 0.15);
  sum_4 = (sum_4 + tmpvar_22);
  mediump vec4 tmpvar_26;
  highp float kernely_27;
  kernely_27 = 2.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_27 = 0.0;
  };
  highp vec4 tmpvar_28;
  tmpvar_28.x = xlv_TEXCOORD0.x;
  tmpvar_28.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_27) * _Size));
  tmpvar_28.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_29;
  tmpvar_29 = texture2DProj (_BeforeAlphaTexture, tmpvar_28);
  tmpvar_26 = (tmpvar_29 * 0.12);
  sum_4 = (sum_4 + tmpvar_26);
  mediump vec4 tmpvar_30;
  highp float kernely_31;
  kernely_31 = 3.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    kernely_31 = 0.0;
  };
  highp vec4 tmpvar_32;
  tmpvar_32.x = xlv_TEXCOORD0.x;
  tmpvar_32.y = (xlv_TEXCOORD0.y + ((_BeforeAlphaTexture_TexelSize.y * kernely_31) * _Size));
  tmpvar_32.zw = xlv_TEXCOORD0.zw;
  lowp vec4 tmpvar_33;
  tmpvar_33 = texture2DProj (_BeforeAlphaTexture, tmpvar_32);
  tmpvar_30 = (tmpvar_33 * 0.09);
  sum_4 = (sum_4 + tmpvar_30);
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2DProj (_BeforeAlphaTexture, xlv_TEXCOORD0);
  col5_2 = tmpvar_34;
  decayFactor_1 = 1.0;
  if (((xlv_TEXCOORD0.x == 0.0) && (xlv_TEXCOORD0.y == 0.0))) {
    decayFactor_1 = 0.0;
  };
  highp vec4 tmpvar_35;
  tmpvar_35 = mix (col5_2, ((sum_4 * _Color) * _ColorIntensity), clamp ((
    (decayFactor_1 * maskTex_3)
   * _MainMaskIntensity), vec4(0.0, 0.0, 0.0, 0.0), vec4(1.0, 1.0, 1.0, 1.0)));
  sum_4 = tmpvar_35;
  gl_FragData[0] = sum_4;
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