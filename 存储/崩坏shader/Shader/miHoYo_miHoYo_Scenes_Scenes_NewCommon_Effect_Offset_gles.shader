//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Effect_Offset" {
Properties {
_MainTexture ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,0)
_mainColorIndensity ("mainColorIndensity", Float) = 1
_NoiseTexture ("NoiseTexture", 2D) = "white" { }
_NoiseOffset ("NoiseOffset", Vector) = (0,0,0,0)
_NoiseSpeed ("NoiseSpeed", Vector) = (0,0,0,0)
_FresnelOpacity ("FresnelOpacity", Vector) = (0,1,5,0)
_texcoord2 ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 58423
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _NoiseOffset;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _NoiseSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = _NoiseOffset;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _NoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_NoiseTexture, tmpvar_6.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_5 * tmpvar_7).xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _FresnelOpacity;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _mainColorIndensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode11_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexture, tmpvar_4);
  tex2DNode11_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (clamp ((_FresnelOpacity.x + 
    (_FresnelOpacity.y * pow ((1.0 - dot (xlv_TEXCOORD4.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), _FresnelOpacity.z))
  ), 0.0, 1.0) * tex2DNode11_3).x;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode11_3 * _MainColor) * _mainColorIndensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _NoiseOffset;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _NoiseSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = _NoiseOffset;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _NoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_NoiseTexture, tmpvar_6.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_5 * tmpvar_7).xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _FresnelOpacity;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _mainColorIndensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode11_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexture, tmpvar_4);
  tex2DNode11_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (clamp ((_FresnelOpacity.x + 
    (_FresnelOpacity.y * pow ((1.0 - dot (xlv_TEXCOORD4.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), _FresnelOpacity.z))
  ), 0.0, 1.0) * tex2DNode11_3).x;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode11_3 * _MainColor) * _mainColorIndensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
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
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec2 _NoiseOffset;
uniform sampler2D _NoiseTexture;
uniform highp vec2 _NoiseSpeed;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
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
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = _NoiseOffset;
  highp vec4 tmpvar_6;
  tmpvar_6.zw = vec2(0.0, 0.0);
  tmpvar_6.xy = ((_Time.y * _NoiseSpeed) + _glesMultiTexCoord0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DLod (_NoiseTexture, tmpvar_6.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + (tmpvar_5 * tmpvar_7).xyz);
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec3 _FresnelOpacity;
uniform sampler2D _MainTexture;
uniform highp vec4 _MainTexture_ST;
uniform highp vec4 _MainColor;
uniform highp float _mainColorIndensity;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode11_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD1.xy * _MainTexture_ST.xy) + _MainTexture_ST.zw);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTexture, tmpvar_4);
  tex2DNode11_3 = tmpvar_5;
  highp float tmpvar_6;
  tmpvar_6 = (clamp ((_FresnelOpacity.x + 
    (_FresnelOpacity.y * pow ((1.0 - dot (xlv_TEXCOORD4.xyz, 
      normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz))
    )), _FresnelOpacity.z))
  ), 0.0, 1.0) * tex2DNode11_3).x;
  aseOutAlpha_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = ((tex2DNode11_3 * _MainColor) * _mainColorIndensity).xyz;
  aseOutColor_1 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = aseOutColor_1;
  tmpvar_9.w = tmpvar_8;
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
CustomEditor "ASEMaterialInspector"
}