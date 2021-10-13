//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewCommon/Scene_Air_Water_OffsetWave" {
Properties {
_TextureNoise ("TextureNoise ", 2D) = "white" { }
_OffsetSpeed ("OffsetSpeed", Vector) = (0,0,0,0)
_OffsetTilling ("OffsetTilling", Vector) = (1,1,0,0)
_MainColor ("MainColor", Color) = (0.7830189,0.7830189,0.7830189,0)
_OffsetIndensity ("OffsetIndensity", Float) = 0.37
_mainMaskTexture ("mainMaskTexture", 2D) = "white" { }
_Step ("Step", Float) = 0.26
_Opacity ("Opacity", Float) = 0
_texcoord ("", 2D) = "white" { }
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 30838
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _OffsetSpeed) + (_glesMultiTexCoord0.xy * _OffsetTilling));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_TextureNoise, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_mainMaskTexture, tmpvar_5.xy, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4 * _OffsetIndensity) * (tmpvar_7 * tmpvar_8)).xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
uniform highp float _Opacity;
uniform highp float _Step;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode16_3;
  highp vec4 tex2DNode6_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _OffsetSpeed) + (xlv_TEXCOORD0.xy * _OffsetTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_TextureNoise, tmpvar_5);
  tex2DNode6_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_mainMaskTexture, tmpvar_7);
  tex2DNode16_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tex2DNode6_4 * _OffsetIndensity) * tex2DNode16_3);
  highp float tmpvar_10;
  tmpvar_10 = (_Opacity * vec4(greaterThanEqual (
    (_MainColor * tmpvar_9)
  , vec4(_Step)))).x;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor + tmpvar_9).xyz;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _OffsetSpeed) + (_glesMultiTexCoord0.xy * _OffsetTilling));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_TextureNoise, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_mainMaskTexture, tmpvar_5.xy, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4 * _OffsetIndensity) * (tmpvar_7 * tmpvar_8)).xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
uniform highp float _Opacity;
uniform highp float _Step;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode16_3;
  highp vec4 tex2DNode6_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _OffsetSpeed) + (xlv_TEXCOORD0.xy * _OffsetTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_TextureNoise, tmpvar_5);
  tex2DNode6_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_mainMaskTexture, tmpvar_7);
  tex2DNode16_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tex2DNode6_4 * _OffsetIndensity) * tex2DNode16_3);
  highp float tmpvar_10;
  tmpvar_10 = (_Opacity * vec4(greaterThanEqual (
    (_MainColor * tmpvar_9)
  , vec4(_Step)))).x;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor + tmpvar_9).xyz;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _OffsetSpeed) + (_glesMultiTexCoord0.xy * _OffsetTilling));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_TextureNoise, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_glesMultiTexCoord0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_mainMaskTexture, tmpvar_5.xy, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = tmpvar_6;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 0.0;
  tmpvar_8.xyz = _glesNormal;
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4 * _OffsetIndensity) * (tmpvar_7 * tmpvar_8)).xyz);
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _TextureNoise;
uniform highp vec2 _OffsetSpeed;
uniform highp vec2 _OffsetTilling;
uniform highp float _OffsetIndensity;
uniform sampler2D _mainMaskTexture;
uniform highp vec4 _mainMaskTexture_ST;
uniform highp float _Opacity;
uniform highp float _Step;
uniform highp vec4 _MainColor;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode16_3;
  highp vec4 tex2DNode6_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _OffsetSpeed) + (xlv_TEXCOORD0.xy * _OffsetTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_TextureNoise, tmpvar_5);
  tex2DNode6_4 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = ((xlv_TEXCOORD0.xy * _mainMaskTexture_ST.xy) + _mainMaskTexture_ST.zw);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_mainMaskTexture, tmpvar_7);
  tex2DNode16_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tex2DNode6_4 * _OffsetIndensity) * tex2DNode16_3);
  highp float tmpvar_10;
  tmpvar_10 = (_Opacity * vec4(greaterThanEqual (
    (_MainColor * tmpvar_9)
  , vec4(_Step)))).x;
  aseOutAlpha_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (_MainColor + tmpvar_9).xyz;
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
CustomEditor "MoleMole.ShaderEditorBase"
}