//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_ParticleNew/EffectFrozen_New" {
Properties {
_SPNCubeMap ("SPNCubeMap", Cube) = "white" { }
_SPNIceBumpTex ("SPNSPNIceBumpTex", 2D) = "white" { }
_SPNCubeMapIndensity ("SPNCubeMapIndensity", Range(0, 1)) = 0.5
_SPNCubeMapBrightNess ("SPNCubeMapBrightNess", Float) = 1.26
_SPNIceDarkColor ("SPNIceDarkColor", Color) = (0.1803922,0.2,0.2117647,0)
_SPNIceLightColor ("SPNIceLightColor", Color) = (0.5529412,0.7058824,0.7803922,0)
_SPNBumpTexIndensity ("SPNBumpTexIndensity", Range(0, 1)) = 1
_SPNIceMaskTex ("SPNIceMaskTex", 2D) = "white" { }
_SPNTillingNormal ("SPNTillingNormal", 2D) = "bump" { }
_SPNNormalIntensity ("SPNNormalIntensity", Vector) = (0.57,0.5,0.81,0)
_SPNBumpOffsetScale ("SPNBumpOffsetScale", Range(-0.5, 0)) = 0
_SPNBumpOffsetHeight ("SPNBumpOffsetHeight", Float) = 0.26
}
SubShader {
 LOD 100
 Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
 Pass {
  LOD 100
  Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
  GpuProgramID 46965
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
varying highp vec4 xlv_COLOR;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = _glesVertex.w;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_2.xyz = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_6[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_6[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((tmpvar_6 * _glesTANGENT.xyz));
  tmpvar_3.xyz = tmpvar_7;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_glesNormal * tmpvar_8));
  tmpvar_4.xyz = tmpvar_9;
  tmpvar_5.xyz = (((tmpvar_9.yzx * tmpvar_7.zxy) - (tmpvar_9.zxy * tmpvar_7.yzx)) * (_glesTANGENT.w * unity_WorldTransformParams.w));
  tmpvar_2.w = 0.0;
  tmpvar_3.w = 0.0;
  tmpvar_4.w = 0.0;
  tmpvar_5.w = 0.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = tmpvar_1.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = tmpvar_3;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = tmpvar_5;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp samplerCube _SPNCubeMap;
uniform sampler2D _SPNIceBumpTex;
uniform highp float _SPNCubeMapIndensity;
uniform highp float _SPNCubeMapBrightNess;
uniform mediump vec4 _SPNIceDarkColor;
uniform mediump vec4 _SPNIceLightColor;
uniform highp float _SPNBumpTexIndensity;
uniform sampler2D _SPNIceMaskTex;
uniform sampler2D _SPNTillingNormal;
uniform highp vec4 _SPNNormalIntensity;
uniform highp float _SPNBumpOffsetScale;
uniform highp float _SPNBumpOffsetHeight;
uniform mediump float _LumiFactor;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 aseOutColor_1;
  highp vec3 tmpvar_2;
  tmpvar_2 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD3.xyz));
  highp vec2 tmpvar_3;
  tmpvar_3 = (((
    (_SPNBumpOffsetHeight - 1.0)
   * tmpvar_2.xy) * (_SPNBumpOffsetScale * 0.1)) + xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_SPNIceBumpTex, tmpvar_3);
  highp vec3 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD4.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = xlv_TEXCOORD5.xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = xlv_TEXCOORD6.xyz;
  highp vec3 tmpvar_8;
  tmpvar_8.x = tmpvar_5.x;
  tmpvar_8.y = tmpvar_7.x;
  tmpvar_8.z = tmpvar_6.x;
  highp vec3 tmpvar_9;
  tmpvar_9.x = tmpvar_5.y;
  tmpvar_9.y = tmpvar_7.y;
  tmpvar_9.z = tmpvar_6.y;
  highp vec3 tmpvar_10;
  tmpvar_10.x = tmpvar_5.z;
  tmpvar_10.y = tmpvar_7.z;
  tmpvar_10.z = tmpvar_6.z;
  lowp vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_SPNTillingNormal, xlv_TEXCOORD0.xy);
  tmpvar_11.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_13;
  tmpvar_13.w = 0.0;
  tmpvar_13.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  lowp vec4 tmpvar_14;
  tmpvar_14.w = 0.0;
  tmpvar_14.xyz = ((tmpvar_12.xyz * 2.0) - 1.0);
  highp vec3 tmpvar_15;
  tmpvar_15.x = dot (tmpvar_8, (tmpvar_11 * _SPNNormalIntensity).xyz);
  tmpvar_15.y = dot (tmpvar_9, (tmpvar_13 * _SPNNormalIntensity).xyz);
  tmpvar_15.z = dot (tmpvar_10, (tmpvar_14 * _SPNNormalIntensity).xyz);
  highp vec3 tmpvar_16;
  highp vec3 I_17;
  I_17 = -(tmpvar_2);
  tmpvar_16 = (I_17 - (2.0 * (
    dot (tmpvar_15, I_17)
   * tmpvar_15)));
  lowp vec4 tmpvar_18;
  tmpvar_18 = textureCube (_SPNCubeMap, tmpvar_16);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_SPNIceMaskTex, xlv_TEXCOORD0.xy);
  highp vec3 tmpvar_20;
  tmpvar_20 = mix (mix (_SPNIceDarkColor, _SPNIceLightColor, (tmpvar_4 * _SPNBumpTexIndensity)), (tmpvar_18 * _SPNCubeMapBrightNess), vec4((tmpvar_19.x * _SPNCubeMapIndensity))).xyz;
  aseOutColor_1 = tmpvar_20;
  aseOutColor_1 = mix (aseOutColor_1, vec3(dot (aseOutColor_1, vec3(0.3, 0.59, 0.11))), vec3(_LumiFactor));
  mediump vec4 tmpvar_21;
  tmpvar_21.xyz = aseOutColor_1;
  tmpvar_21.w = 1.0;
  gl_FragData[0] = tmpvar_21;
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
CustomEditor "ASEMaterialInspector"
}