//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Special/Effect/Sphere Shield Horn" {
Properties {
_Color ("Main Color", Color) = (1,1,1,1)
_MainTex ("Main Tex (RGB)", 2D) = "white" { }
_Intensity ("Intensity", Range(0, 1)) = 1
_BloomFactor ("Bloom Factor", Float) = 1
_Culling ("Culling (0: Off, 1: Front, 2: Back)", Float) = 2
_CellShrink ("Cell Shrink", Float) = 0
_CellRimIntensity ("Cell Rim Intensity", Float) = 0.4
_RidgeRimIntensity ("Ridge Rim Intensity", Float) = 0.4
_BandPosition ("Band Position (rotate dir and angle)", Vector) = (1,1,0,1.57)
_BandWidth ("Band Width", Float) = 0
_BandIntensity ("Band Intensity", Float) = 0
[Toggle] _AlwaysFaceToCamera ("Always Face to Camera", Float) = 0
}
SubShader {
 LOD 200
 Tags { "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
 Pass {
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Front
  GpuProgramID 12202
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
  LOD 200
  Tags { "LIGHTMODE" = "FORWARDBASE" "OutlineType" = "None" "QUEUE" = "Transparent+1" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 81614
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
uniform highp mat4 unity_MatrixVP;
highp mat4 unity_MatrixMV;
uniform mediump vec4 _Color;
uniform mediump vec4 _BandPosition;
uniform mediump float _BandWidth;
uniform mediump float _BandIntensity;
uniform mediump float _AlwaysFaceToCamera;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  unity_MatrixMV = (unity_MatrixV * unity_ObjectToWorld);
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0;
  mediump vec3 cellNormal_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  mediump vec4 tmpvar_6;
  tmpvar_4 = vec4(0.0, 0.0, 0.0, 0.0);
  tmpvar_5 = tmpvar_2.xy;
  tmpvar_6 = (_glesColor * _Color);
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize(_glesNormal);
  cellNormal_3 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((vec3(1.0, 0.0, 0.0) * _BandPosition.zxy) - (vec3(0.0, 0.0, 1.0) * _BandPosition.yzx));
  mediump float tmpvar_9;
  tmpvar_9 = dot (cellNormal_3, normalize((
    (_BandPosition.yzx * tmpvar_8.zxy)
   - 
    (_BandPosition.zxy * tmpvar_8.yzx)
  )));
  mediump float tmpvar_10;
  tmpvar_10 = clamp ((abs(
    cos(((1.570796 - (
      sign(tmpvar_9)
     * 
      (1.570796 - (sqrt((1.0 - 
        abs(tmpvar_9)
      )) * (1.570796 + (
        abs(tmpvar_9)
       * 
        (-0.2146018 + (abs(tmpvar_9) * (0.08656672 + (
          abs(tmpvar_9)
         * -0.03102955))))
      ))))
    )) - _BandPosition.w))
  ) / _BandWidth), 0.0, 1.0);
  tmpvar_6 = (tmpvar_6 + ((_Color * 
    (1.0 - (tmpvar_10 * (tmpvar_10 * (3.0 - 
      (2.0 * tmpvar_10)
    ))))
  ) * _BandIntensity));
  if (bool(_AlwaysFaceToCamera)) {
    highp vec4 vertex_11;
    vertex_11 = (_glesVertex * 100.0);
    highp vec4 tmpvar_12;
    tmpvar_12 = (unity_MatrixMV * vec4(0.0, 0.0, 0.0, 1.0));
    highp mat3 tmpvar_13;
    tmpvar_13[0] = unity_MatrixV[0].xyz;
    tmpvar_13[1] = unity_MatrixV[1].xyz;
    tmpvar_13[2] = unity_MatrixV[2].xyz;
    highp vec3 tmpvar_14;
    tmpvar_14 = normalize((tmpvar_13 * vec3(0.0, 1.0, 0.0)));
    highp float tmpvar_15;
    tmpvar_15 = sqrt(dot (tmpvar_12, tmpvar_12));
    highp vec3 tmpvar_16;
    if ((tmpvar_15 == 0.0)) {
      tmpvar_16 = vec3(0.0, 0.0, 1.0);
    } else {
      tmpvar_16 = tmpvar_12.xyz;
    };
    highp vec3 tmpvar_17;
    tmpvar_17 = normalize(((tmpvar_14.yzx * tmpvar_16.zxy) - (tmpvar_14.zxy * tmpvar_16.yzx)));
    highp vec4 tmpvar_18;
    tmpvar_18.w = 0.0;
    tmpvar_18.xyz = (((tmpvar_17 * vertex_11.z) + (tmpvar_14 * vertex_11.y)) + ((
      (tmpvar_17.yzx * tmpvar_14.zxy)
     - 
      (tmpvar_17.zxy * tmpvar_14.yzx)
    ) * vertex_11.x));
    tmpvar_4 = (glstate_matrix_projection * (tmpvar_12 + tmpvar_18));
  } else {
    highp vec4 tmpvar_19;
    tmpvar_19.w = 1.0;
    tmpvar_19.xyz = tmpvar_1.xyz;
    tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_19));
  };
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_5;
  xlv_COLOR0 = tmpvar_6;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
uniform mediump float _RidgeRimIntensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 color_1;
  color_1.w = 0.0;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_1.xyz = (((xlv_COLOR0.w + 
    (tmpvar_2 * _RidgeRimIntensity)
  .x) * _Intensity) * xlv_COLOR0.xyz);
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
CustomEditor "MoleMole.PropShaderEditorBase"
}