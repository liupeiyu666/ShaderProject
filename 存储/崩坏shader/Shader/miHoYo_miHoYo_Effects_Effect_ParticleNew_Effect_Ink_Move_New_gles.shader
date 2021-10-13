//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/Effect_Ink_Move_New" {
Properties {
_MainColor ("MainColor", Color) = (1,1,1,0)
_MainIntensity ("MainIntensity", Float) = 1
_EdgeColor ("EdgeColor", Color) = (0.1391652,0.3868571,0.7279412,0)
_EdgeColorIntensity ("EdgeColorIntensity", Float) = 1
_MainTexture ("MainTexture", 2D) = "white" { }
_mainTexSpeed ("mainTexSpeed", Vector) = (0,0,0,0)
_NoiseTex ("NoiseTex", 2D) = "white" { }
_NoiseIntensity ("NoiseIntensity", Float) = 0
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_NoiseTex02 ("NoiseTex02", 2D) = "white" { }
_Noise02Speed ("Noise02Speed", Vector) = (0,0,0,0)
_Noise02Intensity ("Noise02Intensity", Float) = 0
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 52452
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeColorIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode4_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _Noise02Speed) + ((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex02, tmpvar_5);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((
    (_Time.y * _mainTexSpeed)
   + 
    ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw)
  ) + (tmpvar_6.x * _NoiseIntensity)) + (tmpvar_7.x * _Noise02Intensity));
  tmpvar_8 = texture2D (_MainTexture, P_9);
  tex2DNode4_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (tex2DNode4_3.x * xlv_COLOR.w);
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tex2DNode4_3 * _MainColor) * _MainIntensity) + ((tex2DNode4_3.w * _EdgeColor) * _EdgeColorIntensity)).xyz;
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeColorIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode4_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _Noise02Speed) + ((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex02, tmpvar_5);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((
    (_Time.y * _mainTexSpeed)
   + 
    ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw)
  ) + (tmpvar_6.x * _NoiseIntensity)) + (tmpvar_7.x * _Noise02Intensity));
  tmpvar_8 = texture2D (_MainTexture, P_9);
  tex2DNode4_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (tex2DNode4_3.x * xlv_COLOR.w);
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tex2DNode4_3 * _MainColor) * _MainIntensity) + ((tex2DNode4_3.w * _EdgeColor) * _EdgeColorIntensity)).xyz;
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
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
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTexture;
uniform highp vec2 _mainTexSpeed;
uniform highp vec4 _MainTexture_ST;
uniform sampler2D _NoiseTex;
uniform highp vec2 _NoiseSpeed;
uniform highp vec4 _NoiseTex_ST;
uniform highp float _NoiseIntensity;
uniform sampler2D _NoiseTex02;
uniform highp vec2 _Noise02Speed;
uniform highp vec4 _NoiseTex02_ST;
uniform highp float _Noise02Intensity;
uniform highp vec4 _MainColor;
uniform highp float _MainIntensity;
uniform highp vec4 _EdgeColor;
uniform highp float _EdgeColorIntensity;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode4_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_Time.y * _NoiseSpeed) + ((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw));
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _Noise02Speed) + ((xlv_TEXCOORD0.xy * _NoiseTex02_ST.xy) + _NoiseTex02_ST.zw));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_NoiseTex, tmpvar_4);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_NoiseTex02, tmpvar_5);
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (((
    (_Time.y * _mainTexSpeed)
   + 
    ((xlv_TEXCOORD0.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw)
  ) + (tmpvar_6.x * _NoiseIntensity)) + (tmpvar_7.x * _Noise02Intensity));
  tmpvar_8 = texture2D (_MainTexture, P_9);
  tex2DNode4_3 = tmpvar_8;
  highp float tmpvar_10;
  tmpvar_10 = (tex2DNode4_3.x * xlv_COLOR.w);
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tex2DNode4_3 * _MainColor) * _MainIntensity) + ((tex2DNode4_3.w * _EdgeColor) * _EdgeColorIntensity)).xyz;
  aseOutColor_1 = tmpvar_11;
  mediump float tmpvar_12;
  tmpvar_12 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13.xyz = aseOutColor_1;
  tmpvar_13.w = tmpvar_12;
  gl_FragData[0] = tmpvar_13;
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
CustomEditor "MoleMole.ParticleShaderEditorBase"
}