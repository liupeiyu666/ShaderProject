//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_Common/Sky Box Mountain" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Base (RGB) Trans (A)", 2D) = "white" { }
_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
  GpuProgramID 56052
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
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
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = col_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _FogColorNear;
uniform highp vec4 _FogColorFar;
uniform highp float _FogColorIntensity;
uniform highp float _FogIntensity;
uniform highp float _FogEffectStart;
uniform highp float _SkyBoxFogEffectLimit;
uniform highp float _FogStartDistance;
uniform mediump vec4 _Color;
uniform highp vec4 _MainTex_ST;
uniform mediump vec4 _SkyBoxMountainColor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  tmpvar_1 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  mediump vec4 fogColor_3;
  highp vec3 tmpvar_4;
  tmpvar_4 = ((unity_ObjectToWorld * _glesVertex).xyz - _WorldSpaceCameraPos);
  highp float tmpvar_5;
  tmpvar_5 = max (0.0, (sqrt(
    dot (tmpvar_4, tmpvar_4)
  ) - _FogStartDistance));
  highp float tmpvar_6;
  tmpvar_6 = min (max ((
    (1.0 - exp((-(
      (_FogIntensity * tmpvar_5)
    ) * (_FogIntensity * tmpvar_5))))
   * _SkyBoxFogEffectLimit), _FogEffectStart), _SkyBoxFogEffectLimit);
  highp vec3 tmpvar_7;
  tmpvar_7 = mix (_FogColorFar.xyz, _FogColorNear.xyz, vec3(clamp (exp(
    (-((_FogColorIntensity * tmpvar_5)) * (_FogColorIntensity * tmpvar_5))
  ), 0.0, 1.0)));
  fogColor_3.xyz = tmpvar_7;
  fogColor_3.w = tmpvar_6;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = (_glesColor.xyz * (_SkyBoxMountainColor * _Color).xyz);
  xlv_COLOR1 = fogColor_3;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Cutoff;
uniform mediump float _LumiFactor;
uniform mediump float _SkyBoxBloomFactor;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_COLOR0;
varying mediump vec4 xlv_COLOR1;
void main ()
{
  mediump vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  mediump float x_3;
  x_3 = (col_1.w - _Cutoff);
  if ((x_3 < 0.0)) {
    discard;
  };
  col_1.xyz = (col_1.xyz * xlv_COLOR0);
  col_1.xyz = mix (col_1.xyz, xlv_COLOR1.xyz, xlv_COLOR1.www);
  col_1.w = _SkyBoxBloomFactor;
  col_1.xyz = mix (col_1.xyz, vec3(dot (col_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
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
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" "FOG_HEIGHT" "FOG_LERP" }
""
}
}
}
}
}