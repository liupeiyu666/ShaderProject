//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCSKLHOutBallV1" {
Properties {
_Color0 ("Color 0", Color) = (0.754717,0.754717,0.754717,0)
_Color1 ("Color 1", Color) = (0.754717,0.754717,0.754717,0)
_depthFade ("depthFade", Vector) = (0,0,0,0)
_Color2 ("Color 2", Color) = (0,0,0,0)
_opacity ("opacity", Float) = 0
_depth ("depth", Float) = 0
_TextureSample0 ("Texture Sample 0", 2D) = "white" { }
_fadeColor ("fadeColor", Color) = (0,0,0,0)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 42976
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec4 hdr_28;
  hdr_28 = tmpvar_2;
  mediump vec4 tmpvar_29;
  tmpvar_29.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_29.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_30;
  tmpvar_30 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_29.xyz, tmpvar_29.w);
  mediump vec4 tmpvar_31;
  tmpvar_31 = tmpvar_30;
  lowp vec3 tmpvar_32;
  mediump vec4 c_33;
  highp vec3 tmpvar_34;
  tmpvar_34 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_35;
  mediump vec3 albedo_36;
  albedo_36 = tmpvar_11;
  mediump vec3 tmpvar_37;
  tmpvar_37 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_36, vec3(tmpvar_6));
  mediump float tmpvar_38;
  tmpvar_38 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_35 = (albedo_36 * tmpvar_38);
  tmpvar_32 = tmpvar_35;
  mediump vec3 diffColor_39;
  diffColor_39 = tmpvar_32;
  mediump float alpha_40;
  alpha_40 = tmpvar_13;
  tmpvar_32 = diffColor_39;
  mediump vec3 diffColor_41;
  diffColor_41 = tmpvar_32;
  mediump vec3 color_42;
  mediump vec2 rlPow4AndFresnelTerm_43;
  mediump float tmpvar_44;
  highp float tmpvar_45;
  tmpvar_45 = clamp (dot (tmpvar_34, tmpvar_4), 0.0, 1.0);
  tmpvar_44 = tmpvar_45;
  mediump float tmpvar_46;
  highp float tmpvar_47;
  tmpvar_47 = clamp (dot (tmpvar_34, worldViewDir_8), 0.0, 1.0);
  tmpvar_46 = tmpvar_47;
  highp vec2 tmpvar_48;
  tmpvar_48.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_34, worldViewDir_8) * tmpvar_34)
  )), tmpvar_4);
  tmpvar_48.y = (1.0 - tmpvar_46);
  highp vec2 tmpvar_49;
  tmpvar_49 = ((tmpvar_48 * tmpvar_48) * (tmpvar_48 * tmpvar_48));
  rlPow4AndFresnelTerm_43 = tmpvar_49;
  mediump float tmpvar_50;
  tmpvar_50 = rlPow4AndFresnelTerm_43.x;
  mediump float specular_51;
  highp float smoothness_52;
  smoothness_52 = tmpvar_7;
  highp vec2 tmpvar_53;
  tmpvar_53.x = tmpvar_50;
  tmpvar_53.y = (1.0 - smoothness_52);
  highp float tmpvar_54;
  tmpvar_54 = (texture2D (unity_NHxRoughness, tmpvar_53).w * 16.0);
  specular_51 = tmpvar_54;
  color_42 = ((diffColor_41 + (specular_51 * tmpvar_37)) * (tmpvar_3 * tmpvar_44));
  color_42 = (color_42 + ((
    (hdr_28.x * ((hdr_28.w * (tmpvar_31.w - 1.0)) + 1.0))
   * tmpvar_31.xyz) * mix (tmpvar_37, vec3(
    clamp ((tmpvar_7 + (1.0 - tmpvar_38)), 0.0, 1.0)
  ), rlPow4AndFresnelTerm_43.yyy)));
  mediump vec4 tmpvar_55;
  tmpvar_55.w = 1.0;
  tmpvar_55.xyz = color_42;
  c_33.xyz = tmpvar_55.xyz;
  c_33.w = alpha_40;
  c_5 = c_33;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 tmpvar_28;
  mediump vec4 hdr_29;
  hdr_29 = tmpvar_2;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_30.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_31;
  tmpvar_31 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30.xyz, tmpvar_30.w);
  mediump vec4 tmpvar_32;
  tmpvar_32 = tmpvar_31;
  tmpvar_28 = ((hdr_29.x * (
    (hdr_29.w * (tmpvar_32.w - 1.0))
   + 1.0)) * tmpvar_32.xyz);
  lowp vec3 tmpvar_33;
  mediump vec4 c_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_36;
  mediump vec3 albedo_37;
  albedo_37 = tmpvar_11;
  mediump vec3 tmpvar_38;
  tmpvar_38 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_37, vec3(tmpvar_6));
  mediump float tmpvar_39;
  tmpvar_39 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_36 = (albedo_37 * tmpvar_39);
  tmpvar_33 = tmpvar_36;
  mediump vec3 diffColor_40;
  diffColor_40 = tmpvar_33;
  mediump float alpha_41;
  alpha_41 = tmpvar_13;
  tmpvar_33 = diffColor_40;
  mediump vec3 diffColor_42;
  diffColor_42 = tmpvar_33;
  mediump vec3 color_43;
  mediump float surfaceReduction_44;
  highp float specularTerm_45;
  highp float a2_46;
  mediump float roughness_47;
  mediump float perceptualRoughness_48;
  highp vec3 tmpvar_49;
  highp vec3 inVec_50;
  inVec_50 = (tmpvar_4 + worldViewDir_8);
  tmpvar_49 = (inVec_50 * inversesqrt(max (0.001, 
    dot (inVec_50, inVec_50)
  )));
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (tmpvar_35, tmpvar_4), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp (dot (tmpvar_35, tmpvar_49), 0.0, 1.0);
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (tmpvar_35, worldViewDir_8), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_7;
  tmpvar_56 = (1.0 - smoothness_57);
  perceptualRoughness_48 = tmpvar_56;
  highp float tmpvar_58;
  highp float perceptualRoughness_59;
  perceptualRoughness_59 = perceptualRoughness_48;
  tmpvar_58 = (perceptualRoughness_59 * perceptualRoughness_59);
  roughness_47 = tmpvar_58;
  mediump float tmpvar_60;
  tmpvar_60 = (roughness_47 * roughness_47);
  a2_46 = tmpvar_60;
  specularTerm_45 = ((roughness_47 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_49), 0.0, 1.0)) * (1.5 + roughness_47))
   * 
    (((tmpvar_53 * tmpvar_53) * (a2_46 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_61;
  tmpvar_61 = clamp (specularTerm_45, 0.0, 100.0);
  specularTerm_45 = tmpvar_61;
  surfaceReduction_44 = (1.0 - ((roughness_47 * perceptualRoughness_48) * 0.28));
  mediump float x_62;
  x_62 = (1.0 - tmpvar_54);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (tmpvar_38, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_39)
  ), 0.0, 1.0)), vec3(((x_62 * x_62) * (x_62 * x_62))));
  highp vec3 tmpvar_64;
  tmpvar_64 = (((
    (diffColor_42 + (tmpvar_61 * tmpvar_38))
   * tmpvar_3) * tmpvar_51) + ((surfaceReduction_44 * tmpvar_28) * tmpvar_63));
  color_43 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.w = 1.0;
  tmpvar_65.xyz = color_43;
  c_34.xyz = tmpvar_65.xyz;
  c_34.w = alpha_41;
  c_5 = c_34;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = normalize((_glesNormal * tmpvar_9));
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 tmpvar_28;
  mediump vec4 hdr_29;
  hdr_29 = tmpvar_2;
  mediump vec4 tmpvar_30;
  tmpvar_30.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_30.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_31;
  tmpvar_31 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_30.xyz, tmpvar_30.w);
  mediump vec4 tmpvar_32;
  tmpvar_32 = tmpvar_31;
  tmpvar_28 = ((hdr_29.x * (
    (hdr_29.w * (tmpvar_32.w - 1.0))
   + 1.0)) * tmpvar_32.xyz);
  lowp vec3 tmpvar_33;
  mediump vec4 c_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_36;
  mediump vec3 albedo_37;
  albedo_37 = tmpvar_11;
  mediump vec3 tmpvar_38;
  tmpvar_38 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_37, vec3(tmpvar_6));
  mediump float tmpvar_39;
  tmpvar_39 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_36 = (albedo_37 * tmpvar_39);
  tmpvar_33 = tmpvar_36;
  mediump vec3 diffColor_40;
  diffColor_40 = tmpvar_33;
  mediump float alpha_41;
  alpha_41 = tmpvar_13;
  tmpvar_33 = diffColor_40;
  mediump vec3 diffColor_42;
  diffColor_42 = tmpvar_33;
  mediump vec3 color_43;
  mediump float surfaceReduction_44;
  highp float specularTerm_45;
  highp float a2_46;
  mediump float roughness_47;
  mediump float perceptualRoughness_48;
  highp vec3 tmpvar_49;
  highp vec3 inVec_50;
  inVec_50 = (tmpvar_4 + worldViewDir_8);
  tmpvar_49 = (inVec_50 * inversesqrt(max (0.001, 
    dot (inVec_50, inVec_50)
  )));
  mediump float tmpvar_51;
  highp float tmpvar_52;
  tmpvar_52 = clamp (dot (tmpvar_35, tmpvar_4), 0.0, 1.0);
  tmpvar_51 = tmpvar_52;
  highp float tmpvar_53;
  tmpvar_53 = clamp (dot (tmpvar_35, tmpvar_49), 0.0, 1.0);
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (tmpvar_35, worldViewDir_8), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_7;
  tmpvar_56 = (1.0 - smoothness_57);
  perceptualRoughness_48 = tmpvar_56;
  highp float tmpvar_58;
  highp float perceptualRoughness_59;
  perceptualRoughness_59 = perceptualRoughness_48;
  tmpvar_58 = (perceptualRoughness_59 * perceptualRoughness_59);
  roughness_47 = tmpvar_58;
  mediump float tmpvar_60;
  tmpvar_60 = (roughness_47 * roughness_47);
  a2_46 = tmpvar_60;
  specularTerm_45 = ((roughness_47 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_49), 0.0, 1.0)) * (1.5 + roughness_47))
   * 
    (((tmpvar_53 * tmpvar_53) * (a2_46 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_61;
  tmpvar_61 = clamp (specularTerm_45, 0.0, 100.0);
  specularTerm_45 = tmpvar_61;
  surfaceReduction_44 = (1.0 - ((roughness_47 * perceptualRoughness_48) * 0.28));
  mediump float x_62;
  x_62 = (1.0 - tmpvar_54);
  mediump vec3 tmpvar_63;
  tmpvar_63 = mix (tmpvar_38, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_39)
  ), 0.0, 1.0)), vec3(((x_62 * x_62) * (x_62 * x_62))));
  highp vec3 tmpvar_64;
  tmpvar_64 = (((
    (diffColor_42 + (tmpvar_61 * tmpvar_38))
   * tmpvar_3) * tmpvar_51) + ((surfaceReduction_44 * tmpvar_28) * tmpvar_63));
  color_43 = tmpvar_64;
  mediump vec4 tmpvar_65;
  tmpvar_65.w = 1.0;
  tmpvar_65.xyz = color_43;
  c_34.xyz = tmpvar_65.xyz;
  c_34.w = alpha_41;
  c_5 = c_34;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  mediump vec3 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_11.xyzz * normal_11.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = (x1_12 + (unity_SHC.xyz * (
    (normal_11.x * normal_11.x)
   - 
    (normal_11.y * normal_11.y)
  )));
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = normalWorld_28;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, tmpvar_29);
  x_30.y = dot (unity_SHAg, tmpvar_29);
  x_30.z = dot (unity_SHAb, tmpvar_29);
  mediump vec4 hdr_31;
  hdr_31 = tmpvar_2;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_32.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_33;
  tmpvar_33 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_32.xyz, tmpvar_32.w);
  mediump vec4 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  lowp vec3 tmpvar_35;
  mediump vec4 c_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_38;
  mediump vec3 albedo_39;
  albedo_39 = tmpvar_11;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_39, vec3(tmpvar_6));
  mediump float tmpvar_41;
  tmpvar_41 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_38 = (albedo_39 * tmpvar_41);
  tmpvar_35 = tmpvar_38;
  mediump vec3 diffColor_42;
  diffColor_42 = tmpvar_35;
  mediump float alpha_43;
  alpha_43 = tmpvar_13;
  tmpvar_35 = diffColor_42;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_35;
  mediump vec3 color_45;
  mediump vec2 rlPow4AndFresnelTerm_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (dot (tmpvar_37, tmpvar_4), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (dot (tmpvar_37, worldViewDir_8), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  highp vec2 tmpvar_51;
  tmpvar_51.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_37, worldViewDir_8) * tmpvar_37)
  )), tmpvar_4);
  tmpvar_51.y = (1.0 - tmpvar_49);
  highp vec2 tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * (tmpvar_51 * tmpvar_51));
  rlPow4AndFresnelTerm_46 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = rlPow4AndFresnelTerm_46.x;
  mediump float specular_54;
  highp float smoothness_55;
  smoothness_55 = tmpvar_7;
  highp vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_53;
  tmpvar_56.y = (1.0 - smoothness_55);
  highp float tmpvar_57;
  tmpvar_57 = (texture2D (unity_NHxRoughness, tmpvar_56).w * 16.0);
  specular_54 = tmpvar_57;
  color_45 = ((diffColor_44 + (specular_54 * tmpvar_40)) * (tmpvar_3 * tmpvar_47));
  color_45 = (color_45 + ((
    max (((1.055 * pow (
      max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_30))
    , vec3(0.4166667, 0.4166667, 0.4166667))) - 0.055), vec3(0.0, 0.0, 0.0))
   * diffColor_44) + (
    ((hdr_31.x * ((hdr_31.w * 
      (tmpvar_34.w - 1.0)
    ) + 1.0)) * tmpvar_34.xyz)
   * 
    mix (tmpvar_40, vec3(clamp ((tmpvar_7 + (1.0 - tmpvar_41)), 0.0, 1.0)), rlPow4AndFresnelTerm_46.yyy)
  )));
  mediump vec4 tmpvar_58;
  tmpvar_58.w = 1.0;
  tmpvar_58.xyz = color_45;
  c_36.xyz = tmpvar_58.xyz;
  c_36.w = alpha_43;
  c_5 = c_36;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  mediump vec3 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_11.xyzz * normal_11.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = (x1_12 + (unity_SHC.xyz * (
    (normal_11.x * normal_11.x)
   - 
    (normal_11.y * normal_11.y)
  )));
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_29;
  mediump vec3 tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = normalWorld_28;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_31);
  x_32.y = dot (unity_SHAg, tmpvar_31);
  x_32.z = dot (unity_SHAb, tmpvar_31);
  tmpvar_30 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_32)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_33;
  hdr_33 = tmpvar_2;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_34.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_35;
  tmpvar_35 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_34.xyz, tmpvar_34.w);
  mediump vec4 tmpvar_36;
  tmpvar_36 = tmpvar_35;
  tmpvar_29 = ((hdr_33.x * (
    (hdr_33.w * (tmpvar_36.w - 1.0))
   + 1.0)) * tmpvar_36.xyz);
  lowp vec3 tmpvar_37;
  mediump vec4 c_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_40;
  mediump vec3 albedo_41;
  albedo_41 = tmpvar_11;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_41, vec3(tmpvar_6));
  mediump float tmpvar_43;
  tmpvar_43 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_40 = (albedo_41 * tmpvar_43);
  tmpvar_37 = tmpvar_40;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_37;
  mediump float alpha_45;
  alpha_45 = tmpvar_13;
  tmpvar_37 = diffColor_44;
  mediump vec3 diffColor_46;
  diffColor_46 = tmpvar_37;
  mediump vec3 color_47;
  mediump float surfaceReduction_48;
  highp float specularTerm_49;
  highp float a2_50;
  mediump float roughness_51;
  mediump float perceptualRoughness_52;
  highp vec3 tmpvar_53;
  highp vec3 inVec_54;
  inVec_54 = (tmpvar_4 + worldViewDir_8);
  tmpvar_53 = (inVec_54 * inversesqrt(max (0.001, 
    dot (inVec_54, inVec_54)
  )));
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_39, tmpvar_4), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_39, tmpvar_53), 0.0, 1.0);
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_39, worldViewDir_8), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  highp float tmpvar_60;
  highp float smoothness_61;
  smoothness_61 = tmpvar_7;
  tmpvar_60 = (1.0 - smoothness_61);
  perceptualRoughness_52 = tmpvar_60;
  highp float tmpvar_62;
  highp float perceptualRoughness_63;
  perceptualRoughness_63 = perceptualRoughness_52;
  tmpvar_62 = (perceptualRoughness_63 * perceptualRoughness_63);
  roughness_51 = tmpvar_62;
  mediump float tmpvar_64;
  tmpvar_64 = (roughness_51 * roughness_51);
  a2_50 = tmpvar_64;
  specularTerm_49 = ((roughness_51 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_53), 0.0, 1.0)) * (1.5 + roughness_51))
   * 
    (((tmpvar_57 * tmpvar_57) * (a2_50 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_65;
  tmpvar_65 = clamp (specularTerm_49, 0.0, 100.0);
  specularTerm_49 = tmpvar_65;
  surfaceReduction_48 = (1.0 - ((roughness_51 * perceptualRoughness_52) * 0.28));
  mediump float x_66;
  x_66 = (1.0 - tmpvar_58);
  mediump vec3 tmpvar_67;
  tmpvar_67 = mix (tmpvar_42, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_43)
  ), 0.0, 1.0)), vec3(((x_66 * x_66) * (x_66 * x_66))));
  highp vec3 tmpvar_68;
  tmpvar_68 = (((
    ((diffColor_46 + (tmpvar_65 * tmpvar_42)) * tmpvar_3)
   * tmpvar_55) + (tmpvar_30 * diffColor_46)) + ((surfaceReduction_48 * tmpvar_29) * tmpvar_67));
  color_47 = tmpvar_68;
  mediump vec4 tmpvar_69;
  tmpvar_69.w = 1.0;
  tmpvar_69.xyz = color_47;
  c_38.xyz = tmpvar_69.xyz;
  c_38.w = alpha_45;
  c_5 = c_38;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = tmpvar_1.xyz;
  tmpvar_3 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_WorldToObject[0].xyz;
  tmpvar_9[1] = unity_WorldToObject[1].xyz;
  tmpvar_9[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_glesNormal * tmpvar_9));
  mediump vec3 normal_11;
  normal_11 = tmpvar_10;
  mediump vec3 x1_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal_11.xyzz * normal_11.yzzx);
  x1_12.x = dot (unity_SHBr, tmpvar_13);
  x1_12.y = dot (unity_SHBg, tmpvar_13);
  x1_12.z = dot (unity_SHBb, tmpvar_13);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_10;
  xlv_TEXCOORD2 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD3 = o_5;
  xlv_TEXCOORD4 = (x1_12 + (unity_SHC.xyz * (
    (normal_11.x * normal_11.x)
   - 
    (normal_11.y * normal_11.y)
  )));
  xlv_TEXCOORD6 = tmpvar_2;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_29;
  mediump vec3 tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = normalWorld_28;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_31);
  x_32.y = dot (unity_SHAg, tmpvar_31);
  x_32.z = dot (unity_SHAb, tmpvar_31);
  tmpvar_30 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_32)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_33;
  hdr_33 = tmpvar_2;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_34.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_35;
  tmpvar_35 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_34.xyz, tmpvar_34.w);
  mediump vec4 tmpvar_36;
  tmpvar_36 = tmpvar_35;
  tmpvar_29 = ((hdr_33.x * (
    (hdr_33.w * (tmpvar_36.w - 1.0))
   + 1.0)) * tmpvar_36.xyz);
  lowp vec3 tmpvar_37;
  mediump vec4 c_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_40;
  mediump vec3 albedo_41;
  albedo_41 = tmpvar_11;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_41, vec3(tmpvar_6));
  mediump float tmpvar_43;
  tmpvar_43 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_40 = (albedo_41 * tmpvar_43);
  tmpvar_37 = tmpvar_40;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_37;
  mediump float alpha_45;
  alpha_45 = tmpvar_13;
  tmpvar_37 = diffColor_44;
  mediump vec3 diffColor_46;
  diffColor_46 = tmpvar_37;
  mediump vec3 color_47;
  mediump float surfaceReduction_48;
  highp float specularTerm_49;
  highp float a2_50;
  mediump float roughness_51;
  mediump float perceptualRoughness_52;
  highp vec3 tmpvar_53;
  highp vec3 inVec_54;
  inVec_54 = (tmpvar_4 + worldViewDir_8);
  tmpvar_53 = (inVec_54 * inversesqrt(max (0.001, 
    dot (inVec_54, inVec_54)
  )));
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_39, tmpvar_4), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_39, tmpvar_53), 0.0, 1.0);
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_39, worldViewDir_8), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  highp float tmpvar_60;
  highp float smoothness_61;
  smoothness_61 = tmpvar_7;
  tmpvar_60 = (1.0 - smoothness_61);
  perceptualRoughness_52 = tmpvar_60;
  highp float tmpvar_62;
  highp float perceptualRoughness_63;
  perceptualRoughness_63 = perceptualRoughness_52;
  tmpvar_62 = (perceptualRoughness_63 * perceptualRoughness_63);
  roughness_51 = tmpvar_62;
  mediump float tmpvar_64;
  tmpvar_64 = (roughness_51 * roughness_51);
  a2_50 = tmpvar_64;
  specularTerm_49 = ((roughness_51 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_53), 0.0, 1.0)) * (1.5 + roughness_51))
   * 
    (((tmpvar_57 * tmpvar_57) * (a2_50 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_65;
  tmpvar_65 = clamp (specularTerm_49, 0.0, 100.0);
  specularTerm_49 = tmpvar_65;
  surfaceReduction_48 = (1.0 - ((roughness_51 * perceptualRoughness_52) * 0.28));
  mediump float x_66;
  x_66 = (1.0 - tmpvar_58);
  mediump vec3 tmpvar_67;
  tmpvar_67 = mix (tmpvar_42, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_43)
  ), 0.0, 1.0)), vec3(((x_66 * x_66) * (x_66 * x_66))));
  highp vec3 tmpvar_68;
  tmpvar_68 = (((
    ((diffColor_46 + (tmpvar_65 * tmpvar_42)) * tmpvar_3)
   * tmpvar_55) + (tmpvar_30 * diffColor_46)) + ((surfaceReduction_48 * tmpvar_29) * tmpvar_67));
  color_47 = tmpvar_68;
  mediump vec4 tmpvar_69;
  tmpvar_69.w = 1.0;
  tmpvar_69.xyz = color_47;
  c_38.xyz = tmpvar_69.xyz;
  c_38.w = alpha_45;
  c_5 = c_38;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  mediump vec3 normal_27;
  normal_27 = tmpvar_12;
  mediump vec3 ambient_28;
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_27.xyzz * normal_27.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  ambient_28 = ((tmpvar_2 * (
    (tmpvar_2 * ((tmpvar_2 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_29 + (unity_SHC.xyz * 
    ((normal_27.x * normal_27.x) - (normal_27.y * normal_27.y))
  )));
  tmpvar_2 = ambient_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = ambient_28;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec4 tmpvar_29;
  tmpvar_29.w = 1.0;
  tmpvar_29.xyz = normalWorld_28;
  mediump vec3 x_30;
  x_30.x = dot (unity_SHAr, tmpvar_29);
  x_30.y = dot (unity_SHAg, tmpvar_29);
  x_30.z = dot (unity_SHAb, tmpvar_29);
  mediump vec4 hdr_31;
  hdr_31 = tmpvar_2;
  mediump vec4 tmpvar_32;
  tmpvar_32.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_32.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_33;
  tmpvar_33 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_32.xyz, tmpvar_32.w);
  mediump vec4 tmpvar_34;
  tmpvar_34 = tmpvar_33;
  lowp vec3 tmpvar_35;
  mediump vec4 c_36;
  highp vec3 tmpvar_37;
  tmpvar_37 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_38;
  mediump vec3 albedo_39;
  albedo_39 = tmpvar_11;
  mediump vec3 tmpvar_40;
  tmpvar_40 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_39, vec3(tmpvar_6));
  mediump float tmpvar_41;
  tmpvar_41 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_38 = (albedo_39 * tmpvar_41);
  tmpvar_35 = tmpvar_38;
  mediump vec3 diffColor_42;
  diffColor_42 = tmpvar_35;
  mediump float alpha_43;
  alpha_43 = tmpvar_13;
  tmpvar_35 = diffColor_42;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_35;
  mediump vec3 color_45;
  mediump vec2 rlPow4AndFresnelTerm_46;
  mediump float tmpvar_47;
  highp float tmpvar_48;
  tmpvar_48 = clamp (dot (tmpvar_37, tmpvar_4), 0.0, 1.0);
  tmpvar_47 = tmpvar_48;
  mediump float tmpvar_49;
  highp float tmpvar_50;
  tmpvar_50 = clamp (dot (tmpvar_37, worldViewDir_8), 0.0, 1.0);
  tmpvar_49 = tmpvar_50;
  highp vec2 tmpvar_51;
  tmpvar_51.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_37, worldViewDir_8) * tmpvar_37)
  )), tmpvar_4);
  tmpvar_51.y = (1.0 - tmpvar_49);
  highp vec2 tmpvar_52;
  tmpvar_52 = ((tmpvar_51 * tmpvar_51) * (tmpvar_51 * tmpvar_51));
  rlPow4AndFresnelTerm_46 = tmpvar_52;
  mediump float tmpvar_53;
  tmpvar_53 = rlPow4AndFresnelTerm_46.x;
  mediump float specular_54;
  highp float smoothness_55;
  smoothness_55 = tmpvar_7;
  highp vec2 tmpvar_56;
  tmpvar_56.x = tmpvar_53;
  tmpvar_56.y = (1.0 - smoothness_55);
  highp float tmpvar_57;
  tmpvar_57 = (texture2D (unity_NHxRoughness, tmpvar_56).w * 16.0);
  specular_54 = tmpvar_57;
  color_45 = ((diffColor_44 + (specular_54 * tmpvar_40)) * (tmpvar_3 * tmpvar_47));
  color_45 = (color_45 + ((
    max (((1.055 * pow (
      max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_30))
    , vec3(0.4166667, 0.4166667, 0.4166667))) - 0.055), vec3(0.0, 0.0, 0.0))
   * diffColor_44) + (
    ((hdr_31.x * ((hdr_31.w * 
      (tmpvar_34.w - 1.0)
    ) + 1.0)) * tmpvar_34.xyz)
   * 
    mix (tmpvar_40, vec3(clamp ((tmpvar_7 + (1.0 - tmpvar_41)), 0.0, 1.0)), rlPow4AndFresnelTerm_46.yyy)
  )));
  mediump vec4 tmpvar_58;
  tmpvar_58.w = 1.0;
  tmpvar_58.xyz = color_45;
  c_36.xyz = tmpvar_58.xyz;
  c_36.w = alpha_43;
  c_5 = c_36;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  mediump vec3 normal_27;
  normal_27 = tmpvar_12;
  mediump vec3 ambient_28;
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_27.xyzz * normal_27.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  ambient_28 = ((tmpvar_2 * (
    (tmpvar_2 * ((tmpvar_2 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_29 + (unity_SHC.xyz * 
    ((normal_27.x * normal_27.x) - (normal_27.y * normal_27.y))
  )));
  tmpvar_2 = ambient_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = ambient_28;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_29;
  mediump vec3 tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = normalWorld_28;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_31);
  x_32.y = dot (unity_SHAg, tmpvar_31);
  x_32.z = dot (unity_SHAb, tmpvar_31);
  tmpvar_30 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_32)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_33;
  hdr_33 = tmpvar_2;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_34.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_35;
  tmpvar_35 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_34.xyz, tmpvar_34.w);
  mediump vec4 tmpvar_36;
  tmpvar_36 = tmpvar_35;
  tmpvar_29 = ((hdr_33.x * (
    (hdr_33.w * (tmpvar_36.w - 1.0))
   + 1.0)) * tmpvar_36.xyz);
  lowp vec3 tmpvar_37;
  mediump vec4 c_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_40;
  mediump vec3 albedo_41;
  albedo_41 = tmpvar_11;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_41, vec3(tmpvar_6));
  mediump float tmpvar_43;
  tmpvar_43 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_40 = (albedo_41 * tmpvar_43);
  tmpvar_37 = tmpvar_40;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_37;
  mediump float alpha_45;
  alpha_45 = tmpvar_13;
  tmpvar_37 = diffColor_44;
  mediump vec3 diffColor_46;
  diffColor_46 = tmpvar_37;
  mediump vec3 color_47;
  mediump float surfaceReduction_48;
  highp float specularTerm_49;
  highp float a2_50;
  mediump float roughness_51;
  mediump float perceptualRoughness_52;
  highp vec3 tmpvar_53;
  highp vec3 inVec_54;
  inVec_54 = (tmpvar_4 + worldViewDir_8);
  tmpvar_53 = (inVec_54 * inversesqrt(max (0.001, 
    dot (inVec_54, inVec_54)
  )));
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_39, tmpvar_4), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_39, tmpvar_53), 0.0, 1.0);
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_39, worldViewDir_8), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  highp float tmpvar_60;
  highp float smoothness_61;
  smoothness_61 = tmpvar_7;
  tmpvar_60 = (1.0 - smoothness_61);
  perceptualRoughness_52 = tmpvar_60;
  highp float tmpvar_62;
  highp float perceptualRoughness_63;
  perceptualRoughness_63 = perceptualRoughness_52;
  tmpvar_62 = (perceptualRoughness_63 * perceptualRoughness_63);
  roughness_51 = tmpvar_62;
  mediump float tmpvar_64;
  tmpvar_64 = (roughness_51 * roughness_51);
  a2_50 = tmpvar_64;
  specularTerm_49 = ((roughness_51 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_53), 0.0, 1.0)) * (1.5 + roughness_51))
   * 
    (((tmpvar_57 * tmpvar_57) * (a2_50 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_65;
  tmpvar_65 = clamp (specularTerm_49, 0.0, 100.0);
  specularTerm_49 = tmpvar_65;
  surfaceReduction_48 = (1.0 - ((roughness_51 * perceptualRoughness_52) * 0.28));
  mediump float x_66;
  x_66 = (1.0 - tmpvar_58);
  mediump vec3 tmpvar_67;
  tmpvar_67 = mix (tmpvar_42, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_43)
  ), 0.0, 1.0)), vec3(((x_66 * x_66) * (x_66 * x_66))));
  highp vec3 tmpvar_68;
  tmpvar_68 = (((
    ((diffColor_46 + (tmpvar_65 * tmpvar_42)) * tmpvar_3)
   * tmpvar_55) + (tmpvar_30 * diffColor_46)) + ((surfaceReduction_48 * tmpvar_29) * tmpvar_67));
  color_47 = tmpvar_68;
  mediump vec4 tmpvar_69;
  tmpvar_69.w = 1.0;
  tmpvar_69.xyz = color_47;
  c_38.xyz = tmpvar_69.xyz;
  c_38.w = alpha_45;
  c_5 = c_38;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform mediump vec4 unity_4LightAtten0;
