//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Dynamic Sky/Moon Layer" {
Properties {
_MoonTex ("Moon Tex (Alpha)", 2D) = "white" { }
_MoonBumpTex ("Moon Bump", 2D) = "white" { }
}
SubShader {
 Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
 Pass {
  Tags { "QUEUE" = "Background" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 4362
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "FOG_LERP" }
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "FOG_LERP" }
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "FOG_LERP" }
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
uniform highp vec3 _ES_SkyCenterWorldPos;
uniform mediump vec3 _ES_SkyWorldUpDir;
uniform mediump float _ES_MoonLunarPhase;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec3 xlv_TEXCOORD1;
varying mediump vec4 xlv_TEXCOORD2;
varying mediump vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 localViewDir_2;
  mediump vec2 rotatedLight_3;
  highp vec2 tmpvar_4;
  mediump vec3 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec4 clipPos_7;
  highp vec4 tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  tmpvar_8 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  clipPos_7.xyw = tmpvar_8.xyw;
  clipPos_7.z = tmpvar_8.w;
  tmpvar_4 = _glesMultiTexCoord0.xy;
  highp mat3 tmpvar_10;
  tmpvar_10[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_10[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_10[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((tmpvar_10 * _glesVertex.xyz));
  tmpvar_5 = tmpvar_11;
  highp float angle_12;
  angle_12 = _ES_MoonLunarPhase;
  angle_12 = (angle_12 * 6.283185);
  highp float tmpvar_13;
  tmpvar_13 = sin(angle_12);
  highp float tmpvar_14;
  tmpvar_14 = cos(angle_12);
  highp vec2 tmpvar_15;
  tmpvar_15.x = tmpvar_14;
  tmpvar_15.y = -(tmpvar_13);
  highp vec2 tmpvar_16;
  tmpvar_16.x = tmpvar_13;
  tmpvar_16.y = tmpvar_14;
  highp vec2 tmpvar_17;
  tmpvar_17.x = dot (tmpvar_15, vec2(0.0, -1.0));
  tmpvar_17.y = dot (tmpvar_16, vec2(0.0, -1.0));
  rotatedLight_3 = tmpvar_17;
  mediump vec3 tmpvar_18;
  tmpvar_18.y = 0.0;
  tmpvar_18.x = rotatedLight_3.x;
  tmpvar_18.z = rotatedLight_3.y;
  mediump vec3 tmpvar_19;
  tmpvar_19 = normalize(_glesNormal);
  mediump vec3 tmpvar_20;
  tmpvar_20 = normalize(_glesTANGENT.xyz);
  mediump vec3 tmpvar_21;
  mediump vec3 tmpvar_22;
  mediump vec3 tmpvar_23;
  tmpvar_21 = _glesTANGENT.xyz;
  tmpvar_22 = (((tmpvar_19.yzx * tmpvar_20.zxy) - (tmpvar_19.zxy * tmpvar_20.yzx)) * _glesTANGENT.w);
  tmpvar_23 = _glesNormal;
  mediump mat3 tmpvar_24;
  tmpvar_24[0].x = tmpvar_21.x;
  tmpvar_24[0].y = tmpvar_22.x;
  tmpvar_24[0].z = tmpvar_23.x;
  tmpvar_24[1].x = tmpvar_21.y;
  tmpvar_24[1].y = tmpvar_22.y;
  tmpvar_24[1].z = tmpvar_23.y;
  tmpvar_24[2].x = tmpvar_21.z;
  tmpvar_24[2].y = tmpvar_22.z;
  tmpvar_24[2].z = tmpvar_23.z;
  tmpvar_6.xyz = (tmpvar_24 * normalize(tmpvar_18));
  highp vec4 tmpvar_25;
  tmpvar_25.w = 1.0;
  tmpvar_25.xyz = _WorldSpaceCameraPos;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(((unity_WorldToObject * tmpvar_25).xyz - _glesVertex.xyz));
  localViewDir_2 = tmpvar_26;
  mediump float depth_27;
  depth_27 = clamp (dot (localViewDir_2, _glesNormal), 0.0, 1.0);
  mediump float tmpvar_28;
  if ((depth_27 > 0.0)) {
    mediump float tmpvar_29;
    tmpvar_29 = (depth_27 * 3.0);
    tmpvar_28 = (1.0/(exp((tmpvar_29 * tmpvar_29))));
  } else {
    tmpvar_28 = 1.0;
  };
  tmpvar_6.w = (1.0 - tmpvar_28);
  mediump vec3 viewDir_30;
  highp vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(((unity_ObjectToWorld * tmpvar_31).xyz - _ES_SkyCenterWorldPos));
  viewDir_30 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = dot (_ES_SkyWorldUpDir, viewDir_30);
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = viewDir_30;
  tmpvar_34.w = ((sign(tmpvar_33) * (1.570796 - 
    (sqrt((1.0 - abs(tmpvar_33))) * (1.570796 + (abs(tmpvar_33) * (-0.2146018 + 
      (abs(tmpvar_33) * (0.08656672 + (abs(tmpvar_33) * -0.03102955)))
    ))))
  )) * 0.6366198);
  gl_Position = clipPos_7;
  xlv_TEXCOORD0 = tmpvar_4;
  xlv_TEXCOORD1 = tmpvar_5;
  xlv_TEXCOORD2 = tmpvar_6;
  xlv_TEXCOORD4 = tmpvar_34;
}


#endif
#ifdef FRAGMENT
uniform mediump vec3 _ES_MoonColor;
uniform mediump float _ES_MoonBrightness;
uniform sampler2D _MoonTex;
uniform sampler2D _MoonBumpTex;
varying highp vec2 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump float moon_3;
  mediump vec3 tangentNormal_4;
  lowp vec3 tmpvar_5;
  tmpvar_5 = ((texture2D (_MoonBumpTex, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  tangentNormal_4 = tmpvar_5;
  lowp float tmpvar_6;
  tmpvar_6 = texture2D (_MoonTex, xlv_TEXCOORD0).w;
  moon_3 = tmpvar_6;
  mediump vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = (((
    (moon_3 * _ES_MoonColor)
   * _ES_MoonBrightness) * clamp (
    dot (normalize(xlv_TEXCOORD2.xyz), tangentNormal_4)
  , 0.0, 1.0)) * xlv_TEXCOORD2.w);
  tmpvar_2 = tmpvar_7;
  tmpvar_1 = tmpvar_2;
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