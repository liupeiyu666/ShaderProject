//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Distortion/Distortion_GlassEffect" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainTextureIntensity ("MainTextureIntensity", Float) = 1
_MainTextureColor ("MainTextureColor", Color) = (1,1,1,0)
_Opacity ("Opacity", Float) = 0
_FresnelColor ("FresnelColor", Color) = (0.1453287,0.6777233,0.9411765,0)
_Fresnel ("Fresnel", Vector) = (0,1,5,0)
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 30960
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = _glesMultiTexCoord0;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Opacity;
uniform highp vec3 _Fresnel;
uniform highp vec4 _FresnelColor;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp float _MainTextureIntensity;
uniform highp vec4 _MainTextureColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 OutColor_1;
  mediump vec3 MainTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD2.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTexture, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4.xyz * _MainTextureIntensity) * _MainTextureColor.xyz);
  MainTexColor_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (_Opacity, 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (((_Fresnel.x + 
    (_Fresnel.y * pow ((1.0 - dot (xlv_TEXCOORD1.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz))
    )), _Fresnel.y))
  ) * _FresnelColor).xyz + MainTexColor_2);
  OutColor_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = OutColor_1;
  tmpvar_9.w = tmpvar_6;
  gl_FragData[0] = tmpvar_9;
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = _glesMultiTexCoord0;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Opacity;
uniform highp vec3 _Fresnel;
uniform highp vec4 _FresnelColor;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp float _MainTextureIntensity;
uniform highp vec4 _MainTextureColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 OutColor_1;
  mediump vec3 MainTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD2.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTexture, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4.xyz * _MainTextureIntensity) * _MainTextureColor.xyz);
  MainTexColor_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (_Opacity, 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (((_Fresnel.x + 
    (_Fresnel.y * pow ((1.0 - dot (xlv_TEXCOORD1.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz))
    )), _Fresnel.y))
  ) * _FresnelColor).xyz + MainTexColor_2);
  OutColor_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = OutColor_1;
  tmpvar_9.w = tmpvar_6;
  gl_FragData[0] = tmpvar_9;
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
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  tmpvar_3.xyz = normalize((_glesNormal * tmpvar_4));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = _glesMultiTexCoord0;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp float _Opacity;
uniform highp vec3 _Fresnel;
uniform highp vec4 _FresnelColor;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp float _MainTextureIntensity;
uniform highp vec4 _MainTextureColor;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 OutColor_1;
  mediump vec3 MainTexColor_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((xlv_TEXCOORD2.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTexture, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = ((tmpvar_4.xyz * _MainTextureIntensity) * _MainTextureColor.xyz);
  MainTexColor_2 = tmpvar_5;
  mediump float tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = clamp (_Opacity, 0.0, 1.0);
  tmpvar_6 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = (((_Fresnel.x + 
    (_Fresnel.y * pow ((1.0 - dot (xlv_TEXCOORD1.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD0.xyz))
    )), _Fresnel.y))
  ) * _FresnelColor).xyz + MainTexColor_2);
  OutColor_1 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = OutColor_1;
  tmpvar_9.w = tmpvar_6;
  gl_FragData[0] = tmpvar_9;
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