uniform mediump vec4 unity_LightColor[8];
uniform mediump vec4 unity_SHBr;
uniform mediump vec4 unity_SHBg;
uniform mediump vec4 unity_SHBb;
uniform mediump vec4 unity_SHC;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  mediump vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = tmpvar_1.xyz;
  tmpvar_4 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_4 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_4.zw;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_1.xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_11;
  tmpvar_11[0] = unity_WorldToObject[0].xyz;
  tmpvar_11[1] = unity_WorldToObject[1].xyz;
  tmpvar_11[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize((_glesNormal * tmpvar_11));
  highp vec3 lightColor0_13;
  lightColor0_13 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_14;
  lightColor1_14 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_15;
  lightColor2_15 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_16;
  lightColor3_16 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_17;
  lightAttenSq_17 = unity_4LightAtten0;
  highp vec3 col_18;
  highp vec4 ndotl_19;
  highp vec4 lengthSq_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosX0 - tmpvar_10.x);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosY0 - tmpvar_10.y);
  highp vec4 tmpvar_23;
  tmpvar_23 = (unity_4LightPosZ0 - tmpvar_10.z);
  lengthSq_20 = (tmpvar_21 * tmpvar_21);
  lengthSq_20 = (lengthSq_20 + (tmpvar_22 * tmpvar_22));
  lengthSq_20 = (lengthSq_20 + (tmpvar_23 * tmpvar_23));
  highp vec4 tmpvar_24;
  tmpvar_24 = max (lengthSq_20, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_20 = tmpvar_24;
  ndotl_19 = (tmpvar_21 * tmpvar_12.x);
  ndotl_19 = (ndotl_19 + (tmpvar_22 * tmpvar_12.y));
  ndotl_19 = (ndotl_19 + (tmpvar_23 * tmpvar_12.z));
  highp vec4 tmpvar_25;
  tmpvar_25 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_19 * inversesqrt(tmpvar_24)));
  ndotl_19 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_25 * (1.0/((1.0 + 
    (tmpvar_24 * lightAttenSq_17)
  ))));
  col_18 = (lightColor0_13 * tmpvar_26.x);
  col_18 = (col_18 + (lightColor1_14 * tmpvar_26.y));
  col_18 = (col_18 + (lightColor2_15 * tmpvar_26.z));
  col_18 = (col_18 + (lightColor3_16 * tmpvar_26.w));
  tmpvar_2 = col_18;
  mediump vec3 normal_27;
  normal_27 = tmpvar_12;
  mediump vec3 ambient_28;
  mediump vec3 x1_29;
  mediump vec4 tmpvar_30;
  tmpvar_30 = (normal_27.xyzz * normal_27.yzzx);
  x1_29.x = dot (unity_SHBr, tmpvar_30);
  x1_29.y = dot (unity_SHBg, tmpvar_30);
  x1_29.z = dot (unity_SHBb, tmpvar_30);
  ambient_28 = ((tmpvar_2 * (
    (tmpvar_2 * ((tmpvar_2 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_29 + (unity_SHC.xyz * 
    ((normal_27.x * normal_27.x) - (normal_27.y * normal_27.y))
  )));
  tmpvar_2 = ambient_28;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_9));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_10;
  xlv_TEXCOORD3 = o_6;
  xlv_TEXCOORD4 = ambient_28;
  xlv_TEXCOORD6 = tmpvar_3;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_shader_texture_lod : enable
lowp vec4 impl_low_textureCubeLodEXT(lowp samplerCube sampler, highp vec3 coord, mediump float lod)
{
#if defined(GL_EXT_shader_texture_lod)
	return textureCubeLodEXT(sampler, coord, lod);
#else
	return textureCube(sampler, coord, lod);
#endif
}

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  lowp vec4 c_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD2));
  lowp vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  highp vec4 ase_screenPosNorm12_14;
  tmpvar_11 = _Color2.xyz;
  highp vec4 tmpvar_15;
  tmpvar_15 = (xlv_TEXCOORD3 / xlv_TEXCOORD3.w);
  ase_screenPosNorm12_14.xyw = tmpvar_15.xyw;
  ase_screenPosNorm12_14.z = ((tmpvar_15.z * 0.5) + 0.5);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD3);
  highp float z_17;
  z_17 = tmpvar_16.x;
  highp float tmpvar_18;
  tmpvar_18 = abs(((
    (1.0/(((_ZBufferParams.z * z_17) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_14.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_19;
  tmpvar_19 = clamp ((1.0 + (
    (-2.64 - (tmpvar_18 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_20;
  tmpvar_20 = clamp ((1.0 + (
    (-2.64 - tmpvar_18)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_21;
  tmpvar_21 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_TextureSample0, tmpvar_21);
  tmpvar_12 = ((tmpvar_19 * _Color1) + ((tmpvar_20 * _Color0) * (tmpvar_22 * _fadeColor))).xyz;
  tmpvar_13 = _opacity;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_9;
  tmpvar_1 = worldViewDir_8;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_23;
  Normal_23 = xlv_TEXCOORD1;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  highp float smoothness_26;
  smoothness_26 = tmpvar_7;
  tmpvar_25 = (1.0 - smoothness_26);
  tmpvar_24 = tmpvar_25;
  mediump vec3 I_27;
  I_27 = -(tmpvar_1);
  mediump vec3 normalWorld_28;
  normalWorld_28 = xlv_TEXCOORD1;
  mediump vec3 tmpvar_29;
  mediump vec3 tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = normalWorld_28;
  mediump vec3 x_32;
  x_32.x = dot (unity_SHAr, tmpvar_31);
  x_32.y = dot (unity_SHAg, tmpvar_31);
  x_32.z = dot (unity_SHAb, tmpvar_31);
  tmpvar_30 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD4 + x_32)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_33;
  hdr_33 = tmpvar_2;
  mediump vec4 tmpvar_34;
  tmpvar_34.xyz = (I_27 - (2.0 * (
    dot (Normal_23, I_27)
   * Normal_23)));
  tmpvar_34.w = ((tmpvar_24 * (1.7 - 
    (0.7 * tmpvar_24)
  )) * 6.0);
  lowp vec4 tmpvar_35;
  tmpvar_35 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_34.xyz, tmpvar_34.w);
  mediump vec4 tmpvar_36;
  tmpvar_36 = tmpvar_35;
  tmpvar_29 = ((hdr_33.x * (
    (hdr_33.w * (tmpvar_36.w - 1.0))
   + 1.0)) * tmpvar_36.xyz);
  lowp vec3 tmpvar_37;
  mediump vec4 c_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = normalize(xlv_TEXCOORD1);
  mediump vec3 tmpvar_40;
  mediump vec3 albedo_41;
  albedo_41 = tmpvar_11;
  mediump vec3 tmpvar_42;
  tmpvar_42 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_41, vec3(tmpvar_6));
  mediump float tmpvar_43;
  tmpvar_43 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_40 = (albedo_41 * tmpvar_43);
  tmpvar_37 = tmpvar_40;
  mediump vec3 diffColor_44;
  diffColor_44 = tmpvar_37;
  mediump float alpha_45;
  alpha_45 = tmpvar_13;
  tmpvar_37 = diffColor_44;
  mediump vec3 diffColor_46;
  diffColor_46 = tmpvar_37;
  mediump vec3 color_47;
  mediump float surfaceReduction_48;
  highp float specularTerm_49;
  highp float a2_50;
  mediump float roughness_51;
  mediump float perceptualRoughness_52;
  highp vec3 tmpvar_53;
  highp vec3 inVec_54;
  inVec_54 = (tmpvar_4 + worldViewDir_8);
  tmpvar_53 = (inVec_54 * inversesqrt(max (0.001, 
    dot (inVec_54, inVec_54)
  )));
  mediump float tmpvar_55;
  highp float tmpvar_56;
  tmpvar_56 = clamp (dot (tmpvar_39, tmpvar_4), 0.0, 1.0);
  tmpvar_55 = tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_39, tmpvar_53), 0.0, 1.0);
  mediump float tmpvar_58;
  highp float tmpvar_59;
  tmpvar_59 = clamp (dot (tmpvar_39, worldViewDir_8), 0.0, 1.0);
  tmpvar_58 = tmpvar_59;
  highp float tmpvar_60;
  highp float smoothness_61;
  smoothness_61 = tmpvar_7;
  tmpvar_60 = (1.0 - smoothness_61);
  perceptualRoughness_52 = tmpvar_60;
  highp float tmpvar_62;
  highp float perceptualRoughness_63;
  perceptualRoughness_63 = perceptualRoughness_52;
  tmpvar_62 = (perceptualRoughness_63 * perceptualRoughness_63);
  roughness_51 = tmpvar_62;
  mediump float tmpvar_64;
  tmpvar_64 = (roughness_51 * roughness_51);
  a2_50 = tmpvar_64;
  specularTerm_49 = ((roughness_51 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_53), 0.0, 1.0)) * (1.5 + roughness_51))
   * 
    (((tmpvar_57 * tmpvar_57) * (a2_50 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_65;
  tmpvar_65 = clamp (specularTerm_49, 0.0, 100.0);
  specularTerm_49 = tmpvar_65;
  surfaceReduction_48 = (1.0 - ((roughness_51 * perceptualRoughness_52) * 0.28));
  mediump float x_66;
  x_66 = (1.0 - tmpvar_58);
  mediump vec3 tmpvar_67;
  tmpvar_67 = mix (tmpvar_42, vec3(clamp ((tmpvar_7 + 
    (1.0 - tmpvar_43)
  ), 0.0, 1.0)), vec3(((x_66 * x_66) * (x_66 * x_66))));
  highp vec3 tmpvar_68;
  tmpvar_68 = (((
    ((diffColor_46 + (tmpvar_65 * tmpvar_42)) * tmpvar_3)
   * tmpvar_55) + (tmpvar_30 * diffColor_46)) + ((surfaceReduction_48 * tmpvar_29) * tmpvar_67));
  color_47 = tmpvar_68;
  mediump vec4 tmpvar_69;
  tmpvar_69.w = 1.0;
  tmpvar_69.xyz = color_47;
  c_38.xyz = tmpvar_69.xyz;
  c_38.w = alpha_45;
  c_5 = c_38;
  c_5.xyz = (c_5.xyz + tmpvar_12);
  gl_FragData[0] = c_5;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 120218
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  lowp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = _Color2.xyz;
  tmpvar_12 = _opacity;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_13).xyz;
  highp float tmpvar_14;
  tmpvar_14 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_15;
  mediump vec4 c_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_18;
  mediump vec3 albedo_19;
  albedo_19 = tmpvar_11;
  tmpvar_18 = (albedo_19 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_15 = tmpvar_18;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_15;
  mediump float alpha_21;
  alpha_21 = tmpvar_12;
  tmpvar_15 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_15;
  mediump vec2 rlPow4AndFresnelTerm_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (dot (tmpvar_17, tmpvar_2), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (tmpvar_17, worldViewDir_8), 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_17, worldViewDir_8) * tmpvar_17)
  )), tmpvar_2);
  tmpvar_28.y = (1.0 - tmpvar_26);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * (tmpvar_28 * tmpvar_28));
  rlPow4AndFresnelTerm_23 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = rlPow4AndFresnelTerm_23.x;
  mediump float specular_31;
  highp float smoothness_32;
  smoothness_32 = tmpvar_7;
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_30;
  tmpvar_33.y = (1.0 - smoothness_32);
  highp float tmpvar_34;
  tmpvar_34 = (texture2D (unity_NHxRoughness, tmpvar_33).w * 16.0);
  specular_31 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((diffColor_22 + (specular_31 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_19, vec3(tmpvar_6))
  )) * (tmpvar_1 * tmpvar_24));
  c_16.xyz = tmpvar_35.xyz;
  c_16.w = alpha_21;
  c_3 = c_16;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12).xyz;
  highp float tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_13;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_14;
  mediump vec4 c_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_17;
  mediump vec3 albedo_18;
  albedo_18 = tmpvar_10;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_18, vec3(tmpvar_6));
  tmpvar_17 = (albedo_18 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_14 = tmpvar_17;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_14;
  mediump float alpha_21;
  alpha_21 = tmpvar_11;
  tmpvar_14 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_14;
  mediump vec3 color_23;
  highp float specularTerm_24;
  highp float a2_25;
  mediump float roughness_26;
  mediump float perceptualRoughness_27;
  highp vec3 tmpvar_28;
  highp vec3 inVec_29;
  inVec_29 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_28 = (inVec_29 * inversesqrt(max (0.001, 
    dot (inVec_29, inVec_29)
  )));
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_16, tmpvar_2), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_16, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_33;
  highp float smoothness_34;
  smoothness_34 = tmpvar_7;
  tmpvar_33 = (1.0 - smoothness_34);
  perceptualRoughness_27 = tmpvar_33;
  highp float tmpvar_35;
  highp float perceptualRoughness_36;
  perceptualRoughness_36 = perceptualRoughness_27;
  tmpvar_35 = (perceptualRoughness_36 * perceptualRoughness_36);
  roughness_26 = tmpvar_35;
  mediump float tmpvar_37;
  tmpvar_37 = (roughness_26 * roughness_26);
  a2_25 = tmpvar_37;
  specularTerm_24 = ((roughness_26 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_28), 0.0, 1.0)) * (1.5 + roughness_26))
   * 
    (((tmpvar_32 * tmpvar_32) * (a2_25 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_38;
  tmpvar_38 = clamp (specularTerm_24, 0.0, 100.0);
  specularTerm_24 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((diffColor_22 + 
    (tmpvar_38 * tmpvar_19)
  ) * tmpvar_1) * tmpvar_30);
  color_23 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = color_23;
  c_15.xyz = tmpvar_40.xyz;
  c_15.w = alpha_21;
  c_3 = c_15;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12).xyz;
  highp float tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, vec2(dot (lightCoord_5, lightCoord_5))).w;
  atten_4 = tmpvar_13;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_14;
  mediump vec4 c_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_17;
  mediump vec3 albedo_18;
  albedo_18 = tmpvar_10;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_18, vec3(tmpvar_6));
  tmpvar_17 = (albedo_18 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_14 = tmpvar_17;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_14;
  mediump float alpha_21;
  alpha_21 = tmpvar_11;
  tmpvar_14 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_14;
  mediump vec3 color_23;
  highp float specularTerm_24;
  highp float a2_25;
  mediump float roughness_26;
  mediump float perceptualRoughness_27;
  highp vec3 tmpvar_28;
  highp vec3 inVec_29;
  inVec_29 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_28 = (inVec_29 * inversesqrt(max (0.001, 
    dot (inVec_29, inVec_29)
  )));
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_16, tmpvar_2), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_16, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_33;
  highp float smoothness_34;
  smoothness_34 = tmpvar_7;
  tmpvar_33 = (1.0 - smoothness_34);
  perceptualRoughness_27 = tmpvar_33;
  highp float tmpvar_35;
  highp float perceptualRoughness_36;
  perceptualRoughness_36 = perceptualRoughness_27;
  tmpvar_35 = (perceptualRoughness_36 * perceptualRoughness_36);
  roughness_26 = tmpvar_35;
  mediump float tmpvar_37;
  tmpvar_37 = (roughness_26 * roughness_26);
  a2_25 = tmpvar_37;
  specularTerm_24 = ((roughness_26 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_28), 0.0, 1.0)) * (1.5 + roughness_26))
   * 
    (((tmpvar_32 * tmpvar_32) * (a2_25 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_38;
  tmpvar_38 = clamp (specularTerm_24, 0.0, 100.0);
  specularTerm_24 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((diffColor_22 + 
    (tmpvar_38 * tmpvar_19)
  ) * tmpvar_1) * tmpvar_30);
  color_23 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = color_23;
  c_15.xyz = tmpvar_40.xyz;
  c_15.w = alpha_21;
  c_3 = c_15;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  highp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_9;
  worldViewDir_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  highp float tmpvar_13;
  tmpvar_13 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_12).xy).w;
  atten_4 = tmpvar_13;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_14;
  mediump vec4 c_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_17;
  mediump vec3 albedo_18;
  albedo_18 = tmpvar_10;
  tmpvar_17 = (albedo_18 * (0.7790837 - (tmpvar_5 * 0.7790837)));
  tmpvar_14 = tmpvar_17;
  mediump vec3 diffColor_19;
  diffColor_19 = tmpvar_14;
  mediump float alpha_20;
  alpha_20 = tmpvar_11;
  tmpvar_14 = diffColor_19;
  mediump vec3 diffColor_21;
  diffColor_21 = tmpvar_14;
  mediump vec2 rlPow4AndFresnelTerm_22;
  mediump float tmpvar_23;
  highp float tmpvar_24;
  tmpvar_24 = clamp (dot (tmpvar_16, tmpvar_2), 0.0, 1.0);
  tmpvar_23 = tmpvar_24;
  mediump float tmpvar_25;
  highp float tmpvar_26;
  tmpvar_26 = clamp (dot (tmpvar_16, worldViewDir_7), 0.0, 1.0);
  tmpvar_25 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27.x = dot ((worldViewDir_7 - (2.0 * 
    (dot (tmpvar_16, worldViewDir_7) * tmpvar_16)
  )), tmpvar_2);
  tmpvar_27.y = (1.0 - tmpvar_25);
  highp vec2 tmpvar_28;
  tmpvar_28 = ((tmpvar_27 * tmpvar_27) * (tmpvar_27 * tmpvar_27));
  rlPow4AndFresnelTerm_22 = tmpvar_28;
  mediump float tmpvar_29;
  tmpvar_29 = rlPow4AndFresnelTerm_22.x;
  mediump float specular_30;
  highp float smoothness_31;
  smoothness_31 = tmpvar_6;
  highp vec2 tmpvar_32;
  tmpvar_32.x = tmpvar_29;
  tmpvar_32.y = (1.0 - smoothness_31);
  highp float tmpvar_33;
  tmpvar_33 = (texture2D (unity_NHxRoughness, tmpvar_32).w * 16.0);
  specular_30 = tmpvar_33;
  mediump vec4 tmpvar_34;
  tmpvar_34.w = 1.0;
  tmpvar_34.xyz = ((diffColor_21 + (specular_30 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_18, vec3(tmpvar_5))
  )) * (tmpvar_1 * tmpvar_23));
  c_15.xyz = tmpvar_34.xyz;
  c_15.w = alpha_20;
  c_3 = c_15;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_9 = _Color2.xyz;
  tmpvar_10 = _opacity;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  highp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_11).xy).w;
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_13;
  mediump vec4 c_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_16;
  mediump vec3 albedo_17;
  albedo_17 = tmpvar_9;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_17, vec3(tmpvar_5));
  tmpvar_16 = (albedo_17 * (0.7790837 - (tmpvar_5 * 0.7790837)));
  tmpvar_13 = tmpvar_16;
  mediump vec3 diffColor_19;
  diffColor_19 = tmpvar_13;
  mediump float alpha_20;
  alpha_20 = tmpvar_10;
  tmpvar_13 = diffColor_19;
  mediump vec3 diffColor_21;
  diffColor_21 = tmpvar_13;
  mediump vec3 color_22;
  highp float specularTerm_23;
  highp float a2_24;
  mediump float roughness_25;
  mediump float perceptualRoughness_26;
  highp vec3 tmpvar_27;
  highp vec3 inVec_28;
  inVec_28 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_27 = (inVec_28 * inversesqrt(max (0.001, 
    dot (inVec_28, inVec_28)
  )));
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (dot (tmpvar_15, tmpvar_2), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_15, tmpvar_27), 0.0, 1.0);
  highp float tmpvar_32;
  highp float smoothness_33;
  smoothness_33 = tmpvar_6;
  tmpvar_32 = (1.0 - smoothness_33);
  perceptualRoughness_26 = tmpvar_32;
  highp float tmpvar_34;
  highp float perceptualRoughness_35;
  perceptualRoughness_35 = perceptualRoughness_26;
  tmpvar_34 = (perceptualRoughness_35 * perceptualRoughness_35);
  roughness_25 = tmpvar_34;
  mediump float tmpvar_36;
  tmpvar_36 = (roughness_25 * roughness_25);
  a2_24 = tmpvar_36;
  specularTerm_23 = ((roughness_25 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_27), 0.0, 1.0)) * (1.5 + roughness_25))
   * 
    (((tmpvar_31 * tmpvar_31) * (a2_24 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((diffColor_21 + 
    (tmpvar_37 * tmpvar_18)
  ) * tmpvar_1) * tmpvar_29);
  color_22 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = color_22;
  c_14.xyz = tmpvar_39.xyz;
  c_14.w = alpha_20;
  c_3 = c_14;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_9 = _Color2.xyz;
  tmpvar_10 = _opacity;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = xlv_TEXCOORD1;
  highp float tmpvar_12;
  tmpvar_12 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_11).xy).w;
  atten_4 = tmpvar_12;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_13;
  mediump vec4 c_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_16;
  mediump vec3 albedo_17;
  albedo_17 = tmpvar_9;
  mediump vec3 tmpvar_18;
  tmpvar_18 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_17, vec3(tmpvar_5));
  tmpvar_16 = (albedo_17 * (0.7790837 - (tmpvar_5 * 0.7790837)));
  tmpvar_13 = tmpvar_16;
  mediump vec3 diffColor_19;
  diffColor_19 = tmpvar_13;
  mediump float alpha_20;
  alpha_20 = tmpvar_10;
  tmpvar_13 = diffColor_19;
  mediump vec3 diffColor_21;
  diffColor_21 = tmpvar_13;
  mediump vec3 color_22;
  highp float specularTerm_23;
  highp float a2_24;
  mediump float roughness_25;
  mediump float perceptualRoughness_26;
  highp vec3 tmpvar_27;
  highp vec3 inVec_28;
  inVec_28 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_27 = (inVec_28 * inversesqrt(max (0.001, 
    dot (inVec_28, inVec_28)
  )));
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (dot (tmpvar_15, tmpvar_2), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_15, tmpvar_27), 0.0, 1.0);
  highp float tmpvar_32;
  highp float smoothness_33;
  smoothness_33 = tmpvar_6;
  tmpvar_32 = (1.0 - smoothness_33);
  perceptualRoughness_26 = tmpvar_32;
  highp float tmpvar_34;
  highp float perceptualRoughness_35;
  perceptualRoughness_35 = perceptualRoughness_26;
  tmpvar_34 = (perceptualRoughness_35 * perceptualRoughness_35);
  roughness_25 = tmpvar_34;
  mediump float tmpvar_36;
  tmpvar_36 = (roughness_25 * roughness_25);
  a2_24 = tmpvar_36;
  specularTerm_23 = ((roughness_25 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_27), 0.0, 1.0)) * (1.5 + roughness_25))
   * 
    (((tmpvar_31 * tmpvar_31) * (a2_24 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_37;
  tmpvar_37 = clamp (specularTerm_23, 0.0, 100.0);
  specularTerm_23 = tmpvar_37;
  highp vec3 tmpvar_38;
  tmpvar_38 = (((diffColor_21 + 
    (tmpvar_37 * tmpvar_18)
  ) * tmpvar_1) * tmpvar_29);
  color_22 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = color_22;
  c_14.xyz = tmpvar_39.xyz;
  c_14.w = alpha_20;
  c_3 = c_14;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  highp vec3 worldViewDir_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  worldViewDir_6 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  lowp vec3 tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_9 = _Color2.xyz;
  tmpvar_10 = _opacity;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  lowp vec3 tmpvar_11;
  mediump vec4 c_12;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_14;
  mediump vec3 albedo_15;
  albedo_15 = tmpvar_9;
  tmpvar_14 = (albedo_15 * (0.7790837 - (tmpvar_4 * 0.7790837)));
  tmpvar_11 = tmpvar_14;
  mediump vec3 diffColor_16;
  diffColor_16 = tmpvar_11;
  mediump float alpha_17;
  alpha_17 = tmpvar_10;
  tmpvar_11 = diffColor_16;
  mediump vec3 diffColor_18;
  diffColor_18 = tmpvar_11;
  mediump vec2 rlPow4AndFresnelTerm_19;
  mediump float tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = clamp (dot (tmpvar_13, tmpvar_2), 0.0, 1.0);
  tmpvar_20 = tmpvar_21;
  mediump float tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = clamp (dot (tmpvar_13, worldViewDir_6), 0.0, 1.0);
  tmpvar_22 = tmpvar_23;
  highp vec2 tmpvar_24;
  tmpvar_24.x = dot ((worldViewDir_6 - (2.0 * 
    (dot (tmpvar_13, worldViewDir_6) * tmpvar_13)
  )), tmpvar_2);
  tmpvar_24.y = (1.0 - tmpvar_22);
  highp vec2 tmpvar_25;
  tmpvar_25 = ((tmpvar_24 * tmpvar_24) * (tmpvar_24 * tmpvar_24));
  rlPow4AndFresnelTerm_19 = tmpvar_25;
  mediump float tmpvar_26;
  tmpvar_26 = rlPow4AndFresnelTerm_19.x;
  mediump float specular_27;
  highp float smoothness_28;
  smoothness_28 = tmpvar_5;
  highp vec2 tmpvar_29;
  tmpvar_29.x = tmpvar_26;
  tmpvar_29.y = (1.0 - smoothness_28);
  highp float tmpvar_30;
  tmpvar_30 = (texture2D (unity_NHxRoughness, tmpvar_29).w * 16.0);
  specular_27 = tmpvar_30;
  mediump vec4 tmpvar_31;
  tmpvar_31.w = 1.0;
  tmpvar_31.xyz = ((diffColor_18 + (specular_27 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_15, vec3(tmpvar_4))
  )) * (tmpvar_1 * tmpvar_20));
  c_12.xyz = tmpvar_31.xyz;
  c_12.w = alpha_17;
  c_3 = c_12;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = _Color2.xyz;
  tmpvar_9 = _opacity;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  lowp vec3 tmpvar_10;
  mediump vec4 c_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_13;
  mediump vec3 albedo_14;
  albedo_14 = tmpvar_8;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_14, vec3(tmpvar_4));
  tmpvar_13 = (albedo_14 * (0.7790837 - (tmpvar_4 * 0.7790837)));
  tmpvar_10 = tmpvar_13;
  mediump vec3 diffColor_16;
  diffColor_16 = tmpvar_10;
  mediump float alpha_17;
  alpha_17 = tmpvar_9;
  tmpvar_10 = diffColor_16;
  mediump vec3 diffColor_18;
  diffColor_18 = tmpvar_10;
  mediump vec3 color_19;
  highp float specularTerm_20;
  highp float a2_21;
  mediump float roughness_22;
  mediump float perceptualRoughness_23;
  highp vec3 tmpvar_24;
  highp vec3 inVec_25;
  inVec_25 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (tmpvar_12, tmpvar_2), 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_12, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_29;
  highp float smoothness_30;
  smoothness_30 = tmpvar_5;
  tmpvar_29 = (1.0 - smoothness_30);
  perceptualRoughness_23 = tmpvar_29;
  highp float tmpvar_31;
  highp float perceptualRoughness_32;
  perceptualRoughness_32 = perceptualRoughness_23;
  tmpvar_31 = (perceptualRoughness_32 * perceptualRoughness_32);
  roughness_22 = tmpvar_31;
  mediump float tmpvar_33;
  tmpvar_33 = (roughness_22 * roughness_22);
  a2_21 = tmpvar_33;
  specularTerm_20 = ((roughness_22 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_24), 0.0, 1.0)) * (1.5 + roughness_22))
   * 
    (((tmpvar_28 * tmpvar_28) * (a2_21 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_34;
  tmpvar_34 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = (((diffColor_18 + 
    (tmpvar_34 * tmpvar_15)
  ) * tmpvar_1) * tmpvar_26);
  color_19 = tmpvar_35;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = color_19;
  c_11.xyz = tmpvar_36.xyz;
  c_11.w = alpha_17;
  c_3 = c_11;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp vec3 lightDir_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  lightDir_6 = tmpvar_7;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_8 = _Color2.xyz;
  tmpvar_9 = _opacity;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_6;
  lowp vec3 tmpvar_10;
  mediump vec4 c_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_13;
  mediump vec3 albedo_14;
  albedo_14 = tmpvar_8;
  mediump vec3 tmpvar_15;
  tmpvar_15 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_14, vec3(tmpvar_4));
  tmpvar_13 = (albedo_14 * (0.7790837 - (tmpvar_4 * 0.7790837)));
  tmpvar_10 = tmpvar_13;
  mediump vec3 diffColor_16;
  diffColor_16 = tmpvar_10;
  mediump float alpha_17;
  alpha_17 = tmpvar_9;
  tmpvar_10 = diffColor_16;
  mediump vec3 diffColor_18;
  diffColor_18 = tmpvar_10;
  mediump vec3 color_19;
  highp float specularTerm_20;
  highp float a2_21;
  mediump float roughness_22;
  mediump float perceptualRoughness_23;
  highp vec3 tmpvar_24;
  highp vec3 inVec_25;
  inVec_25 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_24 = (inVec_25 * inversesqrt(max (0.001, 
    dot (inVec_25, inVec_25)
  )));
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (tmpvar_12, tmpvar_2), 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_12, tmpvar_24), 0.0, 1.0);
  highp float tmpvar_29;
  highp float smoothness_30;
  smoothness_30 = tmpvar_5;
  tmpvar_29 = (1.0 - smoothness_30);
  perceptualRoughness_23 = tmpvar_29;
  highp float tmpvar_31;
  highp float perceptualRoughness_32;
  perceptualRoughness_32 = perceptualRoughness_23;
  tmpvar_31 = (perceptualRoughness_32 * perceptualRoughness_32);
  roughness_22 = tmpvar_31;
  mediump float tmpvar_33;
  tmpvar_33 = (roughness_22 * roughness_22);
  a2_21 = tmpvar_33;
  specularTerm_20 = ((roughness_22 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_24), 0.0, 1.0)) * (1.5 + roughness_22))
   * 
    (((tmpvar_28 * tmpvar_28) * (a2_21 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_34;
  tmpvar_34 = clamp (specularTerm_20, 0.0, 100.0);
  specularTerm_20 = tmpvar_34;
  highp vec3 tmpvar_35;
  tmpvar_35 = (((diffColor_18 + 
    (tmpvar_34 * tmpvar_15)
  ) * tmpvar_1) * tmpvar_26);
  color_19 = tmpvar_35;
  mediump vec4 tmpvar_36;
  tmpvar_36.w = 1.0;
  tmpvar_36.xyz = color_19;
  c_11.xyz = tmpvar_36.xyz;
  c_11.w = alpha_17;
  c_3 = c_11;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  lowp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = _Color2.xyz;
  tmpvar_12 = _opacity;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_13);
  lowp float tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_14 = tmpvar_15.w;
  lowp float tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_16 = tmpvar_17.w;
  highp float tmpvar_18;
  tmpvar_18 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_14) * tmpvar_16);
  atten_4 = tmpvar_18;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_19;
  mediump vec4 c_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_22;
  mediump vec3 albedo_23;
  albedo_23 = tmpvar_11;
  tmpvar_22 = (albedo_23 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_19 = tmpvar_22;
  mediump vec3 diffColor_24;
  diffColor_24 = tmpvar_19;
  mediump float alpha_25;
  alpha_25 = tmpvar_12;
  tmpvar_19 = diffColor_24;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_19;
  mediump vec2 rlPow4AndFresnelTerm_27;
  mediump float tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = clamp (dot (tmpvar_21, tmpvar_2), 0.0, 1.0);
  tmpvar_28 = tmpvar_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_21, worldViewDir_8), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp vec2 tmpvar_32;
  tmpvar_32.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_21, worldViewDir_8) * tmpvar_21)
  )), tmpvar_2);
  tmpvar_32.y = (1.0 - tmpvar_30);
  highp vec2 tmpvar_33;
  tmpvar_33 = ((tmpvar_32 * tmpvar_32) * (tmpvar_32 * tmpvar_32));
  rlPow4AndFresnelTerm_27 = tmpvar_33;
  mediump float tmpvar_34;
  tmpvar_34 = rlPow4AndFresnelTerm_27.x;
  mediump float specular_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_7;
  highp vec2 tmpvar_37;
  tmpvar_37.x = tmpvar_34;
  tmpvar_37.y = (1.0 - smoothness_36);
  highp float tmpvar_38;
  tmpvar_38 = (texture2D (unity_NHxRoughness, tmpvar_37).w * 16.0);
  specular_35 = tmpvar_38;
  mediump vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = ((diffColor_26 + (specular_35 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_23, vec3(tmpvar_6))
  )) * (tmpvar_1 * tmpvar_28));
  c_20.xyz = tmpvar_39.xyz;
  c_20.w = alpha_25;
  c_3 = c_20;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12);
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_13 = tmpvar_14.w;
  lowp float tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_15 = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_13) * tmpvar_15);
  atten_4 = tmpvar_17;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_18;
  mediump vec4 c_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_21;
  mediump vec3 albedo_22;
  albedo_22 = tmpvar_10;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_22, vec3(tmpvar_6));
  tmpvar_21 = (albedo_22 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_18 = tmpvar_21;
  mediump vec3 diffColor_24;
  diffColor_24 = tmpvar_18;
  mediump float alpha_25;
  alpha_25 = tmpvar_11;
  tmpvar_18 = diffColor_24;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_18;
  mediump vec3 color_27;
  highp float specularTerm_28;
  highp float a2_29;
  mediump float roughness_30;
  mediump float perceptualRoughness_31;
  highp vec3 tmpvar_32;
  highp vec3 inVec_33;
  inVec_33 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (dot (tmpvar_20, tmpvar_2), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (dot (tmpvar_20, tmpvar_32), 0.0, 1.0);
  highp float tmpvar_37;
  highp float smoothness_38;
  smoothness_38 = tmpvar_7;
  tmpvar_37 = (1.0 - smoothness_38);
  perceptualRoughness_31 = tmpvar_37;
  highp float tmpvar_39;
  highp float perceptualRoughness_40;
  perceptualRoughness_40 = perceptualRoughness_31;
  tmpvar_39 = (perceptualRoughness_40 * perceptualRoughness_40);
  roughness_30 = tmpvar_39;
  mediump float tmpvar_41;
  tmpvar_41 = (roughness_30 * roughness_30);
  a2_29 = tmpvar_41;
  specularTerm_28 = ((roughness_30 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_32), 0.0, 1.0)) * (1.5 + roughness_30))
   * 
    (((tmpvar_36 * tmpvar_36) * (a2_29 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_28, 0.0, 100.0);
  specularTerm_28 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (((diffColor_26 + 
    (tmpvar_42 * tmpvar_23)
  ) * tmpvar_1) * tmpvar_34);
  color_27 = tmpvar_43;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = color_27;
  c_19.xyz = tmpvar_44.xyz;
  c_19.w = alpha_25;
  c_3 = c_19;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec4 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12);
  lowp float tmpvar_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_LightTexture0, ((lightCoord_5.xy / lightCoord_5.w) + 0.5));
  tmpvar_13 = tmpvar_14.w;
  lowp float tmpvar_15;
  highp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_LightTextureB0, vec2(dot (lightCoord_5.xyz, lightCoord_5.xyz)));
  tmpvar_15 = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((float(
    (lightCoord_5.z > 0.0)
  ) * tmpvar_13) * tmpvar_15);
  atten_4 = tmpvar_17;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_18;
  mediump vec4 c_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_21;
  mediump vec3 albedo_22;
  albedo_22 = tmpvar_10;
  mediump vec3 tmpvar_23;
  tmpvar_23 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_22, vec3(tmpvar_6));
  tmpvar_21 = (albedo_22 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_18 = tmpvar_21;
  mediump vec3 diffColor_24;
  diffColor_24 = tmpvar_18;
  mediump float alpha_25;
  alpha_25 = tmpvar_11;
  tmpvar_18 = diffColor_24;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_18;
  mediump vec3 color_27;
  highp float specularTerm_28;
  highp float a2_29;
  mediump float roughness_30;
  mediump float perceptualRoughness_31;
  highp vec3 tmpvar_32;
  highp vec3 inVec_33;
  inVec_33 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_32 = (inVec_33 * inversesqrt(max (0.001, 
    dot (inVec_33, inVec_33)
  )));
  mediump float tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (dot (tmpvar_20, tmpvar_2), 0.0, 1.0);
  tmpvar_34 = tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (dot (tmpvar_20, tmpvar_32), 0.0, 1.0);
  highp float tmpvar_37;
  highp float smoothness_38;
  smoothness_38 = tmpvar_7;
  tmpvar_37 = (1.0 - smoothness_38);
  perceptualRoughness_31 = tmpvar_37;
  highp float tmpvar_39;
  highp float perceptualRoughness_40;
  perceptualRoughness_40 = perceptualRoughness_31;
  tmpvar_39 = (perceptualRoughness_40 * perceptualRoughness_40);
  roughness_30 = tmpvar_39;
  mediump float tmpvar_41;
  tmpvar_41 = (roughness_30 * roughness_30);
  a2_29 = tmpvar_41;
  specularTerm_28 = ((roughness_30 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_32), 0.0, 1.0)) * (1.5 + roughness_30))
   * 
    (((tmpvar_36 * tmpvar_36) * (a2_29 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_42;
  tmpvar_42 = clamp (specularTerm_28, 0.0, 100.0);
  specularTerm_28 = tmpvar_42;
  highp vec3 tmpvar_43;
  tmpvar_43 = (((diffColor_26 + 
    (tmpvar_42 * tmpvar_23)
  ) * tmpvar_1) * tmpvar_34);
  color_27 = tmpvar_43;
  mediump vec4 tmpvar_44;
  tmpvar_44.w = 1.0;
  tmpvar_44.xyz = color_27;
  c_19.xyz = tmpvar_44.xyz;
  c_19.w = alpha_25;
  c_3 = c_19;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1));
  lowp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = _Color2.xyz;
  tmpvar_12 = _opacity;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_13).xyz;
  highp float tmpvar_14;
  tmpvar_14 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_14;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_15;
  mediump vec4 c_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_18;
  mediump vec3 albedo_19;
  albedo_19 = tmpvar_11;
  tmpvar_18 = (albedo_19 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_15 = tmpvar_18;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_15;
  mediump float alpha_21;
  alpha_21 = tmpvar_12;
  tmpvar_15 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_15;
  mediump vec2 rlPow4AndFresnelTerm_23;
  mediump float tmpvar_24;
  highp float tmpvar_25;
  tmpvar_25 = clamp (dot (tmpvar_17, tmpvar_2), 0.0, 1.0);
  tmpvar_24 = tmpvar_25;
  mediump float tmpvar_26;
  highp float tmpvar_27;
  tmpvar_27 = clamp (dot (tmpvar_17, worldViewDir_8), 0.0, 1.0);
  tmpvar_26 = tmpvar_27;
  highp vec2 tmpvar_28;
  tmpvar_28.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_17, worldViewDir_8) * tmpvar_17)
  )), tmpvar_2);
  tmpvar_28.y = (1.0 - tmpvar_26);
  highp vec2 tmpvar_29;
  tmpvar_29 = ((tmpvar_28 * tmpvar_28) * (tmpvar_28 * tmpvar_28));
  rlPow4AndFresnelTerm_23 = tmpvar_29;
  mediump float tmpvar_30;
  tmpvar_30 = rlPow4AndFresnelTerm_23.x;
  mediump float specular_31;
  highp float smoothness_32;
  smoothness_32 = tmpvar_7;
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_30;
  tmpvar_33.y = (1.0 - smoothness_32);
  highp float tmpvar_34;
  tmpvar_34 = (texture2D (unity_NHxRoughness, tmpvar_33).w * 16.0);
  specular_31 = tmpvar_34;
  mediump vec4 tmpvar_35;
  tmpvar_35.w = 1.0;
  tmpvar_35.xyz = ((diffColor_22 + (specular_31 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_19, vec3(tmpvar_6))
  )) * (tmpvar_1 * tmpvar_24));
  c_16.xyz = tmpvar_35.xyz;
  c_16.w = alpha_21;
  c_3 = c_16;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12).xyz;
  highp float tmpvar_13;
  tmpvar_13 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_13;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_14;
  mediump vec4 c_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_17;
  mediump vec3 albedo_18;
  albedo_18 = tmpvar_10;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_18, vec3(tmpvar_6));
  tmpvar_17 = (albedo_18 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_14 = tmpvar_17;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_14;
  mediump float alpha_21;
  alpha_21 = tmpvar_11;
  tmpvar_14 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_14;
  mediump vec3 color_23;
  highp float specularTerm_24;
  highp float a2_25;
  mediump float roughness_26;
  mediump float perceptualRoughness_27;
  highp vec3 tmpvar_28;
  highp vec3 inVec_29;
  inVec_29 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_28 = (inVec_29 * inversesqrt(max (0.001, 
    dot (inVec_29, inVec_29)
  )));
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_16, tmpvar_2), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_16, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_33;
  highp float smoothness_34;
  smoothness_34 = tmpvar_7;
  tmpvar_33 = (1.0 - smoothness_34);
  perceptualRoughness_27 = tmpvar_33;
  highp float tmpvar_35;
  highp float perceptualRoughness_36;
  perceptualRoughness_36 = perceptualRoughness_27;
  tmpvar_35 = (perceptualRoughness_36 * perceptualRoughness_36);
  roughness_26 = tmpvar_35;
  mediump float tmpvar_37;
  tmpvar_37 = (roughness_26 * roughness_26);
  a2_25 = tmpvar_37;
  specularTerm_24 = ((roughness_26 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_28), 0.0, 1.0)) * (1.5 + roughness_26))
   * 
    (((tmpvar_32 * tmpvar_32) * (a2_25 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_38;
  tmpvar_38 = clamp (specularTerm_24, 0.0, 100.0);
  specularTerm_24 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((diffColor_22 + 
    (tmpvar_38 * tmpvar_19)
  ) * tmpvar_1) * tmpvar_30);
  color_23 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = color_23;
  c_15.xyz = tmpvar_40.xyz;
  c_15.w = alpha_21;
  c_3 = c_15;
  gl_FragData[0] = c_3;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp mat4 unity_MatrixVP;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_WorldToObject[0].xyz;
  tmpvar_8[1] = unity_WorldToObject[1].xyz;
  tmpvar_8[2] = unity_WorldToObject[2].xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  xlv_TEXCOORD0 = normalize((_glesNormal * tmpvar_8));
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp samplerCube _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform highp sampler2D _LightTextureB0;
uniform mediump vec4 _Color2;
uniform mediump float _opacity;
varying highp vec3 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec4 c_3;
  lowp float atten_4;
  highp vec3 lightCoord_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD1));
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_10 = _Color2.xyz;
  tmpvar_11 = _opacity;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = xlv_TEXCOORD1;
  lightCoord_5 = (unity_WorldToLight * tmpvar_12).xyz;
  highp float tmpvar_13;
  tmpvar_13 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_5, lightCoord_5))).w * textureCube (_LightTexture0, lightCoord_5).w);
  atten_4 = tmpvar_13;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_4);
  lowp vec3 tmpvar_14;
  mediump vec4 c_15;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(xlv_TEXCOORD0);
  mediump vec3 tmpvar_17;
  mediump vec3 albedo_18;
  albedo_18 = tmpvar_10;
  mediump vec3 tmpvar_19;
  tmpvar_19 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_18, vec3(tmpvar_6));
  tmpvar_17 = (albedo_18 * (0.7790837 - (tmpvar_6 * 0.7790837)));
  tmpvar_14 = tmpvar_17;
  mediump vec3 diffColor_20;
  diffColor_20 = tmpvar_14;
  mediump float alpha_21;
  alpha_21 = tmpvar_11;
  tmpvar_14 = diffColor_20;
  mediump vec3 diffColor_22;
  diffColor_22 = tmpvar_14;
  mediump vec3 color_23;
  highp float specularTerm_24;
  highp float a2_25;
  mediump float roughness_26;
  mediump float perceptualRoughness_27;
  highp vec3 tmpvar_28;
  highp vec3 inVec_29;
  inVec_29 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD1)));
  tmpvar_28 = (inVec_29 * inversesqrt(max (0.001, 
    dot (inVec_29, inVec_29)
  )));
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_16, tmpvar_2), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_16, tmpvar_28), 0.0, 1.0);
  highp float tmpvar_33;
  highp float smoothness_34;
  smoothness_34 = tmpvar_7;
  tmpvar_33 = (1.0 - smoothness_34);
  perceptualRoughness_27 = tmpvar_33;
  highp float tmpvar_35;
  highp float perceptualRoughness_36;
  perceptualRoughness_36 = perceptualRoughness_27;
  tmpvar_35 = (perceptualRoughness_36 * perceptualRoughness_36);
  roughness_26 = tmpvar_35;
  mediump float tmpvar_37;
  tmpvar_37 = (roughness_26 * roughness_26);
  a2_25 = tmpvar_37;
  specularTerm_24 = ((roughness_26 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_28), 0.0, 1.0)) * (1.5 + roughness_26))
   * 
    (((tmpvar_32 * tmpvar_32) * (a2_25 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_38;
  tmpvar_38 = clamp (specularTerm_24, 0.0, 100.0);
  specularTerm_24 = tmpvar_38;
  highp vec3 tmpvar_39;
  tmpvar_39 = (((diffColor_22 + 
    (tmpvar_38 * tmpvar_19)
  ) * tmpvar_1) * tmpvar_30);
  color_23 = tmpvar_39;
  mediump vec4 tmpvar_40;
  tmpvar_40.w = 1.0;
  tmpvar_40.xyz = color_23;
  c_15.xyz = tmpvar_40.xyz;
  c_15.w = alpha_21;
  c_3 = c_15;
  gl_FragData[0] = c_3;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 136478
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 vertex_7;
  vertex_7 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_7.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_8;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_8 = 0.0001;
    } else {
      tmpvar_8 = 0.0;
    };
    vertex_7.z = tmpvar_8;
  };
  if (unity_MetaVertexControl.y) {
    vertex_7.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_9;
    if ((vertex_7.z > 0.0)) {
      tmpvar_9 = 0.0001;
    } else {
      tmpvar_9 = 0.0;
    };
    vertex_7.z = tmpvar_9;
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = vertex_7.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD2 / xlv_TEXCOORD2.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  highp float tmpvar_9;
  tmpvar_9 = abs(((
    (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_5.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_10;
  tmpvar_10 = clamp ((1.0 + (
    (-2.64 - (tmpvar_9 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 + (
    (-2.64 - tmpvar_9)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TextureSample0, tmpvar_12);
  tmpvar_4 = ((tmpvar_10 * _Color1) + ((tmpvar_11 * _Color0) * (tmpvar_13 * _fadeColor))).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_14;
  res_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = tmpvar_2;
    res_14.w = tmpvar_15.w;
    highp vec3 tmpvar_16;
    tmpvar_16 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_14.xyz = tmpvar_16;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_17;
    if (bool(unity_UseLinearSpace)) {
      emission_17 = tmpvar_4;
    } else {
      emission_17 = (tmpvar_4 * ((tmpvar_4 * 
        ((tmpvar_4 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = emission_17;
    res_14 = tmpvar_18;
  };
  tmpvar_1 = res_14;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 vertex_7;
  vertex_7 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_7.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_8;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_8 = 0.0001;
    } else {
      tmpvar_8 = 0.0;
    };
    vertex_7.z = tmpvar_8;
  };
  if (unity_MetaVertexControl.y) {
    vertex_7.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_9;
    if ((vertex_7.z > 0.0)) {
      tmpvar_9 = 0.0001;
    } else {
      tmpvar_9 = 0.0;
    };
    vertex_7.z = tmpvar_9;
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = vertex_7.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD2 / xlv_TEXCOORD2.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  highp float tmpvar_9;
  tmpvar_9 = abs(((
    (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_5.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_10;
  tmpvar_10 = clamp ((1.0 + (
    (-2.64 - (tmpvar_9 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 + (
    (-2.64 - tmpvar_9)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TextureSample0, tmpvar_12);
  tmpvar_4 = ((tmpvar_10 * _Color1) + ((tmpvar_11 * _Color0) * (tmpvar_13 * _fadeColor))).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_14;
  res_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = tmpvar_2;
    res_14.w = tmpvar_15.w;
    highp vec3 tmpvar_16;
    tmpvar_16 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_14.xyz = tmpvar_16;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_17;
    if (bool(unity_UseLinearSpace)) {
      emission_17 = tmpvar_4;
    } else {
      emission_17 = (tmpvar_4 * ((tmpvar_4 * 
        ((tmpvar_4 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = emission_17;
    res_14 = tmpvar_18;
  };
  tmpvar_1 = res_14;
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
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = tmpvar_1.xyz;
  tmpvar_2 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_3));
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  highp vec4 vertex_7;
  vertex_7 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_7.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_8;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_8 = 0.0001;
    } else {
      tmpvar_8 = 0.0;
    };
    vertex_7.z = tmpvar_8;
  };
  if (unity_MetaVertexControl.y) {
    vertex_7.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_9;
    if ((vertex_7.z > 0.0)) {
      tmpvar_9 = 0.0001;
    } else {
      tmpvar_9 = 0.0;
    };
    vertex_7.z = tmpvar_9;
  };
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = vertex_7.xyz;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_10));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD2 = o_4;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CustomDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform bvec4 unity_MetaFragmentControl;
uniform highp float unity_OneOverOutputBoost;
uniform highp float unity_MaxOutputValue;
uniform highp float unity_UseLinearSpace;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD2 / xlv_TEXCOORD2.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CustomDepthTexture, xlv_TEXCOORD2);
  highp float z_8;
  z_8 = tmpvar_7.x;
  highp float tmpvar_9;
  tmpvar_9 = abs(((
    (1.0/(((_ZBufferParams.z * z_8) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_5.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_10;
  tmpvar_10 = clamp ((1.0 + (
    (-2.64 - (tmpvar_9 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_11;
  tmpvar_11 = clamp ((1.0 + (
    (-2.64 - tmpvar_9)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TextureSample0, tmpvar_12);
  tmpvar_4 = ((tmpvar_10 * _Color1) + ((tmpvar_11 * _Color0) * (tmpvar_13 * _fadeColor))).xyz;
  tmpvar_2 = tmpvar_3;
  mediump vec4 res_14;
  res_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if (unity_MetaFragmentControl.x) {
    mediump vec4 tmpvar_15;
    tmpvar_15.w = 1.0;
    tmpvar_15.xyz = tmpvar_2;
    res_14.w = tmpvar_15.w;
    highp vec3 tmpvar_16;
    tmpvar_16 = clamp (pow (tmpvar_2, vec3(clamp (unity_OneOverOutputBoost, 0.0, 1.0))), vec3(0.0, 0.0, 0.0), vec3(unity_MaxOutputValue));
    res_14.xyz = tmpvar_16;
  };
  if (unity_MetaFragmentControl.y) {
    mediump vec3 emission_17;
    if (bool(unity_UseLinearSpace)) {
      emission_17 = tmpvar_4;
    } else {
      emission_17 = (tmpvar_4 * ((tmpvar_4 * 
        ((tmpvar_4 * 0.305306) + 0.6821711)
      ) + 0.01252288));
    };
    mediump vec4 tmpvar_18;
    tmpvar_18.w = 1.0;
    tmpvar_18.xyz = emission_17;
    res_14 = tmpvar_18;
  };
  tmpvar_1 = res_14;
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
CustomEditor "ASEMaterialInspector"
}