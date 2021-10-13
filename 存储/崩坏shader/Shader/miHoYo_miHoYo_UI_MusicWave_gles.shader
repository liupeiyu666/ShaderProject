//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_UI/MusicWave" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
_MainTexIntensity ("MainTexIntensity", Float) = 0
_MainTexColor ("MainTexColor", Color) = (0,0,0,0)
_MainTexIntensityAddColor ("MainTexIntensityAddColor", Float) = 0.1
_OffsetTex ("OffsetTex", 2D) = "white" { }
_OffsetTexSpeed ("OffsetTexSpeed", Vector) = (0,0,0,0)
_OffsetTexTilling ("OffsetTexTilling", Vector) = (1,1,0,0)
_OffsetTexOffset ("OffsetTexOffset", Float) = 0
_MainOffsetMaskTex ("MainOffsetMaskTex", 2D) = "white" { }
_MainOffsetMaskSpeed ("MainOffsetMaskSpeed", Vector) = (0,0,0,0)
_MainOffsetMaskOffset ("MainOffsetMaskOffset", Float) = 0
_MainOffsetMaskTilline ("MainOffsetMaskTilline", Vector) = (1,1,0,0)
_texcoord ("", 2D) = "white" { }
_ScreenClipUp ("ScreenClipUp", Float) = 0.66
_ScreenClipDown ("ScreenClipDown", Float) = 0.18
_ScreenClipWidth ("ScreenClipWidth", Float) = 0.1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 1609
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
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp float _MainOffsetMaskOffset;
uniform sampler2D _OffsetTex;
uniform highp vec2 _OffsetTexSpeed;
uniform highp vec2 _OffsetTexTilling;
uniform highp float _OffsetTexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _MainOffsetMaskSpeed) + (_glesMultiTexCoord1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_MainOffsetMaskTex, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_Time.y * _OffsetTexSpeed) + (_glesMultiTexCoord1.xy * _OffsetTexTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_OffsetTex, tmpvar_5.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4.x * 
    (_MainOffsetMaskOffset * vec3(0.0, 1.0, 0.0))
  ) * (tmpvar_6.x * 
    (vec3(0.0, 1.0, 0.0) * _OffsetTexOffset)
  )));
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp vec4 _MainTexColor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexIntensity;
uniform highp float _MainTexIntensityAddColor;
uniform highp float _ScreenClipUp;
uniform highp float _ScreenClipWidth;
uniform highp float _ScreenClipDown;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode10_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _MainOffsetMaskSpeed) + (xlv_TEXCOORD1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainOffsetMaskTex, tmpvar_5);
  tex2DNode10_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  highp float edge0_8;
  edge0_8 = (_ScreenClipUp + _ScreenClipWidth);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_7.y - edge0_8) / (_ScreenClipUp - edge0_8)), 0.0, 1.0);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((tmpvar_7.y - _ScreenClipDown) / (
    (_ScreenClipDown + _ScreenClipWidth)
   - _ScreenClipDown)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )) * (tmpvar_10 * (tmpvar_10 * 
    (3.0 - (2.0 * tmpvar_10))
  )));
  aseOutAlpha_2 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_4);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((_MainTexColor * tmpvar_12) * _MainTexIntensity) * (tex2DNode10_3.x + _MainTexIntensityAddColor)).xyz;
  aseOutColor_1 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = aseOutColor_1;
  tmpvar_14.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp float _MainOffsetMaskOffset;
