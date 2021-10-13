//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Old/Video_Hologram" {
Properties {
_Brightness ("Brightness", Range(0.1, 10)) = 3
_ScanBright ("Scan Bright", Range(0, 1)) = 0.1
_GlowBright ("Glow Bright", Range(0, 1)) = 0.1
_MainTex ("MainTexture", 2D) = "white" { }
_MainColor ("MainColor", Color) = (1,1,1,1)
_RimColor ("Rim Color", Color) = (1,1,1,1)
_RimPower ("Rim Power", Range(0.1, 10)) = 5
_ScanTiling ("Scan Tiling", Range(0.01, 1000)) = 0.05
_ScanSpeed ("Scan Speed", Range(-2, 2)) = 1
_GlowTiling ("Glow Tiling", Range(0.01, 1)) = 0.05
_GlowSpeed ("Glow Speed", Range(-10, 10)) = 1
_GlitchSpeed ("Glitch Speed", Range(0, 50)) = 1
_GlitchIntensity ("Glitch Intensity", Float) = 0
_FlickerTex ("Flicker Control Texture", 2D) = "white" { }
_FlickerSpeed ("Flicker Speed", Range(0, 100)) = 0
_Color ("Main Color", Color) = (1,1,1,1)
_VertexAlphaFactor ("Alpha From Vertex Factor (0: not use)", Range(0, 1)) = 0
_BloomFactor ("Bloom Factor", Float) = 1
_Opaqueness ("Opaqueness", Range(0, 1)) = 1
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "None" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 49259
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
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
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  col_1.w = clamp (col_1.w, 0.0, 1.0);
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform highp float _GlitchSpeed;
uniform highp float _GlitchIntensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.yzw = _glesVertex.yzw;
  highp vec4 tmpvar_2;
  tmpvar_1.x = (_glesVertex.x + (_GlitchIntensity * (
    float((sin((
      (_Time.y * 2.0)
     + _glesVertex.y)) >= 0.5))
   * 
    float((sin((
      (_Time.y * _GlitchSpeed)
     * 0.5)) >= 0.99))
  )));
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_ObjectToWorld * tmpvar_1);
  highp mat3 tmpvar_4;
  tmpvar_4[0] = unity_WorldToObject[0].xyz;
  tmpvar_4[1] = unity_WorldToObject[1].xyz;
  tmpvar_4[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = normalize((_WorldSpaceCameraPos - tmpvar_2.xyz));
  xlv_NORMAL = normalize((_glesNormal * tmpvar_4));
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
uniform highp float _ScanBright;
uniform highp float _GlowBright;
uniform highp float _ScanTiling;
uniform highp float _ScanSpeed;
uniform highp float _GlowTiling;
uniform highp float _GlowSpeed;
uniform highp float _FlickerSpeed;
uniform highp float _BloomFactor;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_NORMAL;
void main ()
{
  mediump vec4 col_1;
  mediump vec4 rimColor_2;
  mediump vec4 flicker_3;
  mediump vec4 texColor_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_4 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = (_Time * _FlickerSpeed).xy;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_FlickerTex, tmpvar_6);
  flicker_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = clamp (dot (xlv_TEXCOORD2, xlv_NORMAL), 0.0, 1.0);
  mediump float tmpvar_9;
  tmpvar_9 = (1.0 - tmpvar_8);
  highp vec4 tmpvar_10;
  tmpvar_10 = (_RimColor * pow (tmpvar_9, _RimPower));
  rimColor_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11 = ((texColor_4 * _MainColor) + ((
    ((fract((
      (xlv_TEXCOORD1.y * _GlowTiling)
     - 
      (_Time.x * _GlowSpeed)
    )) * _GlowBright) + (float((0.5 >= 
      fract(((xlv_TEXCOORD1.y * _ScanTiling) + (_Time.w * _ScanSpeed)))
    )) * _ScanBright))
   * _MainColor) + rimColor_2));
  col_1.xyz = tmpvar_11.xyz;
  col_1.w = (_BloomFactor * flicker_3.x);
  col_1.xyz = (col_1.xyz * _Brightness);
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
""
}
}
}
}
}