//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Scenes/Scenes_NewHome/Double Segment" {
Properties {
_CreaseColor ("Crease Color", Color) = (0,0,0,1)
_CreaseWidth ("Crease Width", Range(0, 100)) = 0.2
_DistancePower ("Distance Power", Range(-100, 100)) = 0.2
_VertexOffset ("Vertex Offset", Float) = 0.01
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_ConstEmission ("Const Emission", Float) = 1
_SinEmission ("Sin Emission", Float) = 1
_BlinkSpeed ("Blink Speed", Float) = 1
}
SubShader {
 LOD 100
 Tags { "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "RenderType" = "Transparent" }
  Cull Off
  GpuProgramID 58304
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  gl_FragData[0] = xlat_mutable_CreaseColor;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  gl_FragData[0] = xlat_mutable_CreaseColor;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  gl_FragData[0] = xlat_mutable_CreaseColor;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
uniform mediump float _LumiFactor;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  xlat_mutable_CreaseColor.xyz = mix (xlat_mutable_CreaseColor.xyz, vec3(dot (xlat_mutable_CreaseColor.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_mutable_CreaseColor;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
uniform mediump float _LumiFactor;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  xlat_mutable_CreaseColor.xyz = mix (xlat_mutable_CreaseColor.xyz, vec3(dot (xlat_mutable_CreaseColor.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_mutable_CreaseColor;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LUMINANCE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
uniform highp vec4 _ScreenParams;
uniform highp mat4 unity_CameraProjection;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform mediump float _CreaseWidth;
uniform mediump float _DistancePower;
uniform mediump float _VertexOffset;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec3 tangent_1;
  mediump vec4 clip1_2;
  mediump vec4 clip0_3;
  mediump float disScale_4;
  mediump vec4 p1_5;
  mediump vec4 p0_6;
  mediump vec3 localVert_7;
  highp vec4 tmpvar_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = (_glesVertex.xyz - _glesTANGENT.xyz);
  localVert_7 = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11 = (unity_MatrixMV * tmpvar_10);
  p0_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = localVert_7;
  highp vec4 tmpvar_13;
  tmpvar_13 = (unity_MatrixMV * tmpvar_12);
  p1_5 = tmpvar_13;
  mediump vec4 tmpvar_14;
  tmpvar_14 = (p0_6 / p0_6.w);
  mediump vec4 tmpvar_15;
  tmpvar_15 = (p1_5 / p1_5.w);
  highp float tmpvar_16;
  tmpvar_16 = (-((
    (tmpvar_14 + tmpvar_15)
   / 2.0).z) / unity_CameraProjection[1].y);
  disScale_4 = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = pow (disScale_4, _DistancePower);
  disScale_4 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18 = (glstate_matrix_projection * p0_6);
  clip0_3 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = (glstate_matrix_projection * p1_5);
  clip1_2 = tmpvar_19;
  mediump float ypos_20;
  mediump float xpos_21;
  mediump vec3 tmpvar_22;
  tmpvar_22 = (clip0_3.xyz / clip0_3.w);
  highp float tmpvar_23;
  tmpvar_23 = (((tmpvar_22.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_21 = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = (((tmpvar_22.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_20 = tmpvar_24;
  mediump vec3 tmpvar_25;
  tmpvar_25.z = 0.0;
  tmpvar_25.x = xpos_21;
  tmpvar_25.y = ypos_20;
  mediump float ypos_26;
  mediump float xpos_27;
  mediump vec3 tmpvar_28;
  tmpvar_28 = (clip1_2.xyz / clip1_2.w);
  highp float tmpvar_29;
  tmpvar_29 = (((tmpvar_28.x * 0.5) + 0.5) * _ScreenParams.x);
  xpos_27 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = (((tmpvar_28.y * 0.5) + 0.5) * _ScreenParams.y);
  ypos_26 = tmpvar_30;
  mediump vec3 tmpvar_31;
  tmpvar_31.z = 0.0;
  tmpvar_31.x = xpos_27;
  tmpvar_31.y = ypos_26;
  highp vec3 tmpvar_32;
  tmpvar_32 = ((tmpvar_25 - tmpvar_31) * _glesTANGENT.w);
  tangent_1 = tmpvar_32;
  mediump vec2 tmpvar_33;
  tmpvar_33.x = -(tangent_1.y);
  tmpvar_33.y = tangent_1.x;
  mediump vec2 tmpvar_34;
  tmpvar_34 = ((normalize(tmpvar_33) * _CreaseWidth) * tmpvar_17);
  mediump vec4 tmpvar_35;
  mediump float ypos_36;
  mediump float xpos_37;
  highp float tmpvar_38;
  tmpvar_38 = ((tmpvar_34.x / _ScreenParams.x) * 2.0);
  xpos_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = ((tmpvar_34.y / _ScreenParams.y) * 2.0);
  ypos_36 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.zw = vec2(0.0, 0.0);
  tmpvar_40.x = xpos_37;
  tmpvar_40.y = ypos_36;
  tmpvar_35 = (tmpvar_40 * clip0_3.w);
  tmpvar_8 = (clip0_3 + tmpvar_35);
  tmpvar_8.z = (tmpvar_8.z + _VertexOffset);
  gl_Position = tmpvar_8;
  xlv_COLOR = vec4(0.0, 0.0, 0.0, 0.0);
  xlv_TEXCOORD0 = vec2(0.0, 0.0);
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _Time;
uniform mediump vec4 _CreaseColor;
uniform mediump float _BlinkSpeed;
uniform mediump float _ConstEmission;
uniform mediump float _SinEmission;
uniform mediump float _LumiFactor;
mediump vec4 xlat_mutable_CreaseColor;
mediump float xlat_mutable_EmissionScaler;
void main ()
{
  xlat_mutable_CreaseColor.w = _CreaseColor.w;
  highp float tmpvar_1;
  tmpvar_1 = abs(sin((_Time.y * _BlinkSpeed)));
  xlat_mutable_EmissionScaler = (_ConstEmission + (_SinEmission * tmpvar_1));
  xlat_mutable_CreaseColor.xyz = (_CreaseColor.xyz * xlat_mutable_EmissionScaler);
  xlat_mutable_CreaseColor.xyz = mix (xlat_mutable_CreaseColor.xyz, vec3(dot (xlat_mutable_CreaseColor.xyz, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  gl_FragData[0] = xlat_mutable_CreaseColor;
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
}