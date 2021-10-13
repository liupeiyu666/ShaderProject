//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_AreaRadialBlur_New" {
Properties {
_fSampleDist ("SampleDist", Float) = 1
_fSampleStrength ("SampleStrength", Float) = 2.2
_MaskTex ("MaskTex", 2D) = "white" { }
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" }
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 35337
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _BeforeAlphaTexture_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _BeforeAlphaTexture_ST.xy) + _BeforeAlphaTexture_ST.zw);
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _fSampleDist;
uniform highp float _fSampleStrength;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 sum_2;
  highp vec4 color_3;
  mediump vec3 MaskTexColor_4;
  highp vec2 dir_5;
  dir_5 = normalize((vec2(0.5, 0.5) - xlv_TEXCOORD));
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD2.z, 0.0, 1.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (texture2D (_MaskTex, tmpvar_6).xyz * tmpvar_7);
  MaskTexColor_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD1 / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BeforeAlphaTexture, tmpvar_9.xy);
  color_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_9.xy + ((dir_5 * -0.05) * _fSampleDist));
  tmpvar_11 = texture2D (_BeforeAlphaTexture, P_12);
  sum_2 = (color_3 + tmpvar_11);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_9.xy + ((dir_5 * -0.03) * _fSampleDist));
  tmpvar_13 = texture2D (_BeforeAlphaTexture, P_14);
  sum_2 = (sum_2 + tmpvar_13);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_9.xy + ((dir_5 * -0.01) * _fSampleDist));
  tmpvar_15 = texture2D (_BeforeAlphaTexture, P_16);
  sum_2 = (sum_2 + tmpvar_15);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_9.xy + ((dir_5 * 0.01) * _fSampleDist));
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  sum_2 = (sum_2 + tmpvar_17);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_9.xy + ((dir_5 * 0.03) * _fSampleDist));
  tmpvar_19 = texture2D (_BeforeAlphaTexture, P_20);
  sum_2 = (sum_2 + tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_9.xy + ((dir_5 * 0.05) * _fSampleDist));
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  sum_2 = (sum_2 + tmpvar_21);
  sum_2 = (sum_2 / 7.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (color_3, sum_2, vec4((clamp (_fSampleStrength, 0.0, 1.0) * MaskTexColor_4.x)));
  tmpvar_1 = tmpvar_23;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _BeforeAlphaTexture_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _BeforeAlphaTexture_ST.xy) + _BeforeAlphaTexture_ST.zw);
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _fSampleDist;
uniform highp float _fSampleStrength;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 sum_2;
  highp vec4 color_3;
  mediump vec3 MaskTexColor_4;
  highp vec2 dir_5;
  dir_5 = normalize((vec2(0.5, 0.5) - xlv_TEXCOORD));
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD2.z, 0.0, 1.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (texture2D (_MaskTex, tmpvar_6).xyz * tmpvar_7);
  MaskTexColor_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD1 / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BeforeAlphaTexture, tmpvar_9.xy);
  color_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_9.xy + ((dir_5 * -0.05) * _fSampleDist));
  tmpvar_11 = texture2D (_BeforeAlphaTexture, P_12);
  sum_2 = (color_3 + tmpvar_11);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_9.xy + ((dir_5 * -0.03) * _fSampleDist));
  tmpvar_13 = texture2D (_BeforeAlphaTexture, P_14);
  sum_2 = (sum_2 + tmpvar_13);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_9.xy + ((dir_5 * -0.01) * _fSampleDist));
  tmpvar_15 = texture2D (_BeforeAlphaTexture, P_16);
  sum_2 = (sum_2 + tmpvar_15);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_9.xy + ((dir_5 * 0.01) * _fSampleDist));
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  sum_2 = (sum_2 + tmpvar_17);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_9.xy + ((dir_5 * 0.03) * _fSampleDist));
  tmpvar_19 = texture2D (_BeforeAlphaTexture, P_20);
  sum_2 = (sum_2 + tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_9.xy + ((dir_5 * 0.05) * _fSampleDist));
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  sum_2 = (sum_2 + tmpvar_21);
  sum_2 = (sum_2 / 7.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (color_3, sum_2, vec4((clamp (_fSampleStrength, 0.0, 1.0) * MaskTexColor_4.x)));
  tmpvar_1 = tmpvar_23;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _BeforeAlphaTexture_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD = ((_glesMultiTexCoord0.xy * _BeforeAlphaTexture_ST.xy) + _BeforeAlphaTexture_ST.zw);
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _BeforeAlphaTexture;
uniform highp float _fSampleDist;
uniform highp float _fSampleStrength;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
varying highp vec2 xlv_TEXCOORD;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 sum_2;
  highp vec4 color_3;
  mediump vec3 MaskTexColor_4;
  highp vec2 dir_5;
  dir_5 = normalize((vec2(0.5, 0.5) - xlv_TEXCOORD));
  highp vec2 tmpvar_6;
  tmpvar_6 = ((xlv_TEXCOORD * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_7;
  tmpvar_7 = clamp (xlv_TEXCOORD2.z, 0.0, 1.0);
  lowp vec3 tmpvar_8;
  tmpvar_8 = (texture2D (_MaskTex, tmpvar_6).xyz * tmpvar_7);
  MaskTexColor_4 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD1 / xlv_TEXCOORD1.w);
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_BeforeAlphaTexture, tmpvar_9.xy);
  color_3 = tmpvar_10;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = (tmpvar_9.xy + ((dir_5 * -0.05) * _fSampleDist));
  tmpvar_11 = texture2D (_BeforeAlphaTexture, P_12);
  sum_2 = (color_3 + tmpvar_11);
  lowp vec4 tmpvar_13;
  highp vec2 P_14;
  P_14 = (tmpvar_9.xy + ((dir_5 * -0.03) * _fSampleDist));
  tmpvar_13 = texture2D (_BeforeAlphaTexture, P_14);
  sum_2 = (sum_2 + tmpvar_13);
  lowp vec4 tmpvar_15;
  highp vec2 P_16;
  P_16 = (tmpvar_9.xy + ((dir_5 * -0.01) * _fSampleDist));
  tmpvar_15 = texture2D (_BeforeAlphaTexture, P_16);
  sum_2 = (sum_2 + tmpvar_15);
  lowp vec4 tmpvar_17;
  highp vec2 P_18;
  P_18 = (tmpvar_9.xy + ((dir_5 * 0.01) * _fSampleDist));
  tmpvar_17 = texture2D (_BeforeAlphaTexture, P_18);
  sum_2 = (sum_2 + tmpvar_17);
  lowp vec4 tmpvar_19;
  highp vec2 P_20;
  P_20 = (tmpvar_9.xy + ((dir_5 * 0.03) * _fSampleDist));
  tmpvar_19 = texture2D (_BeforeAlphaTexture, P_20);
  sum_2 = (sum_2 + tmpvar_19);
  lowp vec4 tmpvar_21;
  highp vec2 P_22;
  P_22 = (tmpvar_9.xy + ((dir_5 * 0.05) * _fSampleDist));
  tmpvar_21 = texture2D (_BeforeAlphaTexture, P_22);
  sum_2 = (sum_2 + tmpvar_21);
  sum_2 = (sum_2 / 7.0);
  highp vec4 tmpvar_23;
  tmpvar_23 = mix (color_3, sum_2, vec4((clamp (_fSampleStrength, 0.0, 1.0) * MaskTexColor_4.x)));
  tmpvar_1 = tmpvar_23;
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
}
}
}
Fallback "Diffuse"
}