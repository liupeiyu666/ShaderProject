//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Ripple" {
Properties {
_MainTex ("Main", 2D) = "white" { }
_RainIntensity ("Rain Intensity", Range(0, 1)) = 1
_RainTime ("Rain Time", Vector) = (0,0,0,0)
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 11055
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _RainIntensity;
uniform highp vec4 _RainTime;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = (vec2(_RainIntensity) - vec2(0.0, 0.25));
  highp vec2 uv_2;
  uv_2 = (xlv_TEXCOORD0 + vec2(0.25, 0.0));
  highp vec4 ripple_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  ripple_3 = tmpvar_4;
  ripple_3.yz = ((ripple_3.yz * 2.0) - 1.0);
  highp float tmpvar_5;
  tmpvar_5 = fract((ripple_3.w + _RainTime.x));
  highp vec3 tmpvar_6;
  tmpvar_6.z = 1.0;
  tmpvar_6.xy = ((ripple_3.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.x * 0.8)
    ) - tmpvar_5), 0.0, 1.0) * ripple_3.x)
   * 
    sin((clamp ((
      ((tmpvar_5 - 1.0) + ripple_3.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec2 uv_7;
  uv_7 = (xlv_TEXCOORD0 + vec2(-0.55, 0.3));
  highp vec4 ripple_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv_7);
  ripple_8 = tmpvar_9;
  ripple_8.yz = ((ripple_8.yz * 2.0) - 1.0);
  highp float tmpvar_10;
  tmpvar_10 = fract((ripple_8.w + _RainTime.y));
  highp vec3 tmpvar_11;
  tmpvar_11.z = 1.0;
  tmpvar_11.xy = ((ripple_8.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.y * 0.8)
    ) - tmpvar_10), 0.0, 1.0) * ripple_8.x)
   * 
    sin((clamp ((
      ((tmpvar_10 - 1.0) + ripple_8.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec3 tmpvar_12;
  tmpvar_12.xy = ((tmpvar_1.x * tmpvar_6.xy) + (tmpvar_1.y * tmpvar_11.xy));
  tmpvar_12.z = 1.0;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((normalize(tmpvar_12) * 0.5) + 0.5);
  gl_FragData[0] = tmpvar_13;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _RainIntensity;
uniform highp vec4 _RainTime;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = (vec2(_RainIntensity) - vec2(0.0, 0.25));
  highp vec2 uv_2;
  uv_2 = (xlv_TEXCOORD0 + vec2(0.25, 0.0));
  highp vec4 ripple_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  ripple_3 = tmpvar_4;
  ripple_3.yz = ((ripple_3.yz * 2.0) - 1.0);
  highp float tmpvar_5;
  tmpvar_5 = fract((ripple_3.w + _RainTime.x));
  highp vec3 tmpvar_6;
  tmpvar_6.z = 1.0;
  tmpvar_6.xy = ((ripple_3.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.x * 0.8)
    ) - tmpvar_5), 0.0, 1.0) * ripple_3.x)
   * 
    sin((clamp ((
      ((tmpvar_5 - 1.0) + ripple_3.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec2 uv_7;
  uv_7 = (xlv_TEXCOORD0 + vec2(-0.55, 0.3));
  highp vec4 ripple_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv_7);
  ripple_8 = tmpvar_9;
  ripple_8.yz = ((ripple_8.yz * 2.0) - 1.0);
  highp float tmpvar_10;
  tmpvar_10 = fract((ripple_8.w + _RainTime.y));
  highp vec3 tmpvar_11;
  tmpvar_11.z = 1.0;
  tmpvar_11.xy = ((ripple_8.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.y * 0.8)
    ) - tmpvar_10), 0.0, 1.0) * ripple_8.x)
   * 
    sin((clamp ((
      ((tmpvar_10 - 1.0) + ripple_8.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec3 tmpvar_12;
  tmpvar_12.xy = ((tmpvar_1.x * tmpvar_6.xy) + (tmpvar_1.y * tmpvar_11.xy));
  tmpvar_12.z = 1.0;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((normalize(tmpvar_12) * 0.5) + 0.5);
  gl_FragData[0] = tmpvar_13;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp float _RainIntensity;
uniform highp vec4 _RainTime;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = (vec2(_RainIntensity) - vec2(0.0, 0.25));
  highp vec2 uv_2;
  uv_2 = (xlv_TEXCOORD0 + vec2(0.25, 0.0));
  highp vec4 ripple_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, uv_2);
  ripple_3 = tmpvar_4;
  ripple_3.yz = ((ripple_3.yz * 2.0) - 1.0);
  highp float tmpvar_5;
  tmpvar_5 = fract((ripple_3.w + _RainTime.x));
  highp vec3 tmpvar_6;
  tmpvar_6.z = 1.0;
  tmpvar_6.xy = ((ripple_3.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.x * 0.8)
    ) - tmpvar_5), 0.0, 1.0) * ripple_3.x)
   * 
    sin((clamp ((
      ((tmpvar_5 - 1.0) + ripple_3.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec2 uv_7;
  uv_7 = (xlv_TEXCOORD0 + vec2(-0.55, 0.3));
  highp vec4 ripple_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_MainTex, uv_7);
  ripple_8 = tmpvar_9;
  ripple_8.yz = ((ripple_8.yz * 2.0) - 1.0);
  highp float tmpvar_10;
  tmpvar_10 = fract((ripple_8.w + _RainTime.y));
  highp vec3 tmpvar_11;
  tmpvar_11.z = 1.0;
  tmpvar_11.xy = ((ripple_8.yz * (
    (clamp (((0.2 + 
      (tmpvar_1.y * 0.8)
    ) - tmpvar_10), 0.0, 1.0) * ripple_8.x)
   * 
    sin((clamp ((
      ((tmpvar_10 - 1.0) + ripple_8.x)
     * 9.0), 0.0, 3.0) * 3.141593))
  )) * 0.35);
  highp vec3 tmpvar_12;
  tmpvar_12.xy = ((tmpvar_1.x * tmpvar_6.xy) + (tmpvar_1.y * tmpvar_11.xy));
  tmpvar_12.z = 1.0;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = ((normalize(tmpvar_12) * 0.5) + 0.5);
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
}