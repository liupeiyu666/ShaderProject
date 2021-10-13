//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Character/Character_Prop/Prop_Matcap_Outline" {
Properties {
_Color ("Color", Color) = (1,1,1,1)
_Scale ("Scale Compared to Maya", Float) = 0.01
_BloomFactor ("Bloom Factor", Float) = 1
_MainTex ("Base (RGB)", 2D) = "white" { }
_MatCap ("MatCap (RGB)", 2D) = "white" { }
_MetalRef ("MetalRef", Range(0, 1)) = 0
_OutlineWidth ("Outline Width", Range(0, 100)) = 0.2
_OutlineColor ("Outline Color", Color) = (0,0,0,1)
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
 Pass {
  LOD 200
  Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
  GpuProgramID 4887
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(_glesNormal);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_7 = _glesTANGENT.xyz;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_6.zxy) - (tmpvar_5.zxy * tmpvar_6.yzx)) * _glesTANGENT.w);
  tmpvar_9 = _glesNormal;
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_7.x;
  tmpvar_10[0].y = tmpvar_8.x;
  tmpvar_10[0].z = tmpvar_9.x;
  tmpvar_10[1].x = tmpvar_7.y;
  tmpvar_10[1].y = tmpvar_8.y;
  tmpvar_10[1].z = tmpvar_9.y;
  tmpvar_10[2].x = tmpvar_7.z;
  tmpvar_10[2].y = tmpvar_8.z;
  tmpvar_10[2].z = tmpvar_9.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((tmpvar_10 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_11)
  .xyz)));
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 fc_2;
  highp vec3 worldNorm_3;
  mediump vec4 tex_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixV[0].xyz;
  tmpvar_6[1] = unity_MatrixV[1].xyz;
  tmpvar_6[2] = unity_MatrixV[2].xyz;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * xlv_TEXCOORD1);
  worldNorm_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (worldNorm_3, normalize((xlv_TEXCOORD2 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD2) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_8.xy * 0.5) + 0.5);
  tmpvar_9 = texture2D (_MatCap, P_10);
  mediump vec4 tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * tex_4) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  fc_2.xyz = tmpvar_11.xyz;
  fc_2.w = _BloomFactor;
  tmpvar_1 = fc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(_glesNormal);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_7 = _glesTANGENT.xyz;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_6.zxy) - (tmpvar_5.zxy * tmpvar_6.yzx)) * _glesTANGENT.w);
  tmpvar_9 = _glesNormal;
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_7.x;
  tmpvar_10[0].y = tmpvar_8.x;
  tmpvar_10[0].z = tmpvar_9.x;
  tmpvar_10[1].x = tmpvar_7.y;
  tmpvar_10[1].y = tmpvar_8.y;
  tmpvar_10[1].z = tmpvar_9.y;
  tmpvar_10[2].x = tmpvar_7.z;
  tmpvar_10[2].y = tmpvar_8.z;
  tmpvar_10[2].z = tmpvar_9.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((tmpvar_10 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_11)
  .xyz)));
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 fc_2;
  highp vec3 worldNorm_3;
  mediump vec4 tex_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixV[0].xyz;
  tmpvar_6[1] = unity_MatrixV[1].xyz;
  tmpvar_6[2] = unity_MatrixV[2].xyz;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * xlv_TEXCOORD1);
  worldNorm_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (worldNorm_3, normalize((xlv_TEXCOORD2 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD2) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_8.xy * 0.5) + 0.5);
  tmpvar_9 = texture2D (_MatCap, P_10);
  mediump vec4 tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * tex_4) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  fc_2.xyz = tmpvar_11.xyz;
  fc_2.w = _BloomFactor;
  tmpvar_1 = fc_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _glesVertex.xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = unity_WorldToObject[0].xyz;
  tmpvar_3[1] = unity_WorldToObject[1].xyz;
  tmpvar_3[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = normalize((_glesNormal * tmpvar_3));
  tmpvar_1 = tmpvar_4;
  highp vec3 tmpvar_5;
  tmpvar_5 = normalize(_glesNormal);
  highp vec3 tmpvar_6;
  tmpvar_6 = normalize(_glesTANGENT.xyz);
  highp vec3 tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_7 = _glesTANGENT.xyz;
  tmpvar_8 = (((tmpvar_5.yzx * tmpvar_6.zxy) - (tmpvar_5.zxy * tmpvar_6.yzx)) * _glesTANGENT.w);
  tmpvar_9 = _glesNormal;
  highp mat3 tmpvar_10;
  tmpvar_10[0].x = tmpvar_7.x;
  tmpvar_10[0].y = tmpvar_8.x;
  tmpvar_10[0].z = tmpvar_9.x;
  tmpvar_10[1].x = tmpvar_7.y;
  tmpvar_10[1].y = tmpvar_8.y;
  tmpvar_10[1].z = tmpvar_9.y;
  tmpvar_10[2].x = tmpvar_7.z;
  tmpvar_10[2].y = tmpvar_8.z;
  tmpvar_10[2].z = tmpvar_9.z;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = _WorldSpaceCameraPos;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_2));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
  xlv_TEXCOORD2 = normalize((tmpvar_10 * (_glesVertex.xyz - 
    (unity_WorldToObject * tmpvar_11)
  .xyz)));
}


