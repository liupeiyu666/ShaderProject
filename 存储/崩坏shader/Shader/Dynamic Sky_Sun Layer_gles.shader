//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Sun Layer" {
Properties {
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 38624
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 clipPos_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  clipPos_2.xyw = tmpvar_3.xyw;
  clipPos_2.z = tmpvar_3.w;
  mediump vec3 viewDir_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(((unity_ObjectToWorld * tmpvar_6).xyz - _ES_SkyCenterWorldPos));
  viewDir_5 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = dot (_ES_SkyWorldUpDir, viewDir_5);
  mediump vec4 tmpvar_9;
  tmpvar_9.xyz = viewDir_5;
  tmpvar_9.w = ((sign(tmpvar_8) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_8))) * (1.570796 + (abs(tmpvar_8) * (-0.2146018 + 
      (abs(tmpvar_8) * (0.08656672 + (abs(tmpvar_8) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_2;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  xlv_TEXCOORD1 = tmpvar_9;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_SunColor;
uniform mediump float _ES_SunBrightness;
uniform mediump float _ES_SunSharpness;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float dist_1;
  highp float tmpvar_2;
  tmpvar_2 = sqrt(dot (xlv_TEXCOORD0, xlv_TEXCOORD0));
  dist_1 = tmpvar_2;
  mediump float tmpvar_3;
  tmpvar_3 = clamp (((1.0 - dist_1) / (1.0 - _ES_SunSharpness)), 0.0, 1.0);
  mediump vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = (((tmpvar_3 * 
    (tmpvar_3 * (3.0 - (2.0 * tmpvar_3)))
  ) * _ES_SunColor) * _ES_SunBrightness);
  gl_FragData[0] = tmpvar_4;
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
}
}
}
}