uniform sampler2D _OffsetTex;
uniform highp vec2 _OffsetTexSpeed;
uniform highp vec2 _OffsetTexTilling;
uniform highp float _OffsetTexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _MainOffsetMaskSpeed) + (_glesMultiTexCoord1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_MainOffsetMaskTex, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_Time.y * _OffsetTexSpeed) + (_glesMultiTexCoord1.xy * _OffsetTexTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_OffsetTex, tmpvar_5.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4.x * 
    (_MainOffsetMaskOffset * vec3(0.0, 1.0, 0.0))
  ) * (tmpvar_6.x * 
    (vec3(0.0, 1.0, 0.0) * _OffsetTexOffset)
  )));
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp vec4 _MainTexColor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexIntensity;
uniform highp float _MainTexIntensityAddColor;
uniform highp float _ScreenClipUp;
uniform highp float _ScreenClipWidth;
uniform highp float _ScreenClipDown;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode10_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _MainOffsetMaskSpeed) + (xlv_TEXCOORD1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainOffsetMaskTex, tmpvar_5);
  tex2DNode10_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  highp float edge0_8;
  edge0_8 = (_ScreenClipUp + _ScreenClipWidth);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_7.y - edge0_8) / (_ScreenClipUp - edge0_8)), 0.0, 1.0);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((tmpvar_7.y - _ScreenClipDown) / (
    (_ScreenClipDown + _ScreenClipWidth)
   - _ScreenClipDown)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )) * (tmpvar_10 * (tmpvar_10 * 
    (3.0 - (2.0 * tmpvar_10))
  )));
  aseOutAlpha_2 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_4);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((_MainTexColor * tmpvar_12) * _MainTexIntensity) * (tex2DNode10_3.x + _MainTexIntensityAddColor)).xyz;
  aseOutColor_1 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = aseOutColor_1;
  tmpvar_14.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_14;
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
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp float _MainOffsetMaskOffset;
uniform sampler2D _OffsetTex;
uniform highp vec2 _OffsetTexSpeed;
uniform highp vec2 _OffsetTexTilling;
uniform highp float _OffsetTexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  tmpvar_2.zw = vec2(0.0, 0.0);
  tmpvar_2.xy = ((_Time.y * _MainOffsetMaskSpeed) + (_glesMultiTexCoord1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DLod (_MainOffsetMaskTex, tmpvar_2.xy, 0.0);
  highp vec4 tmpvar_4;
  tmpvar_4 = tmpvar_3;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = ((_Time.y * _OffsetTexSpeed) + (_glesMultiTexCoord1.xy * _OffsetTexTilling));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DLod (_OffsetTex, tmpvar_5.xy, 0.0);
  tmpvar_1.xyz = (_glesVertex.xyz + ((tmpvar_4.x * 
    (_MainOffsetMaskOffset * vec3(0.0, 1.0, 0.0))
  ) * (tmpvar_6.x * 
    (vec3(0.0, 1.0, 0.0) * _OffsetTexOffset)
  )));
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  gl_Position = tmpvar_7;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
  xlv_TEXCOORD2 = _glesMultiTexCoord2;
  xlv_TEXCOORD3 = o_9;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainOffsetMaskTex;
uniform highp vec2 _MainOffsetMaskSpeed;
uniform highp vec2 _MainOffsetMaskTilline;
uniform highp vec4 _MainTexColor;
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_ST;
uniform highp float _MainTexIntensity;
uniform highp float _MainTexIntensityAddColor;
uniform highp float _ScreenClipUp;
uniform highp float _ScreenClipWidth;
uniform highp float _ScreenClipDown;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode10_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((xlv_TEXCOORD0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_Time.y * _MainOffsetMaskSpeed) + (xlv_TEXCOORD1.xy * _MainOffsetMaskTilline));
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainOffsetMaskTex, tmpvar_5);
  tex2DNode10_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  highp float edge0_8;
  edge0_8 = (_ScreenClipUp + _ScreenClipWidth);
  highp float tmpvar_9;
  tmpvar_9 = clamp (((tmpvar_7.y - edge0_8) / (_ScreenClipUp - edge0_8)), 0.0, 1.0);
  highp float tmpvar_10;
  tmpvar_10 = clamp (((tmpvar_7.y - _ScreenClipDown) / (
    (_ScreenClipDown + _ScreenClipWidth)
   - _ScreenClipDown)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * (tmpvar_9 * 
    (3.0 - (2.0 * tmpvar_9))
  )) * (tmpvar_10 * (tmpvar_10 * 
    (3.0 - (2.0 * tmpvar_10))
  )));
  aseOutAlpha_2 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_4);
  highp vec3 tmpvar_13;
  tmpvar_13 = (((_MainTexColor * tmpvar_12) * _MainTexIntensity) * (tex2DNode10_3.x + _MainTexIntensityAddColor)).xyz;
  aseOutColor_1 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = aseOutColor_1;
  tmpvar_14.w = aseOutAlpha_2;
  gl_FragData[0] = tmpvar_14;
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