#endif
#ifdef FRAGMENT
uniform highp mat4 unity_MatrixV;
uniform mediump vec4 _Color;
uniform mediump float _MetalRef;
uniform mediump float _BloomFactor;
uniform sampler2D _MainTex;
uniform sampler2D _MatCap;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 fc_2;
  highp vec3 worldNorm_3;
  mediump vec4 tex_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_4 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_MatrixV[0].xyz;
  tmpvar_6[1] = unity_MatrixV[1].xyz;
  tmpvar_6[2] = unity_MatrixV[2].xyz;
  mediump vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * xlv_TEXCOORD1);
  worldNorm_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (worldNorm_3, normalize((xlv_TEXCOORD2 - 
    (2.0 * (dot (worldNorm_3, xlv_TEXCOORD2) * worldNorm_3))
  )), vec3(_MetalRef));
  worldNorm_3 = tmpvar_8;
  lowp vec4 tmpvar_9;
  highp vec2 P_10;
  P_10 = ((tmpvar_8.xy * 0.5) + 0.5);
  tmpvar_9 = texture2D (_MatCap, P_10);
  mediump vec4 tmpvar_11;
  tmpvar_11 = ((tmpvar_9 * tex_4) * (vec4(2.0, 2.0, 2.0, 2.0) * _Color));
  fc_2.xyz = tmpvar_11.xyz;
  fc_2.w = _BloomFactor;
  tmpvar_1 = fc_2;
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
  LOD 200
  Tags { "OutlineType" = "Simple" "RenderType" = "Opaque" }
  Cull Front
  GpuProgramID 94202
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_20;
    highp vec4 tmpvar_21;
    tmpvar_21 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_22;
    tmpvar_22.x = tmpvar_21.x;
    tmpvar_22.y = (tmpvar_21.y * _ProjectionParams.x);
    o_20.xy = (tmpvar_22 + tmpvar_21.w);
    o_20.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_20.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = dot (_glesVertex.xyz, _ClipPlane.xyz);
  if ((tmpvar_13 < (_ClipPlane.w - 0.01))) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_13 - _ClipPlane.w) * _ClipPlane.xyz));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_14;
  tmpvar_14 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_14;
  mediump float tmpvar_15;
  tmpvar_15 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_15;
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_MatrixMV[0].xyz;
  tmpvar_16[1] = unity_MatrixMV[1].xyz;
  tmpvar_16[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_17.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_18;
  tmpvar_18 = normalize(N_2);
  N_2 = tmpvar_18;
  mediump float tmpvar_19;
  tmpvar_19 = ((_OutlineWidth * _Scale) * tmpvar_15);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_18.xy * tmpvar_19));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (vertex_11 * 0.5);
  highp vec2 tmpvar_22;
  tmpvar_22.x = (tmpvar_21.x + (tmpvar_21.z * tmpvar_21.z));
  tmpvar_22.y = ((tmpvar_21.y + (0.5 * tmpvar_21.z)) + ((0.5 * tmpvar_21.x) * tmpvar_21.x));
  spnoiseuv_20 = ((tmpvar_22 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_23;
    highp vec4 tmpvar_24;
    tmpvar_24 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_25;
    tmpvar_25.x = tmpvar_24.x;
    tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
    o_23.xy = (tmpvar_25 + tmpvar_24.w);
    o_23.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_23.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_20;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_26;
    highp vec4 tmpvar_27;
    tmpvar_27 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_28;
    tmpvar_28.x = tmpvar_27.x;
    tmpvar_28.y = (tmpvar_27.y * _ProjectionParams.x);
    o_26.xy = (tmpvar_28 + tmpvar_27.w);
    o_26.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_26.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1.xyz = (xlv_COLOR0.xyz * _Color.xyz);
  color_1.w = (xlv_COLOR0.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_2;
    scrpos_2 = xlv_TEXCOORD3;
    mediump float a_3;
    a_3 = xlv_TEXCOORD3.z;
    if ((a_3 < 0.95)) {
      scrpos_2.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_3 = (a_3 * 17.0);
      highp float tmpvar_4;
      tmpvar_4 = (scrpos_2.y / 4.0);
      highp float tmpvar_5;
      tmpvar_5 = (fract(abs(tmpvar_4)) * 4.0);
      highp float tmpvar_6;
      if ((tmpvar_4 >= 0.0)) {
        tmpvar_6 = tmpvar_5;
      } else {
        tmpvar_6 = -(tmpvar_5);
      };
      highp float tmpvar_7;
      tmpvar_7 = (scrpos_2.x / 4.0);
      highp float tmpvar_8;
      tmpvar_8 = (fract(abs(tmpvar_7)) * 4.0);
      highp float tmpvar_9;
      if ((tmpvar_7 >= 0.0)) {
        tmpvar_9 = tmpvar_8;
      } else {
        tmpvar_9 = -(tmpvar_8);
      };
      highp float x_10;
      x_10 = ((a_3 - _DITHERMATRIX[
        int(tmpvar_6)
      ][
        int(tmpvar_9)
      ]) - 0.01);
      if ((x_10 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _SPNoiseTex_ST;
uniform mediump float _OutlineWidth;
uniform mediump vec4 _OutlineColor;
uniform mediump float _Scale;
uniform mediump float _VertexAlphaFactor;
uniform highp vec4 _ClipPlane;
uniform mediump float _FadeDistance;
uniform mediump float _FadeOffset;
uniform highp float _UsingDitherAlpha;
uniform highp float _DitherAlpha;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 N_2;
  mediump float S_3;
  highp vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5.xyz = _OutlineColor.xyz;
  highp float fadeOffset_7;
  fadeOffset_7 = _FadeOffset;
  highp float fadeDistance_8;
  fadeDistance_8 = _FadeDistance;
  highp float tmpvar_9;
  tmpvar_9 = clamp (((
    (-((unity_MatrixMV * _glesVertex).z) - _ProjectionParams.y)
   - fadeOffset_7) / fadeDistance_8), 0.0, 1.0);
  tmpvar_5.w = (_OutlineColor.w * tmpvar_9);
  tmpvar_5.w = (tmpvar_5.w * mix (1.0, _glesColor.w, _VertexAlphaFactor));
  highp float alpha_10;
  alpha_10 = tmpvar_5.w;
  highp vec4 vertex_11;
  vertex_11 = tmpvar_1;
  highp float tmpvar_12;
  highp vec4 pointInPlane_13;
  highp float tmpvar_14;
  tmpvar_14 = abs(_ClipPlane.w);
  if ((tmpvar_14 < 0.001)) {
    pointInPlane_13 = vec4(0.0, 0.0, 0.0, 1.0);
  } else {
    highp vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = (_ClipPlane.xyz * _ClipPlane.w);
    pointInPlane_13 = tmpvar_15;
  };
  pointInPlane_13 = (unity_WorldToObject * pointInPlane_13);
  pointInPlane_13 = (pointInPlane_13 / pointInPlane_13.w);
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_WorldToObject[0].xyz;
  tmpvar_16[1] = unity_WorldToObject[1].xyz;
  tmpvar_16[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_16 * _ClipPlane.xyz);
  highp float tmpvar_18;
  tmpvar_18 = dot (pointInPlane_13.xyz, tmpvar_17);
  highp float tmpvar_19;
  tmpvar_19 = dot (_glesVertex.xyz, tmpvar_17);
  if ((tmpvar_19 < tmpvar_18)) {
    vertex_11.xyz = (_glesVertex.xyz - ((tmpvar_19 - tmpvar_18) * tmpvar_17));
    tmpvar_12 = 0.0;
  } else {
    tmpvar_12 = alpha_10;
  };
  tmpvar_1 = vertex_11;
  tmpvar_5.w = tmpvar_12;
  tmpvar_4 = (unity_MatrixMV * vertex_11);
  tmpvar_4 = (tmpvar_4 / tmpvar_4.w);
  highp float tmpvar_20;
  tmpvar_20 = (-(tmpvar_4.z) / unity_CameraProjection[1].y);
  S_3 = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = pow ((S_3 / _Scale), 0.5);
  S_3 = tmpvar_21;
  highp mat3 tmpvar_22;
  tmpvar_22[0] = unity_MatrixMV[0].xyz;
  tmpvar_22[1] = unity_MatrixMV[1].xyz;
  tmpvar_22[2] = unity_MatrixMV[2].xyz;
  highp vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_22 * _glesTANGENT.xyz);
  N_2.xy = tmpvar_23.xy;
  N_2.z = 0.01;
  mediump vec3 tmpvar_24;
  tmpvar_24 = normalize(N_2);
  N_2 = tmpvar_24;
  mediump float tmpvar_25;
  tmpvar_25 = ((_OutlineWidth * _Scale) * tmpvar_21);
  tmpvar_4.xy = (tmpvar_4.xy + (tmpvar_24.xy * tmpvar_25));
  tmpvar_4 = (glstate_matrix_projection * tmpvar_4);
  highp vec2 spnoiseuv_26;
  highp vec4 tmpvar_27;
  tmpvar_27 = (vertex_11 * 0.5);
  highp vec2 tmpvar_28;
  tmpvar_28.x = (tmpvar_27.x + (tmpvar_27.z * tmpvar_27.z));
  tmpvar_28.y = ((tmpvar_27.y + (0.5 * tmpvar_27.z)) + ((0.5 * tmpvar_27.x) * tmpvar_27.x));
  spnoiseuv_26 = ((tmpvar_28 * _SPNoiseTex_ST.xy) + _SPNoiseTex_ST.zw);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 o_29;
    highp vec4 tmpvar_30;
    tmpvar_30 = (tmpvar_4 * 0.5);
    highp vec2 tmpvar_31;
    tmpvar_31.x = tmpvar_30.x;
    tmpvar_31.y = (tmpvar_30.y * _ProjectionParams.x);
    o_29.xy = (tmpvar_31 + tmpvar_30.w);
    o_29.zw = tmpvar_4.zw;
    tmpvar_6.xyw = o_29.xyw;
    tmpvar_6.z = _DitherAlpha;
  };
  gl_Position = tmpvar_4;
  xlv_COLOR0 = tmpvar_5;
  xlv_TEXCOORD0 = spnoiseuv_26;
  xlv_TEXCOORD3 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ScreenParams;
uniform sampler2D _SPNoiseTex;
uniform highp float _SPNoiseScaler;
uniform highp float _SPTransition;
uniform mediump vec4 _SPOutlineColor;
uniform highp mat4 _DITHERMATRIX;
uniform mediump vec4 _Color;
uniform mediump float _Opaqueness;
uniform highp float _UsingDitherAlpha;
highp float xlat_mutable_SPTransition;
varying mediump vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 color_1;
  color_1 = xlv_COLOR0;
  mediump float intensity_2;
  mediump vec4 outColor_3;
  outColor_3 = _SPOutlineColor;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNoiseTex, xlv_TEXCOORD0);
  highp float tmpvar_5;
  tmpvar_5 = (((1.99 * tmpvar_4.x) * _SPNoiseScaler) - 1.0);
  intensity_2 = tmpvar_5;
  xlat_mutable_SPTransition = (_SPTransition * _SPNoiseScaler);
  if ((intensity_2 >= (1.7 * xlat_mutable_SPTransition))) {
    outColor_3 = xlv_COLOR0;
  };
  color_1.xyz = (outColor_3.xyz * _Color.xyz);
  color_1.w = (outColor_3.w * _Opaqueness);
  if (bool(_UsingDitherAlpha)) {
    highp vec4 scrpos_6;
    scrpos_6 = xlv_TEXCOORD3;
    mediump float a_7;
    a_7 = xlv_TEXCOORD3.z;
    if ((a_7 < 0.95)) {
      scrpos_6.xy = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) * _ScreenParams.xy);
      a_7 = (a_7 * 17.0);
      highp float tmpvar_8;
      tmpvar_8 = (scrpos_6.y / 4.0);
      highp float tmpvar_9;
      tmpvar_9 = (fract(abs(tmpvar_8)) * 4.0);
      highp float tmpvar_10;
      if ((tmpvar_8 >= 0.0)) {
        tmpvar_10 = tmpvar_9;
      } else {
        tmpvar_10 = -(tmpvar_9);
      };
      highp float tmpvar_11;
      tmpvar_11 = (scrpos_6.x / 4.0);
      highp float tmpvar_12;
      tmpvar_12 = (fract(abs(tmpvar_11)) * 4.0);
      highp float tmpvar_13;
      if ((tmpvar_11 >= 0.0)) {
        tmpvar_13 = tmpvar_12;
      } else {
        tmpvar_13 = -(tmpvar_12);
      };
      highp float x_14;
      x_14 = ((a_7 - _DITHERMATRIX[
        int(tmpvar_10)
      ][
        int(tmpvar_13)
      ]) - 0.01);
      if ((x_14 < 0.0)) {
        discard;
      };
    };
  };
  color_1.w = clamp (color_1.w, 0.0, 1.0);
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
SubProgram "gles hw_tier00 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPECIAL_STATE" "CLIP_PLANE_WORLD" }
""
}
}
}
}
Fallback "Diffuse"
}