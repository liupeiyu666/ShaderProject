//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_ElectricityNew" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainIntensity ("MainIntensity", Float) = 0
_MainColor ("MainColor", Color) = (0,0,0,0)
_NoiseTex01 ("NoiseTex01", 2D) = "white" { }
_Noise1Tilling ("Noise1Tilling", Vector) = (0,0,0,0)
_Noise01Intensity ("Noise01Intensity", Float) = 0
_Noise01Speed01 ("Noise01Speed01", Vector) = (0,0,0,0)
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise2Tilling ("Noise2Tilling", Vector) = (0,0,0,0)
_Noise02Intensity ("Noise02Intensity", Float) = 0
_Noise02Speed01 ("Noise02Speed01", Vector) = (0,0,0,0)
_MaskTex ("MaskTex", 2D) = "white" { }
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 58569
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform sampler2D _NoiseTex01;
uniform highp vec2 _Noise01Speed01;
uniform highp vec2 _Noise1Tilling;
uniform highp float _Noise01Intensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed01;
uniform highp vec2 _Noise2Tilling;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _offsetTex01;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (xlv_TEXCOORD0.xy - vec2(0.5, 0.5));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _offsetTex01;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _Noise01Speed01) + (xlv_TEXCOORD0.xy * _Noise1Tilling)) + tmpvar_5);
  tmpvar_6 = texture2D (_NoiseTex01, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_8.x = _offsetTex01;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((_Time.y * _Noise02Speed01) + (xlv_TEXCOORD0.xy * _Noise2Tilling)) + tmpvar_8);
  tmpvar_9 = texture2D (_NoiseTex02, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_4 + (tmpvar_6 * _Noise01Intensity)) + (tmpvar_9 * _Noise02Intensity)).xy;
  tmpvar_11 = texture2D (_MainTexture, P_12);
  tex2DNode1_3 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_14;
  tmpvar_14 = tex2DNode1_3.x;
  aseOutAlpha_2 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MaskTex, tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tex2DNode1_3 * _MainColor) * (_MainIntensity * tmpvar_15)).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform sampler2D _NoiseTex01;
uniform highp vec2 _Noise01Speed01;
uniform highp vec2 _Noise1Tilling;
uniform highp float _Noise01Intensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed01;
uniform highp vec2 _Noise2Tilling;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _offsetTex01;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (xlv_TEXCOORD0.xy - vec2(0.5, 0.5));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _offsetTex01;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _Noise01Speed01) + (xlv_TEXCOORD0.xy * _Noise1Tilling)) + tmpvar_5);
  tmpvar_6 = texture2D (_NoiseTex01, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_8.x = _offsetTex01;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((_Time.y * _Noise02Speed01) + (xlv_TEXCOORD0.xy * _Noise2Tilling)) + tmpvar_8);
  tmpvar_9 = texture2D (_NoiseTex02, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_4 + (tmpvar_6 * _Noise01Intensity)) + (tmpvar_9 * _Noise02Intensity)).xy;
  tmpvar_11 = texture2D (_MainTexture, P_12);
  tex2DNode1_3 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_14;
  tmpvar_14 = tex2DNode1_3.x;
  aseOutAlpha_2 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MaskTex, tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tex2DNode1_3 * _MainColor) * (_MainIntensity * tmpvar_15)).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform sampler2D _NoiseTex01;
uniform highp vec2 _Noise01Speed01;
uniform highp vec2 _Noise1Tilling;
uniform highp float _Noise01Intensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed01;
uniform highp vec2 _Noise2Tilling;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform sampler2D _MaskTex;
uniform highp vec4 _MaskTex_ST;
uniform highp float _offsetTex01;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode1_3;
  highp vec4 tmpvar_4;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = (xlv_TEXCOORD0.xy - vec2(0.5, 0.5));
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _offsetTex01;
  lowp vec4 tmpvar_6;
  highp vec2 P_7;
  P_7 = (((_Time.y * _Noise01Speed01) + (xlv_TEXCOORD0.xy * _Noise1Tilling)) + tmpvar_5);
  tmpvar_6 = texture2D (_NoiseTex01, P_7);
  highp vec2 tmpvar_8;
  tmpvar_8.y = 0.0;
  tmpvar_8.x = _offsetTex01;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = (((_Time.y * _Noise02Speed01) + (xlv_TEXCOORD0.xy * _Noise2Tilling)) + tmpvar_8);
  tmpvar_9 = texture2D (_NoiseTex02, P_10);
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_4 + (tmpvar_6 * _Noise01Intensity)) + (tmpvar_9 * _Noise02Intensity)).xy;
  tmpvar_11 = texture2D (_MainTexture, P_12);
  tex2DNode1_3 = tmpvar_11;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0.xy * _MaskTex_ST.xy) + _MaskTex_ST.zw);
  highp float tmpvar_14;
  tmpvar_14 = tex2DNode1_3.x;
  aseOutAlpha_2 = tmpvar_14;
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_MaskTex, tmpvar_13);
  highp vec3 tmpvar_16;
  tmpvar_16 = ((tex2DNode1_3 * _MainColor) * (_MainIntensity * tmpvar_15)).xyz;
  aseOutColor_1 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18.xyz = aseOutColor_1;
  tmpvar_18.w = tmpvar_17;
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
}
}
}
CustomEditor "ASEMaterialInspector"
}