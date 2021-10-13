//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Special/Fire" {
Properties {
_ColorInside ("ColorInside", Color) = (0.5,0.5,0.5,0.5)
_ColorOutside ("ColorOutside", Color) = (0.5,0.5,0.5,0.5)
_FireNoise ("Fire Noise", 2D) = "white" { }
_SpeedU ("Speed U", Float) = 0
_SpeedV ("Speed V", Float) = -1
_ShapeMask ("Shape Mask", 2D) = "white" { }
_ShapeBrightness ("Shape Brightness", Float) = 1
_OpacityIntensity ("Opacity Intensity", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
[Toggle(TEXTURE_SCALE)] _TextureScale ("Texture Scale", Float) = 0
_TSAspectRatio ("Texture Aspect Ratio (width : height)", Float) = 1
[Toggle(DISTORTION)] _Distortion ("Distortion", Float) = 0
_DistortionTex ("Distortion Tex", 2D) = "gray" { }
_DistortionIntensity ("Distortion Intensity", Range(0, 10)) = 5
[Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Toggle(WRITEDEPTH)] _WriteDepth ("WriteDepth", Float) = 0
}
SubShader {
 Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 55634
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
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
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp vec4 _Time;
uniform highp float _EmissionScaler;
uniform highp float _SpeedU;
uniform highp float _SpeedV;
uniform sampler2D _FireNoise;
uniform highp vec4 _FireNoise_ST;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
uniform highp float _ShapeBrightness;
uniform highp vec4 _ColorInside;
uniform highp vec4 _ColorOutside;
uniform highp float _OpacityIntensity;
uniform mediump float _LumiFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  highp vec4 shape_2;
  mediump vec4 noise_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = _SpeedU;
  tmpvar_4.y = _SpeedV;
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0 + 
    (tmpvar_4 * _Time.y)
  ) * _FireNoise_ST.xy) + _FireNoise_ST.zw);
  tmpvar_5 = texture2D (_FireNoise, P_6);
  noise_3 = tmpvar_5;
  lowp vec4 tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_7 = texture2D (_ShapeMask, P_8);
  highp float tmpvar_9;
  tmpvar_9 = (xlv_TEXCOORD0.y - ((tmpvar_7.z * _ShapeBrightness) * noise_3.x));
  highp vec2 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD0.x;
  tmpvar_10.y = tmpvar_9;
  lowp vec4 tmpvar_11;
  highp vec2 P_12;
  P_12 = ((tmpvar_10 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_11 = texture2D (_ShapeMask, P_12);
  shape_2 = tmpvar_11;
  highp vec4 tmpvar_13;
  tmpvar_13 = mix (_ColorInside, _ColorOutside, vec4(clamp ((shape_2.x + 
    (shape_2.w * shape_2.w)
  ), 0.0, 1.0)));
  color_1.xyz = tmpvar_13.xyz;
  color_1.w = ((tmpvar_9 * _OpacityIntensity) * shape_2.y);
  color_1.xyz = (color_1.xyz * _EmissionScaler);
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  color_1.xyz = mix (color_1.xyz, vec3(dot (color_1.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = color_1;
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "Distortion" = "None" "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 77756
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp float _BloomFactor;
uniform highp float _ShapeBrightness;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  highp vec2 P_3;
  P_3 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_2 = texture2D (_ShapeMask, P_3);
  highp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.z * _ShapeBrightness);
  highp float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.w = (tmpvar_4 * _BloomFactor);
  gl_FragData[0] = color_1;
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
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp float _BloomFactor;
uniform highp float _ShapeBrightness;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  highp vec2 P_3;
  P_3 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_2 = texture2D (_ShapeMask, P_3);
  highp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.z * _ShapeBrightness);
  highp float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.w = (tmpvar_4 * _BloomFactor);
  gl_FragData[0] = color_1;
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
varying highp vec2 xlv_TEXCOORD0;
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
uniform highp float _BloomFactor;
uniform highp float _ShapeBrightness;
uniform sampler2D _ShapeMask;
uniform highp vec4 _ShapeMask_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  highp vec2 P_3;
  P_3 = ((xlv_TEXCOORD0 * _ShapeMask_ST.xy) + _ShapeMask_ST.zw);
  tmpvar_2 = texture2D (_ShapeMask, P_3);
  highp float tmpvar_4;
  tmpvar_4 = (tmpvar_2.z * _ShapeBrightness);
  highp float x_5;
  x_5 = (tmpvar_4 - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  color_1.w = (tmpvar_4 * _BloomFactor);
  gl_FragData[0] = color_1;
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