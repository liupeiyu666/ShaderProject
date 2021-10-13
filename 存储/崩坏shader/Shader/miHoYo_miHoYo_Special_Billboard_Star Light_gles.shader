//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Special/Billboard/Star Light" {
Properties {
_TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
_MainTex ("Particle Texture", 2D) = "white" { }
_SizeScaleX ("Size Scale X", Float) = 1
_SizeScaleY ("Size Scale Y", Float) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_EmissionScaler ("Emission Scaler", Range(0, 50)) = 1
_CullBack ("Cull back (0: off, 1: on)", Float) = 0
_BloomMultColor ("Bloom intensity varies with color (0: off, 1: on)", Float) = 0
_PolygonOffsetFactor ("Polygon Offset Factor", Float) = 1
_PolygonOffsetUnit ("Polygon Offset Unit", Float) = -1000
_RotateSpeed ("Rotate Speed", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 39770
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
uniform mediump float _CullBack;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 pointDir_2;
  highp vec4 posInCamRotate_3;
  highp vec4 posInCam_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = _glesVertex.xy;
  posInCam_4.w = tmpvar_8.w;
  highp vec4 v_9;
  highp float tmpvar_10;
  tmpvar_10 = unity_ObjectToWorld[0].x;
  v_9.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = unity_ObjectToWorld[1].x;
  v_9.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = unity_ObjectToWorld[2].x;
  v_9.z = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_ObjectToWorld[3].x;
  v_9.w = tmpvar_13;
  highp vec4 v_14;
  v_14.x = tmpvar_10;
  v_14.y = tmpvar_11;
  v_14.z = tmpvar_12;
  v_14.w = tmpvar_13;
  highp vec4 v_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_ObjectToWorld[0].y;
  v_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_ObjectToWorld[1].y;
  v_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_ObjectToWorld[2].y;
  v_15.z = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_ObjectToWorld[3].y;
  v_15.w = tmpvar_19;
  highp vec4 v_20;
  v_20.x = tmpvar_16;
  v_20.y = tmpvar_17;
  v_20.z = tmpvar_18;
  v_20.w = tmpvar_19;
  highp vec4 v_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_ObjectToWorld[0].z;
  v_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_ObjectToWorld[1].z;
  v_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_ObjectToWorld[2].z;
  v_21.z = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_ObjectToWorld[3].z;
  v_21.w = tmpvar_25;
  highp vec4 v_26;
  v_26.x = tmpvar_22;
  v_26.y = tmpvar_23;
  v_26.z = tmpvar_24;
  v_26.w = tmpvar_25;
  posInCam_4.xyz = (tmpvar_8.xyz * sqrt((
    ((v_9 * v_14) + (v_15 * v_20))
   + 
    (v_21 * v_26)
  )).xyz);
  posInCamRotate_3.zw = posInCam_4.zw;
  highp vec4 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_7);
  highp float tmpvar_28;
  tmpvar_28 = ((sign(tmpvar_27.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_27.x))) * (1.570796 + (abs(tmpvar_27.x) * (-0.2146018 + 
      (abs(tmpvar_27.x) * (0.08656672 + (abs(tmpvar_27.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_29;
  tmpvar_29 = sin(tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = cos(tmpvar_28);
  posInCamRotate_3.x = ((posInCam_4.x * tmpvar_30) + (posInCam_4.y * tmpvar_29));
  posInCamRotate_3.y = ((posInCam_4.x * -(tmpvar_29)) + (posInCam_4.y * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_7 - posInCamRotate_3);
  pointDir_2 = tmpvar_31;
  if (bool(_CullBack)) {
    highp mat3 tmpvar_32;
    tmpvar_32[0] = unity_MatrixMV[0].xyz;
    tmpvar_32[1] = unity_MatrixMV[1].xyz;
    tmpvar_32[2] = unity_MatrixMV[2].xyz;
    pointDir_2 = (tmpvar_31 * sign(-(
      dot (_glesNormal, (tmpvar_32 * tmpvar_7.xyz))
    )));
  };
  tmpvar_5 = (glstate_matrix_projection * pointDir_2);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
uniform mediump float _CullBack;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 pointDir_2;
  highp vec4 posInCamRotate_3;
  highp vec4 posInCam_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = _glesVertex.xy;
  posInCam_4.w = tmpvar_8.w;
  highp vec4 v_9;
  highp float tmpvar_10;
  tmpvar_10 = unity_ObjectToWorld[0].x;
  v_9.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = unity_ObjectToWorld[1].x;
  v_9.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = unity_ObjectToWorld[2].x;
  v_9.z = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_ObjectToWorld[3].x;
  v_9.w = tmpvar_13;
  highp vec4 v_14;
  v_14.x = tmpvar_10;
  v_14.y = tmpvar_11;
  v_14.z = tmpvar_12;
  v_14.w = tmpvar_13;
  highp vec4 v_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_ObjectToWorld[0].y;
  v_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_ObjectToWorld[1].y;
  v_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_ObjectToWorld[2].y;
  v_15.z = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_ObjectToWorld[3].y;
  v_15.w = tmpvar_19;
  highp vec4 v_20;
  v_20.x = tmpvar_16;
  v_20.y = tmpvar_17;
  v_20.z = tmpvar_18;
  v_20.w = tmpvar_19;
  highp vec4 v_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_ObjectToWorld[0].z;
  v_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_ObjectToWorld[1].z;
  v_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_ObjectToWorld[2].z;
  v_21.z = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_ObjectToWorld[3].z;
  v_21.w = tmpvar_25;
  highp vec4 v_26;
  v_26.x = tmpvar_22;
  v_26.y = tmpvar_23;
  v_26.z = tmpvar_24;
  v_26.w = tmpvar_25;
  posInCam_4.xyz = (tmpvar_8.xyz * sqrt((
    ((v_9 * v_14) + (v_15 * v_20))
   + 
    (v_21 * v_26)
  )).xyz);
  posInCamRotate_3.zw = posInCam_4.zw;
  highp vec4 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_7);
  highp float tmpvar_28;
  tmpvar_28 = ((sign(tmpvar_27.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_27.x))) * (1.570796 + (abs(tmpvar_27.x) * (-0.2146018 + 
      (abs(tmpvar_27.x) * (0.08656672 + (abs(tmpvar_27.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_29;
  tmpvar_29 = sin(tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = cos(tmpvar_28);
  posInCamRotate_3.x = ((posInCam_4.x * tmpvar_30) + (posInCam_4.y * tmpvar_29));
  posInCamRotate_3.y = ((posInCam_4.x * -(tmpvar_29)) + (posInCam_4.y * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_7 - posInCamRotate_3);
  pointDir_2 = tmpvar_31;
  if (bool(_CullBack)) {
    highp mat3 tmpvar_32;
    tmpvar_32[0] = unity_MatrixMV[0].xyz;
    tmpvar_32[1] = unity_MatrixMV[1].xyz;
    tmpvar_32[2] = unity_MatrixMV[2].xyz;
    pointDir_2 = (tmpvar_31 * sign(-(
      dot (_glesNormal, (tmpvar_32 * tmpvar_7.xyz))
    )));
  };
  tmpvar_5 = (glstate_matrix_projection * pointDir_2);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
  gl_FragData[0] = color_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
highp mat4 unity_MatrixMV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
uniform mediump float _CullBack;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  mediump vec4 tmpvar_1;
  tmpvar_1 = _glesColor;
  highp vec4 pointDir_2;
  highp vec4 posInCamRotate_3;
  highp vec4 posInCam_4;
  highp vec4 tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_5 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_6 = vec2(0.0, 0.0);
  highp vec4 tmpvar_7;
  tmpvar_7 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = _glesVertex.xy;
  posInCam_4.w = tmpvar_8.w;
  highp vec4 v_9;
  highp float tmpvar_10;
  tmpvar_10 = unity_ObjectToWorld[0].x;
  v_9.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = unity_ObjectToWorld[1].x;
  v_9.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = unity_ObjectToWorld[2].x;
  v_9.z = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = unity_ObjectToWorld[3].x;
  v_9.w = tmpvar_13;
  highp vec4 v_14;
  v_14.x = tmpvar_10;
  v_14.y = tmpvar_11;
  v_14.z = tmpvar_12;
  v_14.w = tmpvar_13;
  highp vec4 v_15;
  highp float tmpvar_16;
  tmpvar_16 = unity_ObjectToWorld[0].y;
  v_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = unity_ObjectToWorld[1].y;
  v_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = unity_ObjectToWorld[2].y;
  v_15.z = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = unity_ObjectToWorld[3].y;
  v_15.w = tmpvar_19;
  highp vec4 v_20;
  v_20.x = tmpvar_16;
  v_20.y = tmpvar_17;
  v_20.z = tmpvar_18;
  v_20.w = tmpvar_19;
  highp vec4 v_21;
  highp float tmpvar_22;
  tmpvar_22 = unity_ObjectToWorld[0].z;
  v_21.x = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = unity_ObjectToWorld[1].z;
  v_21.y = tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = unity_ObjectToWorld[2].z;
  v_21.z = tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = unity_ObjectToWorld[3].z;
  v_21.w = tmpvar_25;
  highp vec4 v_26;
  v_26.x = tmpvar_22;
  v_26.y = tmpvar_23;
  v_26.z = tmpvar_24;
  v_26.w = tmpvar_25;
  posInCam_4.xyz = (tmpvar_8.xyz * sqrt((
    ((v_9 * v_14) + (v_15 * v_20))
   + 
    (v_21 * v_26)
  )).xyz);
  posInCamRotate_3.zw = posInCam_4.zw;
  highp vec4 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_7);
  highp float tmpvar_28;
  tmpvar_28 = ((sign(tmpvar_27.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_27.x))) * (1.570796 + (abs(tmpvar_27.x) * (-0.2146018 + 
      (abs(tmpvar_27.x) * (0.08656672 + (abs(tmpvar_27.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_29;
  tmpvar_29 = sin(tmpvar_28);
  highp float tmpvar_30;
  tmpvar_30 = cos(tmpvar_28);
  posInCamRotate_3.x = ((posInCam_4.x * tmpvar_30) + (posInCam_4.y * tmpvar_29));
  posInCamRotate_3.y = ((posInCam_4.x * -(tmpvar_29)) + (posInCam_4.y * tmpvar_30));
  highp vec4 tmpvar_31;
  tmpvar_31 = (tmpvar_7 - posInCamRotate_3);
  pointDir_2 = tmpvar_31;
  if (bool(_CullBack)) {
    highp mat3 tmpvar_32;
    tmpvar_32[0] = unity_MatrixMV[0].xyz;
    tmpvar_32[1] = unity_MatrixMV[1].xyz;
    tmpvar_32[2] = unity_MatrixMV[2].xyz;
    pointDir_2 = (tmpvar_31 * sign(-(
      dot (_glesNormal, (tmpvar_32 * tmpvar_7.xyz))
    )));
  };
  tmpvar_5 = (glstate_matrix_projection * pointDir_2);
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_6;
  xlv_COLOR = tmpvar_1;
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 _TintColor;
uniform sampler2D _MainTex;
uniform mediump float _EmissionScaler;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_3;
  tmpvar_3 = ((2.0 * _TintColor) * (xlv_COLOR * tmpvar_2));
  color_1.xyz = (tmpvar_3.xyz * (tmpvar_3.w * _EmissionScaler));
  color_1.w = clamp (tmpvar_3.w, 0.0, 1.0);
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
 Pass {
  Name "CONSTANT_MAX"
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 75173
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 posInCamRotate_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = _glesVertex.xy;
  posInCamRotate_1.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4 = normalize(tmpvar_2);
  highp float tmpvar_5;
  tmpvar_5 = ((sign(tmpvar_4.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_4.x))) * (1.570796 + (abs(tmpvar_4.x) * (-0.2146018 + 
      (abs(tmpvar_4.x) * (0.08656672 + (abs(tmpvar_4.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_6;
  tmpvar_6 = sin(tmpvar_5);
  highp float tmpvar_7;
  tmpvar_7 = cos(tmpvar_5);
  posInCamRotate_1.x = ((_glesVertex.x * tmpvar_7) + (_glesVertex.y * tmpvar_6));
  posInCamRotate_1.y = ((_glesVertex.x * -(tmpvar_6)) + (_glesVertex.y * tmpvar_7));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - posInCamRotate_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _BloomMultColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float bloom_1;
  mediump vec4 texColor_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_4;
  lowp float x_5;
  x_5 = (tmpvar_4.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  bloom_1 = _BloomFactor;
  if (bool(_BloomMultColor)) {
    bloom_1 = (_BloomFactor * ((
      (texColor_2.x + texColor_2.y)
     + texColor_2.z) / 3.0));
  };
  color_3.w = bloom_1;
  gl_FragData[0] = color_3;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 posInCamRotate_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = _glesVertex.xy;
  posInCamRotate_1.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4 = normalize(tmpvar_2);
  highp float tmpvar_5;
  tmpvar_5 = ((sign(tmpvar_4.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_4.x))) * (1.570796 + (abs(tmpvar_4.x) * (-0.2146018 + 
      (abs(tmpvar_4.x) * (0.08656672 + (abs(tmpvar_4.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_6;
  tmpvar_6 = sin(tmpvar_5);
  highp float tmpvar_7;
  tmpvar_7 = cos(tmpvar_5);
  posInCamRotate_1.x = ((_glesVertex.x * tmpvar_7) + (_glesVertex.y * tmpvar_6));
  posInCamRotate_1.y = ((_glesVertex.x * -(tmpvar_6)) + (_glesVertex.y * tmpvar_7));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - posInCamRotate_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _BloomMultColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float bloom_1;
  mediump vec4 texColor_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_4;
  lowp float x_5;
  x_5 = (tmpvar_4.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  bloom_1 = _BloomFactor;
  if (bool(_BloomMultColor)) {
    bloom_1 = (_BloomFactor * ((
      (texColor_2.x + texColor_2.y)
     + texColor_2.z) / 3.0));
  };
  color_3.w = bloom_1;
  gl_FragData[0] = color_3;
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
uniform highp mat4 glstate_matrix_projection;
uniform highp mat4 unity_MatrixV;
uniform highp vec4 _MainTex_ST;
uniform highp float _RotateSpeed;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR;
void main ()
{
  highp vec4 posInCamRotate_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((unity_MatrixV * unity_ObjectToWorld) * vec4(0.0, 0.0, 0.0, 1.0));
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = _glesVertex.xy;
  posInCamRotate_1.zw = tmpvar_3.zw;
  highp vec4 tmpvar_4;
  tmpvar_4 = normalize(tmpvar_2);
  highp float tmpvar_5;
  tmpvar_5 = ((sign(tmpvar_4.x) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_4.x))) * (1.570796 + (abs(tmpvar_4.x) * (-0.2146018 + 
      (abs(tmpvar_4.x) * (0.08656672 + (abs(tmpvar_4.x) * -0.03102955)))
    ))))
  )) * _RotateSpeed);
  highp float tmpvar_6;
  tmpvar_6 = sin(tmpvar_5);
  highp float tmpvar_7;
  tmpvar_7 = cos(tmpvar_5);
  posInCamRotate_1.x = ((_glesVertex.x * tmpvar_7) + (_glesVertex.y * tmpvar_6));
  posInCamRotate_1.y = ((_glesVertex.x * -(tmpvar_6)) + (_glesVertex.y * tmpvar_7));
  gl_Position = (glstate_matrix_projection * (tmpvar_2 - posInCamRotate_1));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_COLOR = _glesColor;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _BloomFactor;
uniform mediump float _BloomMultColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump float bloom_1;
  mediump vec4 texColor_2;
  mediump vec4 color_3;
  color_3 = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  texColor_2 = tmpvar_4;
  lowp float x_5;
  x_5 = (tmpvar_4.w - 0.01);
  if ((x_5 < 0.0)) {
    discard;
  };
  bloom_1 = _BloomFactor;
  if (bool(_BloomMultColor)) {
    bloom_1 = (_BloomFactor * ((
      (texColor_2.x + texColor_2.y)
     + texColor_2.z) / 3.0));
  };
  color_3.w = bloom_1;
  gl_FragData[0] = color_3;
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
}