//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/FlipBook_New" {
Properties {
_MainTex ("MainTex", 2D) = "white" { }
[Enum(G,0,A,1)] _MainTexAlphaChannelToggle ("MainTexAlphaChannelToggle", Float) = 0
[Enum(Off, 0, On, 1)] _ZWrite ("ZWrite", Float) = 0
_MainColor ("MainColor", Color) = (0,0.8734226,1,0)
_mainUV ("mainUV", Vector) = (1,4,0,0)
_TimeCt ("TimeCt", Float) = 7.69
_Rotate ("Rotate", Float) = 1.57
_LightIntensity ("LightIntensity", Float) = 1
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 15535
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD1 = _glesMultiTexCoord1;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _MainTex;
uniform highp vec2 _mainUV;
uniform highp float _TimeCt;
uniform highp float _Rotate;
uniform highp vec4 _MainColor;
uniform highp float _LightIntensity;
uniform mediump float _LumiFactor;
uniform mediump float _MainTexAlphaChannelToggle;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 aseOutColor_1;
  mediump float aseOutAlpha_2;
  highp vec4 tex2DNode2_3;
  highp float tmpvar_4;
  tmpvar_4 = _mainUV.y;
  highp vec2 tmpvar_5;
  tmpvar_5.x = _mainUV.x;
  tmpvar_5.y = tmpvar_4;
  highp float tmpvar_6;
  tmpvar_6 = (_mainUV.x * _mainUV.y);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6;
  tmpvar_7.y = tmpvar_4;
  highp float tmpvar_8;
  tmpvar_8 = fract(((
    ((_Time.y * _TimeCt) + (xlv_TEXCOORD1.z * 5.0))
   + 
    clamp (4.0, 0.0001, (tmpvar_6 - 1.0))
  ) / tmpvar_6));
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8;
  tmpvar_9.y = (1.0 - tmpvar_8);
  highp float tmpvar_10;
  tmpvar_10 = cos(_Rotate);
  highp float tmpvar_11;
  tmpvar_11 = sin(_Rotate);
  highp mat2 tmpvar_12;
  tmpvar_12[0].x = tmpvar_10;
  tmpvar_12[0].y = tmpvar_11;
  tmpvar_12[1].x = -(tmpvar_11);
  tmpvar_12[1].y = tmpvar_10;
  highp vec2 tmpvar_13;
  tmpvar_13 = (((xlv_TEXCOORD0.xy / tmpvar_5) + (
    floor((tmpvar_7 * tmpvar_9))
   / tmpvar_5)) * tmpvar_12);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_13);
  tex2DNode2_3 = tmpvar_14;
  aseOutAlpha_2 = 0.0;
  if ((_MainTexAlphaChannelToggle == 0.0)) {
    aseOutAlpha_2 = (tex2DNode2_3.x * xlv_COLOR.w);
  } else {
    if ((_MainTexAlphaChannelToggle == 1.0)) {
      aseOutAlpha_2 = (tex2DNode2_3.w * xlv_COLOR.w);
    };
  };
  highp vec3 tmpvar_15;
  tmpvar_15 = ((_MainColor.xyz * tex2DNode2_3.xyz) * (_LightIntensity * xlv_COLOR.xyz));
  aseOutColor_1 = tmpvar_15;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump float tmpvar_16;
  tmpvar_16 = clamp (aseOutAlpha_2, 0.0, 1.0);
  aseOutAlpha_2 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.xyz = aseOutColor_1;
  tmpvar_17.w = tmpvar_16;
  gl_FragData[0] = tmpvar_17;
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
Fallback "Diffuse"
CustomEditor "MoleMole.ParticleShaderEditorBase"
}