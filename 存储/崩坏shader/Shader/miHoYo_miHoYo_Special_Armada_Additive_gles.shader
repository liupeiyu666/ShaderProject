//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Armada/Additive" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Main Texture", 2D) = "white" { }
_TransparentTex ("Transparent Texture", 2D) = "white" { }
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
[Toggle] _PerspectiveDeformation ("Perspective Deformation", Float) = 0
_Vanishpoint ("Vanishpoint Position (Local Space)", Vector) = (0,0,10000,0)
_InvariantPlaneZ ("Invariant Plane Z Position (Local Space)", Float) = 0
_ScaleInZ ("Scale In Z", Range(0.01, 2)) = 1
}
SubShader {
 Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 22639
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_4;
    highp vec3 tmpvar_5;
    tmpvar_5 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_4.z = tmpvar_5.z;
    posInPerp_4.xy = (tmpvar_5.xy * (tmpvar_5.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_2.xyz = (posInPerp_4 + _Vanishpoint);
    tmpvar_2.z = (((tmpvar_2.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_2.xyz;
  tmpvar_3 = tmpvar_1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * (_EmissionScaler * mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  color_2.w = clamp (color_2.w, 0.0, 1.0);
  gl_FragData[0] = color_2;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_4;
    highp vec3 tmpvar_5;
    tmpvar_5 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_4.z = tmpvar_5.z;
    posInPerp_4.xy = (tmpvar_5.xy * (tmpvar_5.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_2.xyz = (posInPerp_4 + _Vanishpoint);
    tmpvar_2.z = (((tmpvar_2.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_2.xyz;
  tmpvar_3 = tmpvar_1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * (_EmissionScaler * mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  color_2.w = clamp (color_2.w, 0.0, 1.0);
  gl_FragData[0] = color_2;
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
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesVertex;
  mediump vec2 tmpvar_3;
  tmpvar_3 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_4;
    highp vec3 tmpvar_5;
    tmpvar_5 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_4.z = tmpvar_5.z;
    posInPerp_4.xy = (tmpvar_5.xy * (tmpvar_5.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_2.xyz = (posInPerp_4 + _Vanishpoint);
    tmpvar_2.z = (((tmpvar_2.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_2.xyz;
  tmpvar_3 = tmpvar_1.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  xlv_TEXCOORD0 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform sampler2D _TransparentTex;
uniform mediump float _EmissionScaler;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 mainColor_1;
  mediump vec4 color_2;
  color_2.w = 0.0;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  mainColor_1 = tmpvar_3;
  color_2.xyz = ((2.0 * _TintColor).xyz * mainColor_1.xyz);
  color_2.xyz = (color_2.xyz * (_EmissionScaler * mainColor_1.w));
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_TransparentTex, xlv_TEXCOORD0);
  color_2.w = tmpvar_4.x;
  color_2.w = clamp (color_2.w, 0.0, 1.0);
  gl_FragData[0] = color_2;
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
  Name "CONSTANT_REPLACE_NOCUTOFF"
  Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 72217
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
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
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
uniform mediump float _PerspectiveDeformation;
uniform highp vec3 _Vanishpoint;
uniform highp float _InvariantPlaneZ;
uniform highp float _ScaleInZ;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec2 tmpvar_2;
  tmpvar_2 = vec2(0.0, 0.0);
  if (bool(_PerspectiveDeformation)) {
    highp vec3 posInPerp_3;
    highp vec3 tmpvar_4;
    tmpvar_4 = (_glesVertex.xyz - _Vanishpoint);
    posInPerp_3.z = tmpvar_4.z;
    posInPerp_3.xy = (tmpvar_4.xy * (tmpvar_4.z / (_InvariantPlaneZ - _Vanishpoint.z)));
    tmpvar_1.xyz = (posInPerp_3 + _Vanishpoint);
    tmpvar_1.z = (((tmpvar_1.z - _InvariantPlaneZ) * _ScaleInZ) + _InvariantPlaneZ);
  };
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = vec2(0.0, 0.0);
  xlv_TEXCOORD2 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump float _SPOpaqueness;
uniform highp float _SPTransitionBloomFactor;
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
highp float xlat_mutable_SPTransition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = vec3(0.0, 0.0, 0.0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.w = (_BloomFactor * tmpvar_2.w);
  mediump float intensity_3;
  mediump float outBloomFactor_4;
  outBloomFactor_4 = color_1.w;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_SPNoiseTex, xlv_TEXCOORD1);
  highp float tmpvar_6;
  tmpvar_6 = (((1.99 * tmpvar_5.x) * _SPNoiseScaler) - 1.0);
  intensity_3 = tmpvar_6;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if (((intensity_3 >= (1.5 * xlat_mutable_SPTransition)) && (intensity_3 < (1.7 * xlat_mutable_SPTransition)))) {
    highp float tmpvar_7;
    tmpvar_7 = mix (color_1.w, _SPTransitionBloomFactor, clamp ((10.0 * 
      (-(intensity_3) + (1.7 * xlat_mutable_SPTransition))
    ), 0.0, 1.0));
    outBloomFactor_4 = tmpvar_7;
  } else {
    if ((intensity_3 < (1.5 * xlat_mutable_SPTransition))) {
      outBloomFactor_4 = (outBloomFactor_4 * _SPOpaqueness);
    };
  };
  color_1.w = outBloomFactor_4;
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
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
""
}
}
}
}
Fallback "Diffuse"
}