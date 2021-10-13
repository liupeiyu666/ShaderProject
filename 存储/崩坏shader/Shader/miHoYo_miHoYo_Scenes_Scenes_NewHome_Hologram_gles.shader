//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Hologram" {
Properties {
[ToolTip] _Brightness ("Brightness", Range(0.1, 6)) = 3
_Alpha ("Alpha", Range(0, 1)) = 1
_MainTex ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_RimPower ("Rim Power", Range(0.1, 10)) = 5
_ScanTiling ("Scan Tiling", Range(0.01, 1000)) = 0.05
_ScanSpeed ("Scan Speed", Range(-2, 2)) = 1
_GlowTiling ("Glow Tiling", Range(0.01, 1)) = 0.05
_GlowSpeed ("Glow Speed", Range(-10, 10)) = 1
_FlickerTex ("Flicker Control Texture", 2D) = "white" { }
_FlickerSpeed ("Flicker Speed", Range(0.01, 100)) = 1
_Fold ("__fld", Float) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 21811
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_MatrixV * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_1.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = (tmpvar_3.z / tmpvar_3.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _FlickerTex;
uniform highp vec4 _MainColor;
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
uniform highp float _Brightness;
uniform highp float _Alpha;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  highp float scan_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_5 = tmpvar_6;
  scan_4 = (float((0.5 >= 
    fract((((xlv_TEXCOORD1.y * _ScanTiling) / xlv_TEXCOORD3) + (_Time.w * _ScanSpeed)))
  )) * 0.65);
  highp float tmpvar_7;
  tmpvar_7 = fract(((xlv_TEXCOORD1.y * _GlowTiling) - (_Time.x * _GlowSpeed)));
  highp vec2 tmpvar_8;
  tmpvar_8 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FlickerTex, tmpvar_8);
  flicker_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - tmpvar_10);
  highp vec4 tmpvar_12;
  tmpvar_12 = (_RimColor * pow (tmpvar_11, _RimPower));
  rimColor_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (((texColor_5 * _MainColor) + (
    (tmpvar_7 * 0.35)
   * _MainColor)) + rimColor_2);
  col_1.xyz = tmpvar_13.xyz;
  col_1.w = (((texColor_5.w * _Alpha) * (
    (scan_4 + tmpvar_11)
   + tmpvar_7)) * flicker_3).x;
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_MatrixV * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_1.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = (tmpvar_3.z / tmpvar_3.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _FlickerTex;
uniform highp vec4 _MainColor;
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
uniform highp float _Brightness;
uniform highp float _Alpha;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  highp float scan_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_5 = tmpvar_6;
  scan_4 = (float((0.5 >= 
    fract((((xlv_TEXCOORD1.y * _ScanTiling) / xlv_TEXCOORD3) + (_Time.w * _ScanSpeed)))
  )) * 0.65);
  highp float tmpvar_7;
  tmpvar_7 = fract(((xlv_TEXCOORD1.y * _GlowTiling) - (_Time.x * _GlowSpeed)));
  highp vec2 tmpvar_8;
  tmpvar_8 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FlickerTex, tmpvar_8);
  flicker_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - tmpvar_10);
  highp vec4 tmpvar_12;
  tmpvar_12 = (_RimColor * pow (tmpvar_11, _RimPower));
  rimColor_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (((texColor_5 * _MainColor) + (
    (tmpvar_7 * 0.35)
   * _MainColor)) + rimColor_2);
  col_1.xyz = tmpvar_13.xyz;
  col_1.w = (((texColor_5.w * _Alpha) * (
    (scan_4 + tmpvar_11)
   + tmpvar_7)) * flicker_3).x;
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixV;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = (unity_ObjectToWorld * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (unity_MatrixV * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_1.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
  xlv_TEXCOORD3 = (tmpvar_3.z / tmpvar_3.w);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform sampler2D _FlickerTex;
uniform highp vec4 _MainColor;
uniform highp vec4 _RimColor;
uniform highp float _RimPower;
uniform highp float _Brightness;
uniform highp float _Alpha;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
varying highp float xlv_TEXCOORD3;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  highp float scan_4;
  mediump vec4 texColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_5 = tmpvar_6;
  scan_4 = (float((0.5 >= 
    fract((((xlv_TEXCOORD1.y * _ScanTiling) / xlv_TEXCOORD3) + (_Time.w * _ScanSpeed)))
  )) * 0.65);
  highp float tmpvar_7;
  tmpvar_7 = fract(((xlv_TEXCOORD1.y * _GlowTiling) - (_Time.x * _GlowSpeed)));
  highp vec2 tmpvar_8;
  tmpvar_8 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_FlickerTex, tmpvar_8);
  flicker_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_11;
  tmpvar_11 = (1.0 - tmpvar_10);
  highp vec4 tmpvar_12;
  tmpvar_12 = (_RimColor * pow (tmpvar_11, _RimPower));
  rimColor_2 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13 = (((texColor_5 * _MainColor) + (
    (tmpvar_7 * 0.35)
   * _MainColor)) + rimColor_2);
  col_1.xyz = tmpvar_13.xyz;
  col_1.w = (((texColor_5.w * _Alpha) * (
    (scan_4 + tmpvar_11)
   + tmpvar_7)) * flicker_3).x;
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
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