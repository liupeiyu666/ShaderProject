//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Fire_Grass" {
Properties {
_NoiseTex ("NoiseTexture", 2D) = "white" { }
_ShapeTex ("ShapeTexture", 2D) = "white" { }
_FlowSpeed ("FlowSpeed", Range(0, 1)) = 1
_ColorOut ("ColorOutter", Color) = (1,1,1,1)
_ColorInner ("ColorInner", Color) = (1,1,1,1)
_ColorOutMultiplier ("ColorOutMultiplier", Range(0, 20)) = 10
_ColorInnerMultiplier ("ColorInnerMultiplier", Range(0, 20)) = 10
_NoiseTexBrightness ("NoiseTexBrightness", Range(0, 2)) = 1.22
_NoiseBrightnessAdd ("NoiseBrightnessAdd", Range(-1, 1)) = 0.22
_AlphaAdd ("AlphaAdd", Range(0, 10)) = 1.5
_SwapUV ("SwapUV", Range(-1, 1)) = 1
}
SubShader {
 LOD 100
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 30329
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _SwapUV;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  if ((_SwapUV > 0.0)) {
    tmpvar_5 = tmpvar_1.yxz;
  } else {
    tmpvar_5 = tmpvar_1;
  };
  xlv_TEXCOORD0 = tmpvar_5;
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _ShapeTex;
uniform highp float _FlowSpeed;
uniform lowp vec4 _ColorOut;
uniform lowp vec4 _ColorInner;
uniform highp float _ColorOutMultiplier;
uniform highp float _ColorInnerMultiplier;
uniform highp float _NoiseTexBrightness;
uniform highp float _NoiseBrightnessAdd;
uniform highp float _AlphaAdd;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 shape_2;
  highp float b_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = ((_FlowSpeed * _Time.y) + xlv_TEXCOORD0.z);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) - tmpvar_4);
  tmpvar_5 = texture2D (_NoiseTex, P_6);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_ShapeTex, xlv_TEXCOORD0.xy).z * 0.8);
  b_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (b_3 * ((tmpvar_5.x * _NoiseTexBrightness) + _NoiseBrightnessAdd));
  highp vec2 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.x;
  tmpvar_9.y = (1.0 - tmpvar_8);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTex, tmpvar_9).xyw;
  shape_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix ((_ColorInner * _ColorInnerMultiplier), (_ColorOut * _ColorOutMultiplier), vec4(clamp ((shape_2.x + 
    (shape_2.z * shape_2.z)
  ), 0.0, 1.0))).xyz;
  tmpvar_11.w = clamp (((tmpvar_8 + _AlphaAdd) * shape_2.y), 0.0, 1.0);
  tmpvar_1 = (tmpvar_11 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _SwapUV;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  if ((_SwapUV > 0.0)) {
    tmpvar_5 = tmpvar_1.yxz;
  } else {
    tmpvar_5 = tmpvar_1;
  };
  xlv_TEXCOORD0 = tmpvar_5;
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _ShapeTex;
uniform highp float _FlowSpeed;
uniform lowp vec4 _ColorOut;
uniform lowp vec4 _ColorInner;
uniform highp float _ColorOutMultiplier;
uniform highp float _ColorInnerMultiplier;
uniform highp float _NoiseTexBrightness;
uniform highp float _NoiseBrightnessAdd;
uniform highp float _AlphaAdd;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 shape_2;
  highp float b_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = ((_FlowSpeed * _Time.y) + xlv_TEXCOORD0.z);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) - tmpvar_4);
  tmpvar_5 = texture2D (_NoiseTex, P_6);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_ShapeTex, xlv_TEXCOORD0.xy).z * 0.8);
  b_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (b_3 * ((tmpvar_5.x * _NoiseTexBrightness) + _NoiseBrightnessAdd));
  highp vec2 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.x;
  tmpvar_9.y = (1.0 - tmpvar_8);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTex, tmpvar_9).xyw;
  shape_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix ((_ColorInner * _ColorInnerMultiplier), (_ColorOut * _ColorOutMultiplier), vec4(clamp ((shape_2.x + 
    (shape_2.z * shape_2.z)
  ), 0.0, 1.0))).xyz;
  tmpvar_11.w = clamp (((tmpvar_8 + _AlphaAdd) * shape_2.y), 0.0, 1.0);
  tmpvar_1 = (tmpvar_11 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp float _SwapUV;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec3 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesColor;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec3 tmpvar_5;
  if ((_SwapUV > 0.0)) {
    tmpvar_5 = tmpvar_1.yxz;
  } else {
    tmpvar_5 = tmpvar_1;
  };
  xlv_TEXCOORD0 = tmpvar_5;
  gl_Position = tmpvar_3;
  xlv_COLOR = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform sampler2D _NoiseTex;
uniform highp vec4 _NoiseTex_ST;
uniform sampler2D _ShapeTex;
uniform highp float _FlowSpeed;
uniform lowp vec4 _ColorOut;
uniform lowp vec4 _ColorInner;
uniform highp float _ColorOutMultiplier;
uniform highp float _ColorInnerMultiplier;
uniform highp float _NoiseTexBrightness;
uniform highp float _NoiseBrightnessAdd;
uniform highp float _AlphaAdd;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec3 shape_2;
  highp float b_3;
  highp vec2 tmpvar_4;
  tmpvar_4.x = 0.0;
  tmpvar_4.y = ((_FlowSpeed * _Time.y) + xlv_TEXCOORD0.z);
  lowp vec4 tmpvar_5;
  highp vec2 P_6;
  P_6 = (((xlv_TEXCOORD0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw) - tmpvar_4);
  tmpvar_5 = texture2D (_NoiseTex, P_6);
  lowp float tmpvar_7;
  tmpvar_7 = (texture2D (_ShapeTex, xlv_TEXCOORD0.xy).z * 0.8);
  b_3 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = (b_3 * ((tmpvar_5.x * _NoiseTexBrightness) + _NoiseBrightnessAdd));
  highp vec2 tmpvar_9;
  tmpvar_9.x = xlv_TEXCOORD0.x;
  tmpvar_9.y = (1.0 - tmpvar_8);
  lowp vec3 tmpvar_10;
  tmpvar_10 = texture2D (_ShapeTex, tmpvar_9).xyw;
  shape_2 = tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.xyz = mix ((_ColorInner * _ColorInnerMultiplier), (_ColorOut * _ColorOutMultiplier), vec4(clamp ((shape_2.x + 
    (shape_2.z * shape_2.z)
  ), 0.0, 1.0))).xyz;
  tmpvar_11.w = clamp (((tmpvar_8 + _AlphaAdd) * shape_2.y), 0.0, 1.0);
  tmpvar_1 = (tmpvar_11 * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
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