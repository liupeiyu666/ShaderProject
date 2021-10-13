//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo/DLC/Common/Meta" {
Properties {
_EmissionMask ("Emission Mask", 2D) = "black" { }
[Enum(UV1st,0,UV2nd,1)] _UseSet ("UV Set", Float) = 1
_Emission ("Emission Color", Color) = (0,0,0,0.5)
_EmissionGIIntensity ("Emission GI Intensity", Range(0, 10)) = 2
}
SubShader {
 Tags { "PerformanceChecks" = "False" "RenderType" = "Opaque" }
 Pass {
  Name "META"
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 22320
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec4 c_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).x;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (c_3.xyz * _Color.xyz);
  tmpvar_5 = ((_Emission.xyz * _Emission.w) * (emissionMask_2 * _EmissionGIIntensity));
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec4 c_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).x;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (c_3.xyz * _Color.xyz);
  tmpvar_5 = ((_Emission.xyz * _Emission.w) * (emissionMask_2 * _EmissionGIIntensity));
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump float emissionMask_2;
  mediump vec4 c_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  c_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp float tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).x;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (c_3.xyz * _Color.xyz);
  tmpvar_5 = ((_Emission.xyz * _Emission.w) * (emissionMask_2 * _EmissionGIIntensity));
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
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
 Pass {
  Name "META_ADD"
  Tags { "LIGHTMODE" = "META" "PerformanceChecks" = "False" "RenderType" = "Opaque" }
  Cull Off
  GpuProgramID 130115
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 emissionMask_2;
  mediump vec4 texColor_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).xyz;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (texColor_3.xyz * _Color.xyz);
  tmpvar_5 = (((
    (texColor_3.xyz + emissionMask_2)
   * _Emission.xyz) * _Emission.w) * _EmissionGIIntensity);
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 emissionMask_2;
  mediump vec4 texColor_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).xyz;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (texColor_3.xyz * _Color.xyz);
  tmpvar_5 = (((
    (texColor_3.xyz + emissionMask_2)
   * _Emission.xyz) * _Emission.w) * _EmissionGIIntensity);
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord1.xy;
  highp vec4 tmpvar_3;
  tmpvar_3 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec4 vertex_4;
  vertex_4 = _glesVertex;
  if (unity_MetaVertexControl.x) {
    vertex_4.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_5;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_5 = 0.0001;
    } else {
      tmpvar_5 = 0.0;
    };
    vertex_4.z = tmpvar_5;
  };
  if (unity_MetaVertexControl.y) {
    vertex_4.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_6;
    if ((vertex_4.z > 0.0)) {
      tmpvar_6 = 0.0001;
    } else {
      tmpvar_6 = 0.0;
    };
    vertex_4.z = tmpvar_6;
  };
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = vertex_4.xyz;
  tmpvar_3.xy = tmpvar_1;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _Color;
uniform sampler2D _MainTex;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
uniform mediump vec4 _Emission;
uniform sampler2D _EmissionMask;
uniform highp float _EmissionGIIntensity;
uniform highp int _UseSet;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  mediump vec3 emissionMask_2;
  mediump vec4 texColor_3;
  mediump vec3 tmpvar_4;
  mediump vec3 tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  texColor_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.zw = vec2(0.0, 0.0);
  tmpvar_7.xy = xlv_TEXCOORD1;
  highp vec4 tmpvar_8;
  tmpvar_8 = mix (xlv_TEXCOORD0, tmpvar_7, vec4(float(_UseSet)));
  lowp vec3 tmpvar_9;
  tmpvar_9 = texture2D (_EmissionMask, tmpvar_8.xy).xyz;
  emissionMask_2 = tmpvar_9;
  tmpvar_4 = (texColor_3.xyz * _Color.xyz);
  tmpvar_5 = (((
    (texColor_3.xyz + emissionMask_2)
   * _Emission.xyz) * _Emission.w) * _EmissionGIIntensity);
  mediump vec4 res_10;
  res_10 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_11;
    tmpvar_11.w = 1.0;
    tmpvar_11.xyz = tmpvar_4;
    res_10.w = tmpvar_11.w;
    highp vec3 tmpvar_12;
    tmpvar_12 = clamp (pow (tmpvar_4, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_10.xyz = tmpvar_12;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_13;
    if (bool(unity_UseLinearSpace)) {
      emission_13 = tmpvar_5;
    } else {
      emission_13 = (tmpvar_5 * ((tmpvar_5 * 
        ((tmpvar_5 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_14;
    tmpvar_14.w = 1.0;
    tmpvar_14.xyz = emission_13;
    res_10 = tmpvar_14;
  };
  tmpvar_1 = res_10;
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