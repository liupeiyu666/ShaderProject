//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/DLCSmokeV1" {
Properties {
_MainSmokeTexture ("MainSmokeTexture", 2D) = "white" { }
_SmokeBrightness ("SmokeBrightness", Float) = 1
_DisTexture ("DisTexture", 2D) = "white" { }
_DisUvR ("DisUv (R)", Vector) = (0,0,1,1)
[Toggle(_DISTEXG_SWITCH_ON)] _DisTexG_Switch ("DisTex(G)_Switch", Float) = 0
_DisUvG ("DisUv(G)", Vector) = (0,0,1,1)
_Smoothstep ("Smoothstep", Range(0.5, 1)) = 0.5
_SmoothstepA ("Smoothstep(A)", Range(-1, 1)) = 0
[Toggle(_RIM_SWITCH_ON)] _Rim_Switch ("Rim_Switch", Float) = 0
_Rim ("Rim", Range(-1, 1)) = 0
_RimColor ("RimColor", Color) = (1,1,1,0)
[Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Render Options)] [Enum(Off, 4, On, 0)] _AlwaysOnTop ("Always On Top", Float) = 4
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 4947
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = texture2D (_DisTexture, xlv_TEXCOORD0.zw).x;
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = tmpvar_11.xyz;
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = clamp (((
    ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = (_SmokeBrightness * mix ((tex2DNode10_2.z * xlv_TEXCOORD2), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_10 * 
    (tmpvar_10 * (3.0 - (2.0 * tmpvar_10)))
  ))));
  mediump vec4 tmpvar_12;
  tmpvar_12.xyz = mix (tmpvar_11.xyz, vec3(dot (tmpvar_11.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_12.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_12;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = tmpvar_13.xyz;
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
  gl_FragData[0] = tmpvar_14;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _Time;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainSmokeTexture_ST;
uniform highp vec4 _DisTexture_ST;
uniform highp vec2 _DisUvR;
uniform highp vec4 _DisUvG;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _glesVertex.xyz;
  highp vec2 tmpvar_4;
  tmpvar_4 = (_glesMultiTexCoord0.xy * _DisTexture_ST.xy);
  tmpvar_1.zw = ((tmpvar_4 + _DisTexture_ST.zw) + fract((_DisUvR * _Time.y)));
  tmpvar_1.xy = (((tmpvar_4 + _DisTexture_ST.zw) * _DisUvG.zw) + fract((_DisUvG.xy * _Time.y)));
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _MainSmokeTexture_ST.xy) + _MainSmokeTexture_ST.zw);
  tmpvar_2.xy = _glesMultiTexCoord1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = _glesMultiTexCoord2.xyz;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainSmokeTexture;
uniform mediump float _Smoothstep;
uniform mediump float _SmoothstepA;
uniform sampler2D _DisTexture;
uniform mediump float _SmokeBrightness;
uniform mediump vec3 _RimColor;
uniform mediump float _Rim;
uniform mediump float _LumiFactor;
varying mediump vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump float staticSwitch249_1;
  mediump vec4 tex2DNode10_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainSmokeTexture, xlv_TEXCOORD1.zw);
  tex2DNode10_2 = tmpvar_3;
  lowp float tmpvar_4;
  tmpvar_4 = (texture2D (_DisTexture, xlv_TEXCOORD0.zw).x + texture2D (_DisTexture, xlv_TEXCOORD0.xy).y);
  staticSwitch249_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_DisTexture, xlv_TEXCOORD1.zw);
  mediump float tmpvar_6;
  tmpvar_6 = (tmpvar_5.z * staticSwitch249_1);
  mediump float edge0_7;
  mediump float tmpvar_8;
  tmpvar_8 = (1.0 - _Smoothstep);
  edge0_7 = (tmpvar_8 - _SmoothstepA);
  mediump float tmpvar_9;
  tmpvar_9 = clamp (((
    (xlv_TEXCOORD1.x + tmpvar_6)
   - edge0_7) / (
    (_Smoothstep + _SmoothstepA)
   - edge0_7)), 0.0, 1.0);
  mediump float tmpvar_10;
  tmpvar_10 = ((xlv_TEXCOORD1.x + tmpvar_6) + xlv_TEXCOORD1.y);
  mediump float tmpvar_11;
  tmpvar_11 = clamp (((
    (tmpvar_10 + _Rim)
   - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump float tmpvar_12;
  tmpvar_12 = clamp (((tmpvar_10 - tmpvar_8) / (_Smoothstep - tmpvar_8)), 0.0, 1.0);
  mediump vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = (_SmokeBrightness * mix (mix (
    (tex2DNode10_2.z * xlv_TEXCOORD2)
  , 
    (tex2DNode10_2.y * _RimColor)
  , vec3(
    (tmpvar_11 * (tmpvar_11 * (3.0 - (2.0 * tmpvar_11))))
  )), (tex2DNode10_2.x * xlv_COLOR.xyz), vec3((tmpvar_12 * 
    (tmpvar_12 * (3.0 - (2.0 * tmpvar_12)))
  ))));
  mediump vec4 tmpvar_14;
  tmpvar_14.xyz = mix (tmpvar_13.xyz, vec3(dot (tmpvar_13.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  tmpvar_14.w = clamp (clamp ((
    (xlv_COLOR.w * tex2DNode10_2.w)
   * 
    (tmpvar_9 * (tmpvar_9 * (3.0 - (2.0 * tmpvar_9))))
  ), 0.0, 1.0), 0.0, 1.0);
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
SubProgram "gles hw_tier00 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "_DISTEXG_SWITCH_ON" "_RIM_SWITCH_ON" }
""
}
}
}
}
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}