//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_DLC/DLCSKDLOutBallV1" {
Properties {
_Color0 ("Color 0", Color) = (0.754717,0.754717,0.754717,0)
_Color1 ("Color 1", Color) = (0.754717,0.754717,0.754717,0)
[Header(Refraction)] _ChromaticAberration ("Chromatic Aberration", Range(0, 0.3)) = 0.1
_depthFade ("depthFade", Vector) = (0,0,0,0)
_Color2 ("Color 2", Color) = (0,0,0,0)
_opacity ("opacity", Float) = 0
_depth ("depth", Float) = 0
_TextureSample0 ("Texture Sample 0", 2D) = "white" { }
_fadeColor ("fadeColor", Color) = (0,0,0,0)
_Fresnel ("Fresnel", Vector) = (0,1,5,0)
_TextureSample1 ("Texture Sample 1", 2D) = "white" { }
_rongjie ("rongjie", Range(0, 2)) = 1.132761
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
}
SubShader {
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 GrabPass {
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 44102
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec4 hdr_38;
  hdr_38 = tmpvar_2;
  mediump vec4 tmpvar_39;
  tmpvar_39.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_39.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_40;
  tmpvar_40 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_39.xyz, tmpvar_39.w);
  mediump vec4 tmpvar_41;
  tmpvar_41 = tmpvar_40;
  lowp vec3 tmpvar_42;
  mediump vec4 c_43;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(tmpvar_32);
  mediump vec3 tmpvar_45;
  mediump vec3 albedo_46;
  albedo_46 = tmpvar_16;
  mediump vec3 tmpvar_47;
  tmpvar_47 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_46, vec3(tmpvar_7));
  mediump float tmpvar_48;
  tmpvar_48 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_45 = (albedo_46 * tmpvar_48);
  tmpvar_42 = tmpvar_45;
  mediump vec3 diffColor_49;
  diffColor_49 = tmpvar_42;
  mediump float alpha_50;
  alpha_50 = tmpvar_19;
  diffColor_49 = (diffColor_49 * alpha_50);
  tmpvar_42 = diffColor_49;
  mediump vec3 diffColor_51;
  diffColor_51 = tmpvar_42;
  mediump vec3 color_52;
  mediump vec2 rlPow4AndFresnelTerm_53;
  mediump float tmpvar_54;
  highp float tmpvar_55;
  tmpvar_55 = clamp (dot (tmpvar_44, tmpvar_4), 0.0, 1.0);
  tmpvar_54 = tmpvar_55;
  mediump float tmpvar_56;
  highp float tmpvar_57;
  tmpvar_57 = clamp (dot (tmpvar_44, worldViewDir_9), 0.0, 1.0);
  tmpvar_56 = tmpvar_57;
  highp vec2 tmpvar_58;
  tmpvar_58.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_44, worldViewDir_9) * tmpvar_44)
  )), tmpvar_4);
  tmpvar_58.y = (1.0 - tmpvar_56);
  highp vec2 tmpvar_59;
  tmpvar_59 = ((tmpvar_58 * tmpvar_58) * (tmpvar_58 * tmpvar_58));
  rlPow4AndFresnelTerm_53 = tmpvar_59;
  mediump float tmpvar_60;
  tmpvar_60 = rlPow4AndFresnelTerm_53.x;
  mediump float specular_61;
  highp float smoothness_62;
  smoothness_62 = tmpvar_8;
  highp vec2 tmpvar_63;
  tmpvar_63.x = tmpvar_60;
  tmpvar_63.y = (1.0 - smoothness_62);
  highp float tmpvar_64;
  tmpvar_64 = (texture2D (unity_NHxRoughness, tmpvar_63).w * 16.0);
  specular_61 = tmpvar_64;
  color_52 = ((diffColor_51 + (specular_61 * tmpvar_47)) * (tmpvar_3 * tmpvar_54));
  color_52 = (color_52 + ((
    (hdr_38.x * ((hdr_38.w * (tmpvar_41.w - 1.0)) + 1.0))
   * tmpvar_41.xyz) * mix (tmpvar_47, vec3(
    clamp ((tmpvar_8 + (1.0 - tmpvar_48)), 0.0, 1.0)
  ), rlPow4AndFresnelTerm_53.yyy)));
  mediump vec4 tmpvar_65;
  tmpvar_65.w = 1.0;
  tmpvar_65.xyz = color_52;
  c_43.xyz = tmpvar_65.xyz;
  c_43.w = ((1.0 - tmpvar_48) + (alpha_50 * tmpvar_48));
  c_6 = c_43;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_66;
  color_66 = c_6;
  highp vec3 ase_worldNormal_67;
  mediump vec3 tmpvar_68;
  tmpvar_68.x = tmpvar_11.z;
  tmpvar_68.y = tmpvar_12.z;
  tmpvar_68.z = tmpvar_13.z;
  ase_worldNormal_67 = tmpvar_68;
  highp float blue_69;
  highp float green_70;
  highp vec4 redAlpha_71;
  highp vec4 screenPos_72;
  screenPos_72.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_73;
  tmpvar_73 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_72.y = (((xlv_TEXCOORD4.y - tmpvar_73) * _ProjectionParams.x) + tmpvar_73);
  highp vec2 tmpvar_74;
  tmpvar_74 = (screenPos_72 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_75;
  tmpvar_75.w = 0.0;
  tmpvar_75.xyz = tmpvar_32;
  highp vec3 tmpvar_76;
  tmpvar_76 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_67, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_75)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_77;
  tmpvar_77.x = tmpvar_76.x;
  tmpvar_77.y = -((tmpvar_76.y * _ProjectionParams.x));
  lowp vec4 tmpvar_78;
  highp vec2 P_79;
  P_79 = (tmpvar_74 + tmpvar_77);
  tmpvar_78 = texture2D (_GrabTexture, P_79);
  redAlpha_71 = tmpvar_78;
  highp vec2 P_80;
  P_80 = (tmpvar_74 + (tmpvar_77 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_81;
  tmpvar_81 = texture2D (_GrabTexture, P_80).y;
  green_70 = tmpvar_81;
  highp vec2 P_82;
  P_82 = (tmpvar_74 + (tmpvar_77 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_83;
  tmpvar_83 = texture2D (_GrabTexture, P_82).z;
  blue_69 = tmpvar_83;
  highp vec4 tmpvar_84;
  tmpvar_84.x = redAlpha_71.x;
  tmpvar_84.y = green_70;
  tmpvar_84.z = blue_69;
  tmpvar_84.w = redAlpha_71.w;
  highp vec3 tmpvar_85;
  tmpvar_85 = (tmpvar_84 * (1.0 - color_66.w)).xyz;
  color_66.xyz = (color_66.xyz + tmpvar_85);
  color_66.w = 1.0;
  c_6 = color_66;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 tmpvar_38;
  mediump vec4 hdr_39;
  hdr_39 = tmpvar_2;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_40.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_40.xyz, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  tmpvar_38 = ((hdr_39.x * (
    (hdr_39.w * (tmpvar_42.w - 1.0))
   + 1.0)) * tmpvar_42.xyz);
  lowp vec3 tmpvar_43;
  mediump vec4 c_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_32);
  mediump vec3 tmpvar_46;
  mediump vec3 albedo_47;
  albedo_47 = tmpvar_16;
  mediump vec3 tmpvar_48;
  tmpvar_48 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_47, vec3(tmpvar_7));
  mediump float tmpvar_49;
  tmpvar_49 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_46 = (albedo_47 * tmpvar_49);
  tmpvar_43 = tmpvar_46;
  mediump vec3 diffColor_50;
  diffColor_50 = tmpvar_43;
  mediump float alpha_51;
  alpha_51 = tmpvar_19;
  diffColor_50 = (diffColor_50 * alpha_51);
  tmpvar_43 = diffColor_50;
  mediump vec3 diffColor_52;
  diffColor_52 = tmpvar_43;
  mediump vec3 color_53;
  mediump float surfaceReduction_54;
  highp float specularTerm_55;
  highp float a2_56;
  mediump float roughness_57;
  mediump float perceptualRoughness_58;
  highp vec3 tmpvar_59;
  highp vec3 inVec_60;
  inVec_60 = (tmpvar_4 + worldViewDir_9);
  tmpvar_59 = (inVec_60 * inversesqrt(max (0.001, 
    dot (inVec_60, inVec_60)
  )));
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (dot (tmpvar_45, tmpvar_4), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (dot (tmpvar_45, tmpvar_59), 0.0, 1.0);
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (dot (tmpvar_45, worldViewDir_9), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  highp float tmpvar_66;
  highp float smoothness_67;
  smoothness_67 = tmpvar_8;
  tmpvar_66 = (1.0 - smoothness_67);
  perceptualRoughness_58 = tmpvar_66;
  highp float tmpvar_68;
  highp float perceptualRoughness_69;
  perceptualRoughness_69 = perceptualRoughness_58;
  tmpvar_68 = (perceptualRoughness_69 * perceptualRoughness_69);
  roughness_57 = tmpvar_68;
  mediump float tmpvar_70;
  tmpvar_70 = (roughness_57 * roughness_57);
  a2_56 = tmpvar_70;
  specularTerm_55 = ((roughness_57 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_59), 0.0, 1.0)) * (1.5 + roughness_57))
   * 
    (((tmpvar_63 * tmpvar_63) * (a2_56 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_71;
  tmpvar_71 = clamp (specularTerm_55, 0.0, 100.0);
  specularTerm_55 = tmpvar_71;
  surfaceReduction_54 = (1.0 - ((roughness_57 * perceptualRoughness_58) * 0.28));
  mediump float x_72;
  x_72 = (1.0 - tmpvar_64);
  mediump vec3 tmpvar_73;
  tmpvar_73 = mix (tmpvar_48, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_49)
  ), 0.0, 1.0)), vec3(((x_72 * x_72) * (x_72 * x_72))));
  highp vec3 tmpvar_74;
  tmpvar_74 = (((
    (diffColor_52 + (tmpvar_71 * tmpvar_48))
   * tmpvar_3) * tmpvar_61) + ((surfaceReduction_54 * tmpvar_38) * tmpvar_73));
  color_53 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.w = 1.0;
  tmpvar_75.xyz = color_53;
  c_44.xyz = tmpvar_75.xyz;
  c_44.w = ((1.0 - tmpvar_49) + (alpha_51 * tmpvar_49));
  c_6 = c_44;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_76;
  color_76 = c_6;
  highp vec3 ase_worldNormal_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.x = tmpvar_11.z;
  tmpvar_78.y = tmpvar_12.z;
  tmpvar_78.z = tmpvar_13.z;
  ase_worldNormal_77 = tmpvar_78;
  highp float blue_79;
  highp float green_80;
  highp vec4 redAlpha_81;
  highp vec4 screenPos_82;
  screenPos_82.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_83;
  tmpvar_83 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_82.y = (((xlv_TEXCOORD4.y - tmpvar_83) * _ProjectionParams.x) + tmpvar_83);
  highp vec2 tmpvar_84;
  tmpvar_84 = (screenPos_82 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_85;
  tmpvar_85.w = 0.0;
  tmpvar_85.xyz = tmpvar_32;
  highp vec3 tmpvar_86;
  tmpvar_86 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_77, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_85)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_87;
  tmpvar_87.x = tmpvar_86.x;
  tmpvar_87.y = -((tmpvar_86.y * _ProjectionParams.x));
  lowp vec4 tmpvar_88;
  highp vec2 P_89;
  P_89 = (tmpvar_84 + tmpvar_87);
  tmpvar_88 = texture2D (_GrabTexture, P_89);
  redAlpha_81 = tmpvar_88;
  highp vec2 P_90;
  P_90 = (tmpvar_84 + (tmpvar_87 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_91;
  tmpvar_91 = texture2D (_GrabTexture, P_90).y;
  green_80 = tmpvar_91;
  highp vec2 P_92;
  P_92 = (tmpvar_84 + (tmpvar_87 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_93;
  tmpvar_93 = texture2D (_GrabTexture, P_92).z;
  blue_79 = tmpvar_93;
  highp vec4 tmpvar_94;
  tmpvar_94.x = redAlpha_81.x;
  tmpvar_94.y = green_80;
  tmpvar_94.z = blue_79;
  tmpvar_94.w = redAlpha_81.w;
  highp vec3 tmpvar_95;
  tmpvar_95 = (tmpvar_94 * (1.0 - color_76.w)).xyz;
  color_76.xyz = (color_76.xyz + tmpvar_95);
  color_76.w = 1.0;
  c_6 = color_76;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 tmpvar_38;
  mediump vec4 hdr_39;
  hdr_39 = tmpvar_2;
  mediump vec4 tmpvar_40;
  tmpvar_40.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_40.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_41;
  tmpvar_41 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_40.xyz, tmpvar_40.w);
  mediump vec4 tmpvar_42;
  tmpvar_42 = tmpvar_41;
  tmpvar_38 = ((hdr_39.x * (
    (hdr_39.w * (tmpvar_42.w - 1.0))
   + 1.0)) * tmpvar_42.xyz);
  lowp vec3 tmpvar_43;
  mediump vec4 c_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(tmpvar_32);
  mediump vec3 tmpvar_46;
  mediump vec3 albedo_47;
  albedo_47 = tmpvar_16;
  mediump vec3 tmpvar_48;
  tmpvar_48 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_47, vec3(tmpvar_7));
  mediump float tmpvar_49;
  tmpvar_49 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_46 = (albedo_47 * tmpvar_49);
  tmpvar_43 = tmpvar_46;
  mediump vec3 diffColor_50;
  diffColor_50 = tmpvar_43;
  mediump float alpha_51;
  alpha_51 = tmpvar_19;
  diffColor_50 = (diffColor_50 * alpha_51);
  tmpvar_43 = diffColor_50;
  mediump vec3 diffColor_52;
  diffColor_52 = tmpvar_43;
  mediump vec3 color_53;
  mediump float surfaceReduction_54;
  highp float specularTerm_55;
  highp float a2_56;
  mediump float roughness_57;
  mediump float perceptualRoughness_58;
  highp vec3 tmpvar_59;
  highp vec3 inVec_60;
  inVec_60 = (tmpvar_4 + worldViewDir_9);
  tmpvar_59 = (inVec_60 * inversesqrt(max (0.001, 
    dot (inVec_60, inVec_60)
  )));
  mediump float tmpvar_61;
  highp float tmpvar_62;
  tmpvar_62 = clamp (dot (tmpvar_45, tmpvar_4), 0.0, 1.0);
  tmpvar_61 = tmpvar_62;
  highp float tmpvar_63;
  tmpvar_63 = clamp (dot (tmpvar_45, tmpvar_59), 0.0, 1.0);
  mediump float tmpvar_64;
  highp float tmpvar_65;
  tmpvar_65 = clamp (dot (tmpvar_45, worldViewDir_9), 0.0, 1.0);
  tmpvar_64 = tmpvar_65;
  highp float tmpvar_66;
  highp float smoothness_67;
  smoothness_67 = tmpvar_8;
  tmpvar_66 = (1.0 - smoothness_67);
  perceptualRoughness_58 = tmpvar_66;
  highp float tmpvar_68;
  highp float perceptualRoughness_69;
  perceptualRoughness_69 = perceptualRoughness_58;
  tmpvar_68 = (perceptualRoughness_69 * perceptualRoughness_69);
  roughness_57 = tmpvar_68;
  mediump float tmpvar_70;
  tmpvar_70 = (roughness_57 * roughness_57);
  a2_56 = tmpvar_70;
  specularTerm_55 = ((roughness_57 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_59), 0.0, 1.0)) * (1.5 + roughness_57))
   * 
    (((tmpvar_63 * tmpvar_63) * (a2_56 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_71;
  tmpvar_71 = clamp (specularTerm_55, 0.0, 100.0);
  specularTerm_55 = tmpvar_71;
  surfaceReduction_54 = (1.0 - ((roughness_57 * perceptualRoughness_58) * 0.28));
  mediump float x_72;
  x_72 = (1.0 - tmpvar_64);
  mediump vec3 tmpvar_73;
  tmpvar_73 = mix (tmpvar_48, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_49)
  ), 0.0, 1.0)), vec3(((x_72 * x_72) * (x_72 * x_72))));
  highp vec3 tmpvar_74;
  tmpvar_74 = (((
    (diffColor_52 + (tmpvar_71 * tmpvar_48))
   * tmpvar_3) * tmpvar_61) + ((surfaceReduction_54 * tmpvar_38) * tmpvar_73));
  color_53 = tmpvar_74;
  mediump vec4 tmpvar_75;
  tmpvar_75.w = 1.0;
  tmpvar_75.xyz = color_53;
  c_44.xyz = tmpvar_75.xyz;
  c_44.w = ((1.0 - tmpvar_49) + (alpha_51 * tmpvar_49));
  c_6 = c_44;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_76;
  color_76 = c_6;
  highp vec3 ase_worldNormal_77;
  mediump vec3 tmpvar_78;
  tmpvar_78.x = tmpvar_11.z;
  tmpvar_78.y = tmpvar_12.z;
  tmpvar_78.z = tmpvar_13.z;
  ase_worldNormal_77 = tmpvar_78;
  highp float blue_79;
  highp float green_80;
  highp vec4 redAlpha_81;
  highp vec4 screenPos_82;
  screenPos_82.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_83;
  tmpvar_83 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_82.y = (((xlv_TEXCOORD4.y - tmpvar_83) * _ProjectionParams.x) + tmpvar_83);
  highp vec2 tmpvar_84;
  tmpvar_84 = (screenPos_82 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_85;
  tmpvar_85.w = 0.0;
  tmpvar_85.xyz = tmpvar_32;
  highp vec3 tmpvar_86;
  tmpvar_86 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_77, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_85)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_87;
  tmpvar_87.x = tmpvar_86.x;
  tmpvar_87.y = -((tmpvar_86.y * _ProjectionParams.x));
  lowp vec4 tmpvar_88;
  highp vec2 P_89;
  P_89 = (tmpvar_84 + tmpvar_87);
  tmpvar_88 = texture2D (_GrabTexture, P_89);
  redAlpha_81 = tmpvar_88;
  highp vec2 P_90;
  P_90 = (tmpvar_84 + (tmpvar_87 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_91;
  tmpvar_91 = texture2D (_GrabTexture, P_90).y;
  green_80 = tmpvar_91;
  highp vec2 P_92;
  P_92 = (tmpvar_84 + (tmpvar_87 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_93;
  tmpvar_93 = texture2D (_GrabTexture, P_92).z;
  blue_79 = tmpvar_93;
  highp vec4 tmpvar_94;
  tmpvar_94.x = redAlpha_81.x;
  tmpvar_94.y = green_80;
  tmpvar_94.z = blue_79;
  tmpvar_94.w = redAlpha_81.w;
  highp vec3 tmpvar_95;
  tmpvar_95 = (tmpvar_94 * (1.0 - color_76.w)).xyz;
  color_76.xyz = (color_76.xyz + tmpvar_95);
  color_76.w = 1.0;
  c_6 = color_76;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  mediump vec3 normal_26;
  normal_26 = tmpvar_15;
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (normal_26.xyzz * normal_26.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = (x1_27 + (unity_SHC.xyz * (
    (normal_26.x * normal_26.x)
   - 
    (normal_26.y * normal_26.y)
  )));
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = normalWorld_38;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_39);
  x_40.y = dot (unity_SHAg, tmpvar_39);
  x_40.z = dot (unity_SHAb, tmpvar_39);
  mediump vec4 hdr_41;
  hdr_41 = tmpvar_2;
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_42.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_42.xyz, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  lowp vec3 tmpvar_45;
  mediump vec4 c_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize(tmpvar_32);
  mediump vec3 tmpvar_48;
  mediump vec3 albedo_49;
  albedo_49 = tmpvar_16;
  mediump vec3 tmpvar_50;
  tmpvar_50 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_49, vec3(tmpvar_7));
  mediump float tmpvar_51;
  tmpvar_51 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_48 = (albedo_49 * tmpvar_51);
  tmpvar_45 = tmpvar_48;
  mediump vec3 diffColor_52;
  diffColor_52 = tmpvar_45;
  mediump float alpha_53;
  alpha_53 = tmpvar_19;
  diffColor_52 = (diffColor_52 * alpha_53);
  tmpvar_45 = diffColor_52;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_45;
  mediump vec3 color_55;
  mediump vec2 rlPow4AndFresnelTerm_56;
  mediump float tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_47, tmpvar_4), 0.0, 1.0);
  tmpvar_57 = tmpvar_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_47, worldViewDir_9), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  highp vec2 tmpvar_61;
  tmpvar_61.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_47, worldViewDir_9) * tmpvar_47)
  )), tmpvar_4);
  tmpvar_61.y = (1.0 - tmpvar_59);
  highp vec2 tmpvar_62;
  tmpvar_62 = ((tmpvar_61 * tmpvar_61) * (tmpvar_61 * tmpvar_61));
  rlPow4AndFresnelTerm_56 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = rlPow4AndFresnelTerm_56.x;
  mediump float specular_64;
  highp float smoothness_65;
  smoothness_65 = tmpvar_8;
  highp vec2 tmpvar_66;
  tmpvar_66.x = tmpvar_63;
  tmpvar_66.y = (1.0 - smoothness_65);
  highp float tmpvar_67;
  tmpvar_67 = (texture2D (unity_NHxRoughness, tmpvar_66).w * 16.0);
  specular_64 = tmpvar_67;
  color_55 = ((diffColor_54 + (specular_64 * tmpvar_50)) * (tmpvar_3 * tmpvar_57));
  color_55 = (color_55 + ((
    max (((1.055 * pow (
      max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_40))
    , vec3(0.4166667, 0.4166667, 0.4166667))) - 0.055), vec3(0.0, 0.0, 0.0))
   * diffColor_54) + (
    ((hdr_41.x * ((hdr_41.w * 
      (tmpvar_44.w - 1.0)
    ) + 1.0)) * tmpvar_44.xyz)
   * 
    mix (tmpvar_50, vec3(clamp ((tmpvar_8 + (1.0 - tmpvar_51)), 0.0, 1.0)), rlPow4AndFresnelTerm_56.yyy)
  )));
  mediump vec4 tmpvar_68;
  tmpvar_68.w = 1.0;
  tmpvar_68.xyz = color_55;
  c_46.xyz = tmpvar_68.xyz;
  c_46.w = ((1.0 - tmpvar_51) + (alpha_53 * tmpvar_51));
  c_6 = c_46;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_69;
  color_69 = c_6;
  highp vec3 ase_worldNormal_70;
  mediump vec3 tmpvar_71;
  tmpvar_71.x = tmpvar_11.z;
  tmpvar_71.y = tmpvar_12.z;
  tmpvar_71.z = tmpvar_13.z;
  ase_worldNormal_70 = tmpvar_71;
  highp float blue_72;
  highp float green_73;
  highp vec4 redAlpha_74;
  highp vec4 screenPos_75;
  screenPos_75.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_76;
  tmpvar_76 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_75.y = (((xlv_TEXCOORD4.y - tmpvar_76) * _ProjectionParams.x) + tmpvar_76);
  highp vec2 tmpvar_77;
  tmpvar_77 = (screenPos_75 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_78;
  tmpvar_78.w = 0.0;
  tmpvar_78.xyz = tmpvar_32;
  highp vec3 tmpvar_79;
  tmpvar_79 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_70, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_78)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_80;
  tmpvar_80.x = tmpvar_79.x;
  tmpvar_80.y = -((tmpvar_79.y * _ProjectionParams.x));
  lowp vec4 tmpvar_81;
  highp vec2 P_82;
  P_82 = (tmpvar_77 + tmpvar_80);
  tmpvar_81 = texture2D (_GrabTexture, P_82);
  redAlpha_74 = tmpvar_81;
  highp vec2 P_83;
  P_83 = (tmpvar_77 + (tmpvar_80 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_84;
  tmpvar_84 = texture2D (_GrabTexture, P_83).y;
  green_73 = tmpvar_84;
  highp vec2 P_85;
  P_85 = (tmpvar_77 + (tmpvar_80 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_86;
  tmpvar_86 = texture2D (_GrabTexture, P_85).z;
  blue_72 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87.x = redAlpha_74.x;
  tmpvar_87.y = green_73;
  tmpvar_87.z = blue_72;
  tmpvar_87.w = redAlpha_74.w;
  highp vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_87 * (1.0 - color_69.w)).xyz;
  color_69.xyz = (color_69.xyz + tmpvar_88);
  color_69.w = 1.0;
  c_6 = color_69;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  mediump vec3 normal_26;
  normal_26 = tmpvar_15;
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (normal_26.xyzz * normal_26.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = (x1_27 + (unity_SHC.xyz * (
    (normal_26.x * normal_26.x)
   - 
    (normal_26.y * normal_26.y)
  )));
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec3 tmpvar_39;
  mediump vec3 tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = normalWorld_38;
  mediump vec3 x_42;
  x_42.x = dot (unity_SHAr, tmpvar_41);
  x_42.y = dot (unity_SHAg, tmpvar_41);
  x_42.z = dot (unity_SHAb, tmpvar_41);
  tmpvar_40 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_42)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_43;
  hdr_43 = tmpvar_2;
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_44.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_44.xyz, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  tmpvar_39 = ((hdr_43.x * (
    (hdr_43.w * (tmpvar_46.w - 1.0))
   + 1.0)) * tmpvar_46.xyz);
  lowp vec3 tmpvar_47;
  mediump vec4 c_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize(tmpvar_32);
  mediump vec3 tmpvar_50;
  mediump vec3 albedo_51;
  albedo_51 = tmpvar_16;
  mediump vec3 tmpvar_52;
  tmpvar_52 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_51, vec3(tmpvar_7));
  mediump float tmpvar_53;
  tmpvar_53 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_50 = (albedo_51 * tmpvar_53);
  tmpvar_47 = tmpvar_50;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_47;
  mediump float alpha_55;
  alpha_55 = tmpvar_19;
  diffColor_54 = (diffColor_54 * alpha_55);
  tmpvar_47 = diffColor_54;
  mediump vec3 diffColor_56;
  diffColor_56 = tmpvar_47;
  mediump vec3 color_57;
  mediump float surfaceReduction_58;
  highp float specularTerm_59;
  highp float a2_60;
  mediump float roughness_61;
  mediump float perceptualRoughness_62;
  highp vec3 tmpvar_63;
  highp vec3 inVec_64;
  inVec_64 = (tmpvar_4 + worldViewDir_9);
  tmpvar_63 = (inVec_64 * inversesqrt(max (0.001, 
    dot (inVec_64, inVec_64)
  )));
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_49, tmpvar_4), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_49, tmpvar_63), 0.0, 1.0);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (dot (tmpvar_49, worldViewDir_9), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  highp float tmpvar_70;
  highp float smoothness_71;
  smoothness_71 = tmpvar_8;
  tmpvar_70 = (1.0 - smoothness_71);
  perceptualRoughness_62 = tmpvar_70;
  highp float tmpvar_72;
  highp float perceptualRoughness_73;
  perceptualRoughness_73 = perceptualRoughness_62;
  tmpvar_72 = (perceptualRoughness_73 * perceptualRoughness_73);
  roughness_61 = tmpvar_72;
  mediump float tmpvar_74;
  tmpvar_74 = (roughness_61 * roughness_61);
  a2_60 = tmpvar_74;
  specularTerm_59 = ((roughness_61 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_63), 0.0, 1.0)) * (1.5 + roughness_61))
   * 
    (((tmpvar_67 * tmpvar_67) * (a2_60 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_75;
  tmpvar_75 = clamp (specularTerm_59, 0.0, 100.0);
  specularTerm_59 = tmpvar_75;
  surfaceReduction_58 = (1.0 - ((roughness_61 * perceptualRoughness_62) * 0.28));
  mediump float x_76;
  x_76 = (1.0 - tmpvar_68);
  mediump vec3 tmpvar_77;
  tmpvar_77 = mix (tmpvar_52, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_53)
  ), 0.0, 1.0)), vec3(((x_76 * x_76) * (x_76 * x_76))));
  highp vec3 tmpvar_78;
  tmpvar_78 = (((
    ((diffColor_56 + (tmpvar_75 * tmpvar_52)) * tmpvar_3)
   * tmpvar_65) + (tmpvar_40 * diffColor_56)) + ((surfaceReduction_58 * tmpvar_39) * tmpvar_77));
  color_57 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = color_57;
  c_48.xyz = tmpvar_79.xyz;
  c_48.w = ((1.0 - tmpvar_53) + (alpha_55 * tmpvar_53));
  c_6 = c_48;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_80;
  color_80 = c_6;
  highp vec3 ase_worldNormal_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.x = tmpvar_11.z;
  tmpvar_82.y = tmpvar_12.z;
  tmpvar_82.z = tmpvar_13.z;
  ase_worldNormal_81 = tmpvar_82;
  highp float blue_83;
  highp float green_84;
  highp vec4 redAlpha_85;
  highp vec4 screenPos_86;
  screenPos_86.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_87;
  tmpvar_87 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_86.y = (((xlv_TEXCOORD4.y - tmpvar_87) * _ProjectionParams.x) + tmpvar_87);
  highp vec2 tmpvar_88;
  tmpvar_88 = (screenPos_86 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_89;
  tmpvar_89.w = 0.0;
  tmpvar_89.xyz = tmpvar_32;
  highp vec3 tmpvar_90;
  tmpvar_90 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_81, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_89)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_91;
  tmpvar_91.x = tmpvar_90.x;
  tmpvar_91.y = -((tmpvar_90.y * _ProjectionParams.x));
  lowp vec4 tmpvar_92;
  highp vec2 P_93;
  P_93 = (tmpvar_88 + tmpvar_91);
  tmpvar_92 = texture2D (_GrabTexture, P_93);
  redAlpha_85 = tmpvar_92;
  highp vec2 P_94;
  P_94 = (tmpvar_88 + (tmpvar_91 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_95;
  tmpvar_95 = texture2D (_GrabTexture, P_94).y;
  green_84 = tmpvar_95;
  highp vec2 P_96;
  P_96 = (tmpvar_88 + (tmpvar_91 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_97;
  tmpvar_97 = texture2D (_GrabTexture, P_96).z;
  blue_83 = tmpvar_97;
  highp vec4 tmpvar_98;
  tmpvar_98.x = redAlpha_85.x;
  tmpvar_98.y = green_84;
  tmpvar_98.z = blue_83;
  tmpvar_98.w = redAlpha_85.w;
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_98 * (1.0 - color_80.w)).xyz;
  color_80.xyz = (color_80.xyz + tmpvar_99);
  color_80.w = 1.0;
  c_6 = color_80;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_1.xyz;
  tmpvar_6 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_7));
  highp vec4 o_8;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_6 * 0.5);
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_8.xy = (tmpvar_10 + tmpvar_9.w);
  o_8.zw = tmpvar_6.zw;
  highp vec4 tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.w = 1.0;
  tmpvar_12.xyz = tmpvar_1.xyz;
  tmpvar_11 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_12));
  highp vec3 tmpvar_13;
  tmpvar_13 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_WorldToObject[0].xyz;
  tmpvar_14[1] = unity_WorldToObject[1].xyz;
  tmpvar_14[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((_glesNormal * tmpvar_14));
  highp mat3 tmpvar_16;
  tmpvar_16[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_16[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_16[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((tmpvar_16 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = (((tmpvar_15.yzx * worldTangent_4.zxy) - (tmpvar_15.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20.x = worldTangent_4.x;
  tmpvar_20.y = worldBinormal_2.x;
  tmpvar_20.z = tmpvar_15.x;
  tmpvar_20.w = tmpvar_13.x;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.y;
  tmpvar_21.y = worldBinormal_2.y;
  tmpvar_21.z = tmpvar_15.y;
  tmpvar_21.w = tmpvar_13.y;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.z;
  tmpvar_22.y = worldBinormal_2.z;
  tmpvar_22.z = tmpvar_15.z;
  tmpvar_22.w = tmpvar_13.z;
  highp vec4 o_23;
  highp vec4 tmpvar_24;
  tmpvar_24 = (tmpvar_11 * 0.5);
  highp vec2 tmpvar_25;
  tmpvar_25.x = tmpvar_24.x;
  tmpvar_25.y = (tmpvar_24.y * _ProjectionParams.x);
  o_23.xy = (tmpvar_25 + tmpvar_24.w);
  o_23.zw = tmpvar_11.zw;
  mediump vec3 normal_26;
  normal_26 = tmpvar_15;
  mediump vec3 x1_27;
  mediump vec4 tmpvar_28;
  tmpvar_28 = (normal_26.xyzz * normal_26.yzzx);
  x1_27.x = dot (unity_SHBr, tmpvar_28);
  x1_27.y = dot (unity_SHBg, tmpvar_28);
  x1_27.z = dot (unity_SHBb, tmpvar_28);
  gl_Position = tmpvar_11;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_20;
  xlv_TEXCOORD2 = tmpvar_21;
  xlv_TEXCOORD3 = tmpvar_22;
  xlv_TEXCOORD4 = o_23;
  xlv_TEXCOORD5 = o_8;
  xlv_TEXCOORD6 = (x1_27 + (unity_SHC.xyz * (
    (normal_26.x * normal_26.x)
   - 
    (normal_26.y * normal_26.y)
  )));
  xlv_TEXCOORD7 = tmpvar_5;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec3 tmpvar_39;
  mediump vec3 tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = normalWorld_38;
  mediump vec3 x_42;
  x_42.x = dot (unity_SHAr, tmpvar_41);
  x_42.y = dot (unity_SHAg, tmpvar_41);
  x_42.z = dot (unity_SHAb, tmpvar_41);
  tmpvar_40 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_42)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_43;
  hdr_43 = tmpvar_2;
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_44.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_44.xyz, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  tmpvar_39 = ((hdr_43.x * (
    (hdr_43.w * (tmpvar_46.w - 1.0))
   + 1.0)) * tmpvar_46.xyz);
  lowp vec3 tmpvar_47;
  mediump vec4 c_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize(tmpvar_32);
  mediump vec3 tmpvar_50;
  mediump vec3 albedo_51;
  albedo_51 = tmpvar_16;
  mediump vec3 tmpvar_52;
  tmpvar_52 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_51, vec3(tmpvar_7));
  mediump float tmpvar_53;
  tmpvar_53 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_50 = (albedo_51 * tmpvar_53);
  tmpvar_47 = tmpvar_50;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_47;
  mediump float alpha_55;
  alpha_55 = tmpvar_19;
  diffColor_54 = (diffColor_54 * alpha_55);
  tmpvar_47 = diffColor_54;
  mediump vec3 diffColor_56;
  diffColor_56 = tmpvar_47;
  mediump vec3 color_57;
  mediump float surfaceReduction_58;
  highp float specularTerm_59;
  highp float a2_60;
  mediump float roughness_61;
  mediump float perceptualRoughness_62;
  highp vec3 tmpvar_63;
  highp vec3 inVec_64;
  inVec_64 = (tmpvar_4 + worldViewDir_9);
  tmpvar_63 = (inVec_64 * inversesqrt(max (0.001, 
    dot (inVec_64, inVec_64)
  )));
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_49, tmpvar_4), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_49, tmpvar_63), 0.0, 1.0);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (dot (tmpvar_49, worldViewDir_9), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  highp float tmpvar_70;
  highp float smoothness_71;
  smoothness_71 = tmpvar_8;
  tmpvar_70 = (1.0 - smoothness_71);
  perceptualRoughness_62 = tmpvar_70;
  highp float tmpvar_72;
  highp float perceptualRoughness_73;
  perceptualRoughness_73 = perceptualRoughness_62;
  tmpvar_72 = (perceptualRoughness_73 * perceptualRoughness_73);
  roughness_61 = tmpvar_72;
  mediump float tmpvar_74;
  tmpvar_74 = (roughness_61 * roughness_61);
  a2_60 = tmpvar_74;
  specularTerm_59 = ((roughness_61 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_63), 0.0, 1.0)) * (1.5 + roughness_61))
   * 
    (((tmpvar_67 * tmpvar_67) * (a2_60 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_75;
  tmpvar_75 = clamp (specularTerm_59, 0.0, 100.0);
  specularTerm_59 = tmpvar_75;
  surfaceReduction_58 = (1.0 - ((roughness_61 * perceptualRoughness_62) * 0.28));
  mediump float x_76;
  x_76 = (1.0 - tmpvar_68);
  mediump vec3 tmpvar_77;
  tmpvar_77 = mix (tmpvar_52, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_53)
  ), 0.0, 1.0)), vec3(((x_76 * x_76) * (x_76 * x_76))));
  highp vec3 tmpvar_78;
  tmpvar_78 = (((
    ((diffColor_56 + (tmpvar_75 * tmpvar_52)) * tmpvar_3)
   * tmpvar_65) + (tmpvar_40 * diffColor_56)) + ((surfaceReduction_58 * tmpvar_39) * tmpvar_77));
  color_57 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = color_57;
  c_48.xyz = tmpvar_79.xyz;
  c_48.w = ((1.0 - tmpvar_53) + (alpha_55 * tmpvar_53));
  c_6 = c_48;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_80;
  color_80 = c_6;
  highp vec3 ase_worldNormal_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.x = tmpvar_11.z;
  tmpvar_82.y = tmpvar_12.z;
  tmpvar_82.z = tmpvar_13.z;
  ase_worldNormal_81 = tmpvar_82;
  highp float blue_83;
  highp float green_84;
  highp vec4 redAlpha_85;
  highp vec4 screenPos_86;
  screenPos_86.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_87;
  tmpvar_87 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_86.y = (((xlv_TEXCOORD4.y - tmpvar_87) * _ProjectionParams.x) + tmpvar_87);
  highp vec2 tmpvar_88;
  tmpvar_88 = (screenPos_86 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_89;
  tmpvar_89.w = 0.0;
  tmpvar_89.xyz = tmpvar_32;
  highp vec3 tmpvar_90;
  tmpvar_90 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_81, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_89)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_91;
  tmpvar_91.x = tmpvar_90.x;
  tmpvar_91.y = -((tmpvar_90.y * _ProjectionParams.x));
  lowp vec4 tmpvar_92;
  highp vec2 P_93;
  P_93 = (tmpvar_88 + tmpvar_91);
  tmpvar_92 = texture2D (_GrabTexture, P_93);
  redAlpha_85 = tmpvar_92;
  highp vec2 P_94;
  P_94 = (tmpvar_88 + (tmpvar_91 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_95;
  tmpvar_95 = texture2D (_GrabTexture, P_94).y;
  green_84 = tmpvar_95;
  highp vec2 P_96;
  P_96 = (tmpvar_88 + (tmpvar_91 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_97;
  tmpvar_97 = texture2D (_GrabTexture, P_96).z;
  blue_83 = tmpvar_97;
  highp vec4 tmpvar_98;
  tmpvar_98.x = redAlpha_85.x;
  tmpvar_98.y = green_84;
  tmpvar_98.z = blue_83;
  tmpvar_98.w = redAlpha_85.w;
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_98 * (1.0 - color_80.w)).xyz;
  color_80.xyz = (color_80.xyz + tmpvar_99);
  color_80.w = 1.0;
  c_6 = color_80;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_12.zw;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_16.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_16.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_16.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_5 = col_32;
  mediump vec3 normal_41;
  normal_41 = tmpvar_16;
  mediump vec3 ambient_42;
  mediump vec3 x1_43;
  mediump vec4 tmpvar_44;
  tmpvar_44 = (normal_41.xyzz * normal_41.yzzx);
  x1_43.x = dot (unity_SHBr, tmpvar_44);
  x1_43.y = dot (unity_SHBg, tmpvar_44);
  x1_43.z = dot (unity_SHBb, tmpvar_44);
  ambient_42 = ((tmpvar_5 * (
    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_43 + (unity_SHC.xyz * 
    ((normal_41.x * normal_41.x) - (normal_41.y * normal_41.y))
  )));
  tmpvar_5 = ambient_42;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_24;
  xlv_TEXCOORD5 = o_9;
  xlv_TEXCOORD6 = ambient_42;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec4 tmpvar_39;
  tmpvar_39.w = 1.0;
  tmpvar_39.xyz = normalWorld_38;
  mediump vec3 x_40;
  x_40.x = dot (unity_SHAr, tmpvar_39);
  x_40.y = dot (unity_SHAg, tmpvar_39);
  x_40.z = dot (unity_SHAb, tmpvar_39);
  mediump vec4 hdr_41;
  hdr_41 = tmpvar_2;
  mediump vec4 tmpvar_42;
  tmpvar_42.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_42.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_43;
  tmpvar_43 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_42.xyz, tmpvar_42.w);
  mediump vec4 tmpvar_44;
  tmpvar_44 = tmpvar_43;
  lowp vec3 tmpvar_45;
  mediump vec4 c_46;
  highp vec3 tmpvar_47;
  tmpvar_47 = normalize(tmpvar_32);
  mediump vec3 tmpvar_48;
  mediump vec3 albedo_49;
  albedo_49 = tmpvar_16;
  mediump vec3 tmpvar_50;
  tmpvar_50 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_49, vec3(tmpvar_7));
  mediump float tmpvar_51;
  tmpvar_51 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_48 = (albedo_49 * tmpvar_51);
  tmpvar_45 = tmpvar_48;
  mediump vec3 diffColor_52;
  diffColor_52 = tmpvar_45;
  mediump float alpha_53;
  alpha_53 = tmpvar_19;
  diffColor_52 = (diffColor_52 * alpha_53);
  tmpvar_45 = diffColor_52;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_45;
  mediump vec3 color_55;
  mediump vec2 rlPow4AndFresnelTerm_56;
  mediump float tmpvar_57;
  highp float tmpvar_58;
  tmpvar_58 = clamp (dot (tmpvar_47, tmpvar_4), 0.0, 1.0);
  tmpvar_57 = tmpvar_58;
  mediump float tmpvar_59;
  highp float tmpvar_60;
  tmpvar_60 = clamp (dot (tmpvar_47, worldViewDir_9), 0.0, 1.0);
  tmpvar_59 = tmpvar_60;
  highp vec2 tmpvar_61;
  tmpvar_61.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_47, worldViewDir_9) * tmpvar_47)
  )), tmpvar_4);
  tmpvar_61.y = (1.0 - tmpvar_59);
  highp vec2 tmpvar_62;
  tmpvar_62 = ((tmpvar_61 * tmpvar_61) * (tmpvar_61 * tmpvar_61));
  rlPow4AndFresnelTerm_56 = tmpvar_62;
  mediump float tmpvar_63;
  tmpvar_63 = rlPow4AndFresnelTerm_56.x;
  mediump float specular_64;
  highp float smoothness_65;
  smoothness_65 = tmpvar_8;
  highp vec2 tmpvar_66;
  tmpvar_66.x = tmpvar_63;
  tmpvar_66.y = (1.0 - smoothness_65);
  highp float tmpvar_67;
  tmpvar_67 = (texture2D (unity_NHxRoughness, tmpvar_66).w * 16.0);
  specular_64 = tmpvar_67;
  color_55 = ((diffColor_54 + (specular_64 * tmpvar_50)) * (tmpvar_3 * tmpvar_57));
  color_55 = (color_55 + ((
    max (((1.055 * pow (
      max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_40))
    , vec3(0.4166667, 0.4166667, 0.4166667))) - 0.055), vec3(0.0, 0.0, 0.0))
   * diffColor_54) + (
    ((hdr_41.x * ((hdr_41.w * 
      (tmpvar_44.w - 1.0)
    ) + 1.0)) * tmpvar_44.xyz)
   * 
    mix (tmpvar_50, vec3(clamp ((tmpvar_8 + (1.0 - tmpvar_51)), 0.0, 1.0)), rlPow4AndFresnelTerm_56.yyy)
  )));
  mediump vec4 tmpvar_68;
  tmpvar_68.w = 1.0;
  tmpvar_68.xyz = color_55;
  c_46.xyz = tmpvar_68.xyz;
  c_46.w = ((1.0 - tmpvar_51) + (alpha_53 * tmpvar_51));
  c_6 = c_46;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_69;
  color_69 = c_6;
  highp vec3 ase_worldNormal_70;
  mediump vec3 tmpvar_71;
  tmpvar_71.x = tmpvar_11.z;
  tmpvar_71.y = tmpvar_12.z;
  tmpvar_71.z = tmpvar_13.z;
  ase_worldNormal_70 = tmpvar_71;
  highp float blue_72;
  highp float green_73;
  highp vec4 redAlpha_74;
  highp vec4 screenPos_75;
  screenPos_75.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_76;
  tmpvar_76 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_75.y = (((xlv_TEXCOORD4.y - tmpvar_76) * _ProjectionParams.x) + tmpvar_76);
  highp vec2 tmpvar_77;
  tmpvar_77 = (screenPos_75 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_78;
  tmpvar_78.w = 0.0;
  tmpvar_78.xyz = tmpvar_32;
  highp vec3 tmpvar_79;
  tmpvar_79 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_70, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_78)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_80;
  tmpvar_80.x = tmpvar_79.x;
  tmpvar_80.y = -((tmpvar_79.y * _ProjectionParams.x));
  lowp vec4 tmpvar_81;
  highp vec2 P_82;
  P_82 = (tmpvar_77 + tmpvar_80);
  tmpvar_81 = texture2D (_GrabTexture, P_82);
  redAlpha_74 = tmpvar_81;
  highp vec2 P_83;
  P_83 = (tmpvar_77 + (tmpvar_80 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_84;
  tmpvar_84 = texture2D (_GrabTexture, P_83).y;
  green_73 = tmpvar_84;
  highp vec2 P_85;
  P_85 = (tmpvar_77 + (tmpvar_80 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_86;
  tmpvar_86 = texture2D (_GrabTexture, P_85).z;
  blue_72 = tmpvar_86;
  highp vec4 tmpvar_87;
  tmpvar_87.x = redAlpha_74.x;
  tmpvar_87.y = green_73;
  tmpvar_87.z = blue_72;
  tmpvar_87.w = redAlpha_74.w;
  highp vec3 tmpvar_88;
  tmpvar_88 = (tmpvar_87 * (1.0 - color_69.w)).xyz;
  color_69.xyz = (color_69.xyz + tmpvar_88);
  color_69.w = 1.0;
  c_6 = color_69;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_12.zw;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_16.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_16.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_16.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_5 = col_32;
  mediump vec3 normal_41;
  normal_41 = tmpvar_16;
  mediump vec3 ambient_42;
  mediump vec3 x1_43;
  mediump vec4 tmpvar_44;
  tmpvar_44 = (normal_41.xyzz * normal_41.yzzx);
  x1_43.x = dot (unity_SHBr, tmpvar_44);
  x1_43.y = dot (unity_SHBg, tmpvar_44);
  x1_43.z = dot (unity_SHBb, tmpvar_44);
  ambient_42 = ((tmpvar_5 * (
    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_43 + (unity_SHC.xyz * 
    ((normal_41.x * normal_41.x) - (normal_41.y * normal_41.y))
  )));
  tmpvar_5 = ambient_42;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_24;
  xlv_TEXCOORD5 = o_9;
  xlv_TEXCOORD6 = ambient_42;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec3 tmpvar_39;
  mediump vec3 tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = normalWorld_38;
  mediump vec3 x_42;
  x_42.x = dot (unity_SHAr, tmpvar_41);
  x_42.y = dot (unity_SHAg, tmpvar_41);
  x_42.z = dot (unity_SHAb, tmpvar_41);
  tmpvar_40 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_42)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_43;
  hdr_43 = tmpvar_2;
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_44.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_44.xyz, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  tmpvar_39 = ((hdr_43.x * (
    (hdr_43.w * (tmpvar_46.w - 1.0))
   + 1.0)) * tmpvar_46.xyz);
  lowp vec3 tmpvar_47;
  mediump vec4 c_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize(tmpvar_32);
  mediump vec3 tmpvar_50;
  mediump vec3 albedo_51;
  albedo_51 = tmpvar_16;
  mediump vec3 tmpvar_52;
  tmpvar_52 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_51, vec3(tmpvar_7));
  mediump float tmpvar_53;
  tmpvar_53 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_50 = (albedo_51 * tmpvar_53);
  tmpvar_47 = tmpvar_50;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_47;
  mediump float alpha_55;
  alpha_55 = tmpvar_19;
  diffColor_54 = (diffColor_54 * alpha_55);
  tmpvar_47 = diffColor_54;
  mediump vec3 diffColor_56;
  diffColor_56 = tmpvar_47;
  mediump vec3 color_57;
  mediump float surfaceReduction_58;
  highp float specularTerm_59;
  highp float a2_60;
  mediump float roughness_61;
  mediump float perceptualRoughness_62;
  highp vec3 tmpvar_63;
  highp vec3 inVec_64;
  inVec_64 = (tmpvar_4 + worldViewDir_9);
  tmpvar_63 = (inVec_64 * inversesqrt(max (0.001, 
    dot (inVec_64, inVec_64)
  )));
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_49, tmpvar_4), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_49, tmpvar_63), 0.0, 1.0);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (dot (tmpvar_49, worldViewDir_9), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  highp float tmpvar_70;
  highp float smoothness_71;
  smoothness_71 = tmpvar_8;
  tmpvar_70 = (1.0 - smoothness_71);
  perceptualRoughness_62 = tmpvar_70;
  highp float tmpvar_72;
  highp float perceptualRoughness_73;
  perceptualRoughness_73 = perceptualRoughness_62;
  tmpvar_72 = (perceptualRoughness_73 * perceptualRoughness_73);
  roughness_61 = tmpvar_72;
  mediump float tmpvar_74;
  tmpvar_74 = (roughness_61 * roughness_61);
  a2_60 = tmpvar_74;
  specularTerm_59 = ((roughness_61 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_63), 0.0, 1.0)) * (1.5 + roughness_61))
   * 
    (((tmpvar_67 * tmpvar_67) * (a2_60 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_75;
  tmpvar_75 = clamp (specularTerm_59, 0.0, 100.0);
  specularTerm_59 = tmpvar_75;
  surfaceReduction_58 = (1.0 - ((roughness_61 * perceptualRoughness_62) * 0.28));
  mediump float x_76;
  x_76 = (1.0 - tmpvar_68);
  mediump vec3 tmpvar_77;
  tmpvar_77 = mix (tmpvar_52, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_53)
  ), 0.0, 1.0)), vec3(((x_76 * x_76) * (x_76 * x_76))));
  highp vec3 tmpvar_78;
  tmpvar_78 = (((
    ((diffColor_56 + (tmpvar_75 * tmpvar_52)) * tmpvar_3)
   * tmpvar_65) + (tmpvar_40 * diffColor_56)) + ((surfaceReduction_58 * tmpvar_39) * tmpvar_77));
  color_57 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = color_57;
  c_48.xyz = tmpvar_79.xyz;
  c_48.w = ((1.0 - tmpvar_53) + (alpha_55 * tmpvar_53));
  c_6 = c_48;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_80;
  color_80 = c_6;
  highp vec3 ase_worldNormal_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.x = tmpvar_11.z;
  tmpvar_82.y = tmpvar_12.z;
  tmpvar_82.z = tmpvar_13.z;
  ase_worldNormal_81 = tmpvar_82;
  highp float blue_83;
  highp float green_84;
  highp vec4 redAlpha_85;
  highp vec4 screenPos_86;
  screenPos_86.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_87;
  tmpvar_87 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_86.y = (((xlv_TEXCOORD4.y - tmpvar_87) * _ProjectionParams.x) + tmpvar_87);
  highp vec2 tmpvar_88;
  tmpvar_88 = (screenPos_86 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_89;
  tmpvar_89.w = 0.0;
  tmpvar_89.xyz = tmpvar_32;
  highp vec3 tmpvar_90;
  tmpvar_90 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_81, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_89)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_91;
  tmpvar_91.x = tmpvar_90.x;
  tmpvar_91.y = -((tmpvar_90.y * _ProjectionParams.x));
  lowp vec4 tmpvar_92;
  highp vec2 P_93;
  P_93 = (tmpvar_88 + tmpvar_91);
  tmpvar_92 = texture2D (_GrabTexture, P_93);
  redAlpha_85 = tmpvar_92;
  highp vec2 P_94;
  P_94 = (tmpvar_88 + (tmpvar_91 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_95;
  tmpvar_95 = texture2D (_GrabTexture, P_94).y;
  green_84 = tmpvar_95;
  highp vec2 P_96;
  P_96 = (tmpvar_88 + (tmpvar_91 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_97;
  tmpvar_97 = texture2D (_GrabTexture, P_96).z;
  blue_83 = tmpvar_97;
  highp vec4 tmpvar_98;
  tmpvar_98.x = redAlpha_85.x;
  tmpvar_98.y = green_84;
  tmpvar_98.z = blue_83;
  tmpvar_98.w = redAlpha_85.w;
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_98 * (1.0 - color_80.w)).xyz;
  color_80.xyz = (color_80.xyz + tmpvar_99);
  color_80.w = 1.0;
  c_6 = color_80;
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
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
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
varying highp vec4 xlv_TEXCOORD7;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  mediump vec3 tmpvar_5;
  highp vec4 tmpvar_6;
  highp vec4 tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_1.xyz;
  tmpvar_7 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_8));
  highp vec4 o_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tmpvar_7 * 0.5);
  highp vec2 tmpvar_11;
  tmpvar_11.x = tmpvar_10.x;
  tmpvar_11.y = (tmpvar_10.y * _ProjectionParams.x);
  o_9.xy = (tmpvar_11 + tmpvar_10.w);
  o_9.zw = tmpvar_7.zw;
  highp vec4 tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = tmpvar_1.xyz;
  tmpvar_12 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  highp vec4 o_24;
  highp vec4 tmpvar_25;
  tmpvar_25 = (tmpvar_12 * 0.5);
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_25.x;
  tmpvar_26.y = (tmpvar_25.y * _ProjectionParams.x);
  o_24.xy = (tmpvar_26 + tmpvar_25.w);
  o_24.zw = tmpvar_12.zw;
  highp vec3 lightColor0_27;
  lightColor0_27 = unity_LightColor[0].xyz;
  highp vec3 lightColor1_28;
  lightColor1_28 = unity_LightColor[1].xyz;
  highp vec3 lightColor2_29;
  lightColor2_29 = unity_LightColor[2].xyz;
  highp vec3 lightColor3_30;
  lightColor3_30 = unity_LightColor[3].xyz;
  highp vec4 lightAttenSq_31;
  lightAttenSq_31 = unity_4LightAtten0;
  highp vec3 col_32;
  highp vec4 ndotl_33;
  highp vec4 lengthSq_34;
  highp vec4 tmpvar_35;
  tmpvar_35 = (unity_4LightPosX0 - tmpvar_14.x);
  highp vec4 tmpvar_36;
  tmpvar_36 = (unity_4LightPosY0 - tmpvar_14.y);
  highp vec4 tmpvar_37;
  tmpvar_37 = (unity_4LightPosZ0 - tmpvar_14.z);
  lengthSq_34 = (tmpvar_35 * tmpvar_35);
  lengthSq_34 = (lengthSq_34 + (tmpvar_36 * tmpvar_36));
  lengthSq_34 = (lengthSq_34 + (tmpvar_37 * tmpvar_37));
  highp vec4 tmpvar_38;
  tmpvar_38 = max (lengthSq_34, vec4(1e-06, 1e-06, 1e-06, 1e-06));
  lengthSq_34 = tmpvar_38;
  ndotl_33 = (tmpvar_35 * tmpvar_16.x);
  ndotl_33 = (ndotl_33 + (tmpvar_36 * tmpvar_16.y));
  ndotl_33 = (ndotl_33 + (tmpvar_37 * tmpvar_16.z));
  highp vec4 tmpvar_39;
  tmpvar_39 = max (vec4(0.0, 0.0, 0.0, 0.0), (ndotl_33 * inversesqrt(tmpvar_38)));
  ndotl_33 = tmpvar_39;
  highp vec4 tmpvar_40;
  tmpvar_40 = (tmpvar_39 * (1.0/((1.0 + 
    (tmpvar_38 * lightAttenSq_31)
  ))));
  col_32 = (lightColor0_27 * tmpvar_40.x);
  col_32 = (col_32 + (lightColor1_28 * tmpvar_40.y));
  col_32 = (col_32 + (lightColor2_29 * tmpvar_40.z));
  col_32 = (col_32 + (lightColor3_30 * tmpvar_40.w));
  tmpvar_5 = col_32;
  mediump vec3 normal_41;
  normal_41 = tmpvar_16;
  mediump vec3 ambient_42;
  mediump vec3 x1_43;
  mediump vec4 tmpvar_44;
  tmpvar_44 = (normal_41.xyzz * normal_41.yzzx);
  x1_43.x = dot (unity_SHBr, tmpvar_44);
  x1_43.y = dot (unity_SHBg, tmpvar_44);
  x1_43.z = dot (unity_SHBb, tmpvar_44);
  ambient_42 = ((tmpvar_5 * (
    (tmpvar_5 * ((tmpvar_5 * 0.305306) + 0.6821711))
   + 0.01252288)) + (x1_43 + (unity_SHC.xyz * 
    ((normal_41.x * normal_41.x) - (normal_41.y * normal_41.y))
  )));
  tmpvar_5 = ambient_42;
  gl_Position = tmpvar_12;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_24;
  xlv_TEXCOORD5 = o_9;
  xlv_TEXCOORD6 = ambient_42;
  xlv_TEXCOORD7 = tmpvar_6;
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
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform mediump vec4 unity_SHAr;
uniform mediump vec4 unity_SHAg;
uniform mediump vec4 unity_SHAb;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
uniform mediump vec2 _depthFade;
uniform mediump float _depth;
uniform mediump vec4 _Color1;
uniform mediump vec4 _Color0;
uniform sampler2D _TextureSample0;
uniform highp vec4 _TextureSample0_ST;
uniform mediump vec4 _fadeColor;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
uniform sampler2D _GrabTexture;
uniform highp float _ChromaticAberration;
uniform mediump vec3 _Fresnel;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  mediump vec3 tmpvar_11;
  mediump vec3 tmpvar_12;
  mediump vec3 tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14.x = xlv_TEXCOORD1.w;
  tmpvar_14.y = xlv_TEXCOORD2.w;
  tmpvar_14.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_15;
  tmpvar_15 = _WorldSpaceLightPos0.xyz;
  lightDir_10 = tmpvar_15;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - tmpvar_14));
  lowp vec3 tmpvar_16;
  highp vec3 tmpvar_17;
  mediump vec3 tmpvar_18;
  lowp float tmpvar_19;
  highp vec4 ase_screenPosNorm12_20;
  tmpvar_16 = _Color2.xyz;
  highp vec4 tmpvar_21;
  tmpvar_21 = (xlv_TEXCOORD5 / xlv_TEXCOORD5.w);
  ase_screenPosNorm12_20.xyw = tmpvar_21.xyw;
  ase_screenPosNorm12_20.z = ((tmpvar_21.z * 0.5) + 0.5);
  lowp vec4 tmpvar_22;
  tmpvar_22 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD5);
  highp float z_23;
  z_23 = tmpvar_22.x;
  highp float tmpvar_24;
  tmpvar_24 = abs(((
    (1.0/(((_ZBufferParams.z * z_23) + _ZBufferParams.w)))
   - 
    (1.0/(((_ZBufferParams.z * ase_screenPosNorm12_20.z) + _ZBufferParams.w)))
  ) / _depthFade.y));
  highp float tmpvar_25;
  tmpvar_25 = clamp ((1.0 + (
    (-2.64 - (tmpvar_24 + _depth))
   / 4.49)), 0.0, 1.0);
  highp float tmpvar_26;
  tmpvar_26 = clamp ((1.0 + (
    (-2.64 - tmpvar_24)
   / 4.49)), 0.0, 1.0);
  highp vec2 tmpvar_27;
  tmpvar_27 = ((xlv_TEXCOORD0 * _TextureSample0_ST.xy) + _TextureSample0_ST.zw);
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_TextureSample0, tmpvar_27);
  tmpvar_18 = ((tmpvar_25 * _Color1) + ((tmpvar_26 * _Color0) * (tmpvar_28 * _fadeColor))).xyz;
  highp vec2 tmpvar_29;
  tmpvar_29 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_TextureSample1, tmpvar_29);
  highp float tmpvar_31;
  tmpvar_31 = float((tmpvar_30.x >= _rongjie));
  tmpvar_19 = (tmpvar_31 * _opacity);
  tmpvar_17 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD4).xyz * tmpvar_14));
  worldN_5.x = dot (xlv_TEXCOORD1.xyz, tmpvar_17);
  worldN_5.y = dot (xlv_TEXCOORD2.xyz, tmpvar_17);
  worldN_5.z = dot (xlv_TEXCOORD3.xyz, tmpvar_17);
  highp vec3 tmpvar_32;
  tmpvar_32 = normalize(worldN_5);
  worldN_5 = tmpvar_32;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_10;
  tmpvar_1 = worldViewDir_9;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_33;
  Normal_33 = tmpvar_32;
  mediump float tmpvar_34;
  highp float tmpvar_35;
  highp float smoothness_36;
  smoothness_36 = tmpvar_8;
  tmpvar_35 = (1.0 - smoothness_36);
  tmpvar_34 = tmpvar_35;
  mediump vec3 I_37;
  I_37 = -(tmpvar_1);
  mediump vec3 normalWorld_38;
  normalWorld_38 = tmpvar_32;
  mediump vec3 tmpvar_39;
  mediump vec3 tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = normalWorld_38;
  mediump vec3 x_42;
  x_42.x = dot (unity_SHAr, tmpvar_41);
  x_42.y = dot (unity_SHAg, tmpvar_41);
  x_42.z = dot (unity_SHAb, tmpvar_41);
  tmpvar_40 = max (((1.055 * 
    pow (max (vec3(0.0, 0.0, 0.0), (xlv_TEXCOORD6 + x_42)), vec3(0.4166667, 0.4166667, 0.4166667))
  ) - 0.055), vec3(0.0, 0.0, 0.0));
  mediump vec4 hdr_43;
  hdr_43 = tmpvar_2;
  mediump vec4 tmpvar_44;
  tmpvar_44.xyz = (I_37 - (2.0 * (
    dot (Normal_33, I_37)
   * Normal_33)));
  tmpvar_44.w = ((tmpvar_34 * (1.7 - 
    (0.7 * tmpvar_34)
  )) * 6.0);
  lowp vec4 tmpvar_45;
  tmpvar_45 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_44.xyz, tmpvar_44.w);
  mediump vec4 tmpvar_46;
  tmpvar_46 = tmpvar_45;
  tmpvar_39 = ((hdr_43.x * (
    (hdr_43.w * (tmpvar_46.w - 1.0))
   + 1.0)) * tmpvar_46.xyz);
  lowp vec3 tmpvar_47;
  mediump vec4 c_48;
  highp vec3 tmpvar_49;
  tmpvar_49 = normalize(tmpvar_32);
  mediump vec3 tmpvar_50;
  mediump vec3 albedo_51;
  albedo_51 = tmpvar_16;
  mediump vec3 tmpvar_52;
  tmpvar_52 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_51, vec3(tmpvar_7));
  mediump float tmpvar_53;
  tmpvar_53 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_50 = (albedo_51 * tmpvar_53);
  tmpvar_47 = tmpvar_50;
  mediump vec3 diffColor_54;
  diffColor_54 = tmpvar_47;
  mediump float alpha_55;
  alpha_55 = tmpvar_19;
  diffColor_54 = (diffColor_54 * alpha_55);
  tmpvar_47 = diffColor_54;
  mediump vec3 diffColor_56;
  diffColor_56 = tmpvar_47;
  mediump vec3 color_57;
  mediump float surfaceReduction_58;
  highp float specularTerm_59;
  highp float a2_60;
  mediump float roughness_61;
  mediump float perceptualRoughness_62;
  highp vec3 tmpvar_63;
  highp vec3 inVec_64;
  inVec_64 = (tmpvar_4 + worldViewDir_9);
  tmpvar_63 = (inVec_64 * inversesqrt(max (0.001, 
    dot (inVec_64, inVec_64)
  )));
  mediump float tmpvar_65;
  highp float tmpvar_66;
  tmpvar_66 = clamp (dot (tmpvar_49, tmpvar_4), 0.0, 1.0);
  tmpvar_65 = tmpvar_66;
  highp float tmpvar_67;
  tmpvar_67 = clamp (dot (tmpvar_49, tmpvar_63), 0.0, 1.0);
  mediump float tmpvar_68;
  highp float tmpvar_69;
  tmpvar_69 = clamp (dot (tmpvar_49, worldViewDir_9), 0.0, 1.0);
  tmpvar_68 = tmpvar_69;
  highp float tmpvar_70;
  highp float smoothness_71;
  smoothness_71 = tmpvar_8;
  tmpvar_70 = (1.0 - smoothness_71);
  perceptualRoughness_62 = tmpvar_70;
  highp float tmpvar_72;
  highp float perceptualRoughness_73;
  perceptualRoughness_73 = perceptualRoughness_62;
  tmpvar_72 = (perceptualRoughness_73 * perceptualRoughness_73);
  roughness_61 = tmpvar_72;
  mediump float tmpvar_74;
  tmpvar_74 = (roughness_61 * roughness_61);
  a2_60 = tmpvar_74;
  specularTerm_59 = ((roughness_61 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_63), 0.0, 1.0)) * (1.5 + roughness_61))
   * 
    (((tmpvar_67 * tmpvar_67) * (a2_60 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_75;
  tmpvar_75 = clamp (specularTerm_59, 0.0, 100.0);
  specularTerm_59 = tmpvar_75;
  surfaceReduction_58 = (1.0 - ((roughness_61 * perceptualRoughness_62) * 0.28));
  mediump float x_76;
  x_76 = (1.0 - tmpvar_68);
  mediump vec3 tmpvar_77;
  tmpvar_77 = mix (tmpvar_52, vec3(clamp ((tmpvar_8 + 
    (1.0 - tmpvar_53)
  ), 0.0, 1.0)), vec3(((x_76 * x_76) * (x_76 * x_76))));
  highp vec3 tmpvar_78;
  tmpvar_78 = (((
    ((diffColor_56 + (tmpvar_75 * tmpvar_52)) * tmpvar_3)
   * tmpvar_65) + (tmpvar_40 * diffColor_56)) + ((surfaceReduction_58 * tmpvar_39) * tmpvar_77));
  color_57 = tmpvar_78;
  mediump vec4 tmpvar_79;
  tmpvar_79.w = 1.0;
  tmpvar_79.xyz = color_57;
  c_48.xyz = tmpvar_79.xyz;
  c_48.w = ((1.0 - tmpvar_53) + (alpha_55 * tmpvar_53));
  c_6 = c_48;
  c_6.xyz = (c_6.xyz + tmpvar_18);
  mediump vec4 color_80;
  color_80 = c_6;
  highp vec3 ase_worldNormal_81;
  mediump vec3 tmpvar_82;
  tmpvar_82.x = tmpvar_11.z;
  tmpvar_82.y = tmpvar_12.z;
  tmpvar_82.z = tmpvar_13.z;
  ase_worldNormal_81 = tmpvar_82;
  highp float blue_83;
  highp float green_84;
  highp vec4 redAlpha_85;
  highp vec4 screenPos_86;
  screenPos_86.xzw = xlv_TEXCOORD4.xzw;
  highp float tmpvar_87;
  tmpvar_87 = (xlv_TEXCOORD4.w * 0.5);
  screenPos_86.y = (((xlv_TEXCOORD4.y - tmpvar_87) * _ProjectionParams.x) + tmpvar_87);
  highp vec2 tmpvar_88;
  tmpvar_88 = (screenPos_86 / xlv_TEXCOORD4.w).xy;
  highp vec4 tmpvar_89;
  tmpvar_89.w = 0.0;
  tmpvar_89.xyz = tmpvar_32;
  highp vec3 tmpvar_90;
  tmpvar_90 = (((
    ((_Fresnel.x + (_Fresnel.y * pow (
      (1.0 - dot (ase_worldNormal_81, normalize((_WorldSpaceCameraPos - tmpvar_14))))
    , _Fresnel.z))) - 1.0)
   * 
    (unity_MatrixV * tmpvar_89)
  ) * (1.0/(
    (xlv_TEXCOORD4.z + 1.0)
  ))) * (1.0 - dot (tmpvar_32, 
    normalize((_WorldSpaceCameraPos - tmpvar_14))
  ))).xyz;
  highp vec2 tmpvar_91;
  tmpvar_91.x = tmpvar_90.x;
  tmpvar_91.y = -((tmpvar_90.y * _ProjectionParams.x));
  lowp vec4 tmpvar_92;
  highp vec2 P_93;
  P_93 = (tmpvar_88 + tmpvar_91);
  tmpvar_92 = texture2D (_GrabTexture, P_93);
  redAlpha_85 = tmpvar_92;
  highp vec2 P_94;
  P_94 = (tmpvar_88 + (tmpvar_91 * (1.0 - _ChromaticAberration)));
  lowp float tmpvar_95;
  tmpvar_95 = texture2D (_GrabTexture, P_94).y;
  green_84 = tmpvar_95;
  highp vec2 P_96;
  P_96 = (tmpvar_88 + (tmpvar_91 * (1.0 + _ChromaticAberration)));
  lowp float tmpvar_97;
  tmpvar_97 = texture2D (_GrabTexture, P_96).z;
  blue_83 = tmpvar_97;
  highp vec4 tmpvar_98;
  tmpvar_98.x = redAlpha_85.x;
  tmpvar_98.y = green_84;
  tmpvar_98.z = blue_83;
  tmpvar_98.w = redAlpha_85.w;
  highp vec3 tmpvar_99;
  tmpvar_99 = (tmpvar_98 * (1.0 - color_80.w)).xyz;
  color_80.xyz = (color_80.xyz + tmpvar_99);
  color_80.w = 1.0;
  c_6 = color_80;
  gl_FragData[0] = c_6;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "_ALPHAPREMULTIPLY_ON" }
""
}
}
}
 Pass {
  Name "FORWARD"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  GpuProgramID 75988
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_10 = tmpvar_11;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  lowp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_12 = _Color2.xyz;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_TextureSample1, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = float((tmpvar_16.x >= _rongjie));
  tmpvar_14 = (tmpvar_17 * _opacity);
  tmpvar_13 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_18).xyz;
  highp float tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, vec2(dot (lightCoord_6, lightCoord_6))).w;
  atten_5 = tmpvar_19;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(worldN_3);
  worldN_3 = tmpvar_20;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_10;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_21;
  mediump vec4 c_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(tmpvar_20);
  mediump vec3 tmpvar_24;
  mediump vec3 albedo_25;
  albedo_25 = tmpvar_12;
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_24 = (albedo_25 * tmpvar_26);
  tmpvar_21 = tmpvar_24;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_21;
  mediump float alpha_28;
  alpha_28 = tmpvar_14;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_21 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_21;
  mediump vec2 rlPow4AndFresnelTerm_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_23, tmpvar_2), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_23, worldViewDir_9), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_23, worldViewDir_9) * tmpvar_23)
  )), tmpvar_2);
  tmpvar_35.y = (1.0 - tmpvar_33);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((tmpvar_35 * tmpvar_35) * (tmpvar_35 * tmpvar_35));
  rlPow4AndFresnelTerm_30 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = rlPow4AndFresnelTerm_30.x;
  mediump float specular_38;
  highp float smoothness_39;
  smoothness_39 = tmpvar_8;
  highp vec2 tmpvar_40;
  tmpvar_40.x = tmpvar_37;
  tmpvar_40.y = (1.0 - smoothness_39);
  highp float tmpvar_41;
  tmpvar_41 = (texture2D (unity_NHxRoughness, tmpvar_40).w * 16.0);
  specular_38 = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = ((diffColor_29 + (specular_38 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_25, vec3(tmpvar_7))
  )) * (tmpvar_1 * tmpvar_31));
  c_22.xyz = tmpvar_42.xyz;
  c_22.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_22;
  mediump vec4 color_43;
  color_43 = c_4;
  c_4 = color_43;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17).xyz;
  highp float tmpvar_18;
  tmpvar_18 = texture2D (_LightTexture0, vec2(dot (lightCoord_6, lightCoord_6))).w;
  atten_5 = tmpvar_18;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  worldN_3 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_20;
  mediump vec4 c_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_19);
  mediump vec3 tmpvar_23;
  mediump vec3 albedo_24;
  albedo_24 = tmpvar_11;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_24, vec3(tmpvar_7));
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_23 = (albedo_24 * tmpvar_26);
  tmpvar_20 = tmpvar_23;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_20;
  mediump float alpha_28;
  alpha_28 = tmpvar_13;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_20 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_20;
  mediump vec3 color_30;
  highp float specularTerm_31;
  highp float a2_32;
  mediump float roughness_33;
  mediump float perceptualRoughness_34;
  highp vec3 tmpvar_35;
  highp vec3 inVec_36;
  inVec_36 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_35 = (inVec_36 * inversesqrt(max (0.001, 
    dot (inVec_36, inVec_36)
  )));
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_22, tmpvar_2), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (tmpvar_22, tmpvar_35), 0.0, 1.0);
  highp float tmpvar_40;
  highp float smoothness_41;
  smoothness_41 = tmpvar_8;
  tmpvar_40 = (1.0 - smoothness_41);
  perceptualRoughness_34 = tmpvar_40;
  highp float tmpvar_42;
  highp float perceptualRoughness_43;
  perceptualRoughness_43 = perceptualRoughness_34;
  tmpvar_42 = (perceptualRoughness_43 * perceptualRoughness_43);
  roughness_33 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = (roughness_33 * roughness_33);
  a2_32 = tmpvar_44;
  specularTerm_31 = ((roughness_33 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_35), 0.0, 1.0)) * (1.5 + roughness_33))
   * 
    (((tmpvar_39 * tmpvar_39) * (a2_32 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((diffColor_29 + 
    (tmpvar_45 * tmpvar_25)
  ) * tmpvar_1) * tmpvar_37);
  color_30 = tmpvar_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = color_30;
  c_21.xyz = tmpvar_47.xyz;
  c_21.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_21;
  mediump vec4 color_48;
  color_48 = c_4;
  c_4 = color_48;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17).xyz;
  highp float tmpvar_18;
  tmpvar_18 = texture2D (_LightTexture0, vec2(dot (lightCoord_6, lightCoord_6))).w;
  atten_5 = tmpvar_18;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  worldN_3 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_20;
  mediump vec4 c_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_19);
  mediump vec3 tmpvar_23;
  mediump vec3 albedo_24;
  albedo_24 = tmpvar_11;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_24, vec3(tmpvar_7));
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_23 = (albedo_24 * tmpvar_26);
  tmpvar_20 = tmpvar_23;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_20;
  mediump float alpha_28;
  alpha_28 = tmpvar_13;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_20 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_20;
  mediump vec3 color_30;
  highp float specularTerm_31;
  highp float a2_32;
  mediump float roughness_33;
  mediump float perceptualRoughness_34;
  highp vec3 tmpvar_35;
  highp vec3 inVec_36;
  inVec_36 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_35 = (inVec_36 * inversesqrt(max (0.001, 
    dot (inVec_36, inVec_36)
  )));
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_22, tmpvar_2), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (tmpvar_22, tmpvar_35), 0.0, 1.0);
  highp float tmpvar_40;
  highp float smoothness_41;
  smoothness_41 = tmpvar_8;
  tmpvar_40 = (1.0 - smoothness_41);
  perceptualRoughness_34 = tmpvar_40;
  highp float tmpvar_42;
  highp float perceptualRoughness_43;
  perceptualRoughness_43 = perceptualRoughness_34;
  tmpvar_42 = (perceptualRoughness_43 * perceptualRoughness_43);
  roughness_33 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = (roughness_33 * roughness_33);
  a2_32 = tmpvar_44;
  specularTerm_31 = ((roughness_33 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_35), 0.0, 1.0)) * (1.5 + roughness_33))
   * 
    (((tmpvar_39 * tmpvar_39) * (a2_32 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((diffColor_29 + 
    (tmpvar_45 * tmpvar_25)
  ) * tmpvar_1) * tmpvar_37);
  color_30 = tmpvar_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = color_30;
  c_21.xyz = tmpvar_47.xyz;
  c_21.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_21;
  mediump vec4 color_48;
  color_48 = c_4;
  c_4 = color_48;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  highp vec3 worldViewDir_8;
  lowp vec3 lightDir_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = _WorldSpaceLightPos0.xyz;
  lightDir_9 = tmpvar_10;
  worldViewDir_8 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  highp float tmpvar_18;
  tmpvar_18 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_17).xy).w;
  atten_5 = tmpvar_18;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  worldN_3 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_20;
  mediump vec4 c_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_19);
  mediump vec3 tmpvar_23;
  mediump vec3 albedo_24;
  albedo_24 = tmpvar_11;
  mediump float tmpvar_25;
  tmpvar_25 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_23 = (albedo_24 * tmpvar_25);
  tmpvar_20 = tmpvar_23;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_20;
  mediump float alpha_27;
  alpha_27 = tmpvar_13;
  diffColor_26 = (diffColor_26 * alpha_27);
  tmpvar_20 = diffColor_26;
  mediump vec3 diffColor_28;
  diffColor_28 = tmpvar_20;
  mediump vec2 rlPow4AndFresnelTerm_29;
  mediump float tmpvar_30;
  highp float tmpvar_31;
  tmpvar_31 = clamp (dot (tmpvar_22, tmpvar_2), 0.0, 1.0);
  tmpvar_30 = tmpvar_31;
  mediump float tmpvar_32;
  highp float tmpvar_33;
  tmpvar_33 = clamp (dot (tmpvar_22, worldViewDir_8), 0.0, 1.0);
  tmpvar_32 = tmpvar_33;
  highp vec2 tmpvar_34;
  tmpvar_34.x = dot ((worldViewDir_8 - (2.0 * 
    (dot (tmpvar_22, worldViewDir_8) * tmpvar_22)
  )), tmpvar_2);
  tmpvar_34.y = (1.0 - tmpvar_32);
  highp vec2 tmpvar_35;
  tmpvar_35 = ((tmpvar_34 * tmpvar_34) * (tmpvar_34 * tmpvar_34));
  rlPow4AndFresnelTerm_29 = tmpvar_35;
  mediump float tmpvar_36;
  tmpvar_36 = rlPow4AndFresnelTerm_29.x;
  mediump float specular_37;
  highp float smoothness_38;
  smoothness_38 = tmpvar_7;
  highp vec2 tmpvar_39;
  tmpvar_39.x = tmpvar_36;
  tmpvar_39.y = (1.0 - smoothness_38);
  highp float tmpvar_40;
  tmpvar_40 = (texture2D (unity_NHxRoughness, tmpvar_39).w * 16.0);
  specular_37 = tmpvar_40;
  mediump vec4 tmpvar_41;
  tmpvar_41.w = 1.0;
  tmpvar_41.xyz = ((diffColor_28 + (specular_37 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_24, vec3(tmpvar_6))
  )) * (tmpvar_1 * tmpvar_30));
  c_21.xyz = tmpvar_41.xyz;
  c_21.w = ((1.0 - tmpvar_25) + (alpha_27 * tmpvar_25));
  c_4 = c_21;
  mediump vec4 color_42;
  color_42 = c_4;
  c_4 = color_42;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_10 = _Color2.xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TextureSample1, tmpvar_13);
  highp float tmpvar_15;
  tmpvar_15 = float((tmpvar_14.x >= _rongjie));
  tmpvar_12 = (tmpvar_15 * _opacity);
  tmpvar_11 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD4;
  highp float tmpvar_17;
  tmpvar_17 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_16).xy).w;
  atten_5 = tmpvar_17;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(worldN_3);
  worldN_3 = tmpvar_18;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_19;
  mediump vec4 c_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_18);
  mediump vec3 tmpvar_22;
  mediump vec3 albedo_23;
  albedo_23 = tmpvar_10;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_23, vec3(tmpvar_6));
  mediump float tmpvar_25;
  tmpvar_25 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_22 = (albedo_23 * tmpvar_25);
  tmpvar_19 = tmpvar_22;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_19;
  mediump float alpha_27;
  alpha_27 = tmpvar_12;
  diffColor_26 = (diffColor_26 * alpha_27);
  tmpvar_19 = diffColor_26;
  mediump vec3 diffColor_28;
  diffColor_28 = tmpvar_19;
  mediump vec3 color_29;
  highp float specularTerm_30;
  highp float a2_31;
  mediump float roughness_32;
  mediump float perceptualRoughness_33;
  highp vec3 tmpvar_34;
  highp vec3 inVec_35;
  inVec_35 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_34 = (inVec_35 * inversesqrt(max (0.001, 
    dot (inVec_35, inVec_35)
  )));
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp (dot (tmpvar_21, tmpvar_2), 0.0, 1.0);
  tmpvar_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_21, tmpvar_34), 0.0, 1.0);
  highp float tmpvar_39;
  highp float smoothness_40;
  smoothness_40 = tmpvar_7;
  tmpvar_39 = (1.0 - smoothness_40);
  perceptualRoughness_33 = tmpvar_39;
  highp float tmpvar_41;
  highp float perceptualRoughness_42;
  perceptualRoughness_42 = perceptualRoughness_33;
  tmpvar_41 = (perceptualRoughness_42 * perceptualRoughness_42);
  roughness_32 = tmpvar_41;
  mediump float tmpvar_43;
  tmpvar_43 = (roughness_32 * roughness_32);
  a2_31 = tmpvar_43;
  specularTerm_30 = ((roughness_32 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_34), 0.0, 1.0)) * (1.5 + roughness_32))
   * 
    (((tmpvar_38 * tmpvar_38) * (a2_31 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_44;
  tmpvar_44 = clamp (specularTerm_30, 0.0, 100.0);
  specularTerm_30 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = (((diffColor_28 + 
    (tmpvar_44 * tmpvar_24)
  ) * tmpvar_1) * tmpvar_36);
  color_29 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = color_29;
  c_20.xyz = tmpvar_46.xyz;
  c_20.w = ((1.0 - tmpvar_25) + (alpha_27 * tmpvar_25));
  c_4 = c_20;
  mediump vec4 color_47;
  color_47 = c_4;
  c_4 = color_47;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D _LightTexture0;
uniform highp mat4 unity_WorldToLight;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  mediump float tmpvar_6;
  mediump float tmpvar_7;
  lowp vec3 lightDir_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_10 = _Color2.xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TextureSample1, tmpvar_13);
  highp float tmpvar_15;
  tmpvar_15 = float((tmpvar_14.x >= _rongjie));
  tmpvar_12 = (tmpvar_15 * _opacity);
  tmpvar_11 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_16;
  tmpvar_16.w = 1.0;
  tmpvar_16.xyz = xlv_TEXCOORD4;
  highp float tmpvar_17;
  tmpvar_17 = texture2D (_LightTexture0, (unity_WorldToLight * tmpvar_16).xy).w;
  atten_5 = tmpvar_17;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(worldN_3);
  worldN_3 = tmpvar_18;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_19;
  mediump vec4 c_20;
  highp vec3 tmpvar_21;
  tmpvar_21 = normalize(tmpvar_18);
  mediump vec3 tmpvar_22;
  mediump vec3 albedo_23;
  albedo_23 = tmpvar_10;
  mediump vec3 tmpvar_24;
  tmpvar_24 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_23, vec3(tmpvar_6));
  mediump float tmpvar_25;
  tmpvar_25 = (0.7790837 - (tmpvar_6 * 0.7790837));
  tmpvar_22 = (albedo_23 * tmpvar_25);
  tmpvar_19 = tmpvar_22;
  mediump vec3 diffColor_26;
  diffColor_26 = tmpvar_19;
  mediump float alpha_27;
  alpha_27 = tmpvar_12;
  diffColor_26 = (diffColor_26 * alpha_27);
  tmpvar_19 = diffColor_26;
  mediump vec3 diffColor_28;
  diffColor_28 = tmpvar_19;
  mediump vec3 color_29;
  highp float specularTerm_30;
  highp float a2_31;
  mediump float roughness_32;
  mediump float perceptualRoughness_33;
  highp vec3 tmpvar_34;
  highp vec3 inVec_35;
  inVec_35 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_34 = (inVec_35 * inversesqrt(max (0.001, 
    dot (inVec_35, inVec_35)
  )));
  mediump float tmpvar_36;
  highp float tmpvar_37;
  tmpvar_37 = clamp (dot (tmpvar_21, tmpvar_2), 0.0, 1.0);
  tmpvar_36 = tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_21, tmpvar_34), 0.0, 1.0);
  highp float tmpvar_39;
  highp float smoothness_40;
  smoothness_40 = tmpvar_7;
  tmpvar_39 = (1.0 - smoothness_40);
  perceptualRoughness_33 = tmpvar_39;
  highp float tmpvar_41;
  highp float perceptualRoughness_42;
  perceptualRoughness_42 = perceptualRoughness_33;
  tmpvar_41 = (perceptualRoughness_42 * perceptualRoughness_42);
  roughness_32 = tmpvar_41;
  mediump float tmpvar_43;
  tmpvar_43 = (roughness_32 * roughness_32);
  a2_31 = tmpvar_43;
  specularTerm_30 = ((roughness_32 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_34), 0.0, 1.0)) * (1.5 + roughness_32))
   * 
    (((tmpvar_38 * tmpvar_38) * (a2_31 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_44;
  tmpvar_44 = clamp (specularTerm_30, 0.0, 100.0);
  specularTerm_30 = tmpvar_44;
  highp vec3 tmpvar_45;
  tmpvar_45 = (((diffColor_28 + 
    (tmpvar_44 * tmpvar_24)
  ) * tmpvar_1) * tmpvar_36);
  color_29 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = color_29;
  c_20.xyz = tmpvar_46.xyz;
  c_20.w = ((1.0 - tmpvar_25) + (alpha_27 * tmpvar_25));
  c_4 = c_20;
  mediump vec4 color_47;
  color_47 = c_4;
  c_4 = color_47;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  highp vec3 worldViewDir_7;
  lowp vec3 lightDir_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _WorldSpaceLightPos0.xyz;
  lightDir_8 = tmpvar_9;
  worldViewDir_7 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  lowp vec3 tmpvar_10;
  highp vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_10 = _Color2.xyz;
  highp vec2 tmpvar_13;
  tmpvar_13 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_TextureSample1, tmpvar_13);
  highp float tmpvar_15;
  tmpvar_15 = float((tmpvar_14.x >= _rongjie));
  tmpvar_12 = (tmpvar_15 * _opacity);
  tmpvar_11 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_11);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_11);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_11);
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize(worldN_3);
  worldN_3 = tmpvar_16;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_8;
  lowp vec3 tmpvar_17;
  mediump vec4 c_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(tmpvar_16);
  mediump vec3 tmpvar_20;
  mediump vec3 albedo_21;
  albedo_21 = tmpvar_10;
  mediump float tmpvar_22;
  tmpvar_22 = (0.7790837 - (tmpvar_5 * 0.7790837));
  tmpvar_20 = (albedo_21 * tmpvar_22);
  tmpvar_17 = tmpvar_20;
  mediump vec3 diffColor_23;
  diffColor_23 = tmpvar_17;
  mediump float alpha_24;
  alpha_24 = tmpvar_12;
  diffColor_23 = (diffColor_23 * alpha_24);
  tmpvar_17 = diffColor_23;
  mediump vec3 diffColor_25;
  diffColor_25 = tmpvar_17;
  mediump vec2 rlPow4AndFresnelTerm_26;
  mediump float tmpvar_27;
  highp float tmpvar_28;
  tmpvar_28 = clamp (dot (tmpvar_19, tmpvar_2), 0.0, 1.0);
  tmpvar_27 = tmpvar_28;
  mediump float tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = clamp (dot (tmpvar_19, worldViewDir_7), 0.0, 1.0);
  tmpvar_29 = tmpvar_30;
  highp vec2 tmpvar_31;
  tmpvar_31.x = dot ((worldViewDir_7 - (2.0 * 
    (dot (tmpvar_19, worldViewDir_7) * tmpvar_19)
  )), tmpvar_2);
  tmpvar_31.y = (1.0 - tmpvar_29);
  highp vec2 tmpvar_32;
  tmpvar_32 = ((tmpvar_31 * tmpvar_31) * (tmpvar_31 * tmpvar_31));
  rlPow4AndFresnelTerm_26 = tmpvar_32;
  mediump float tmpvar_33;
  tmpvar_33 = rlPow4AndFresnelTerm_26.x;
  mediump float specular_34;
  highp float smoothness_35;
  smoothness_35 = tmpvar_6;
  highp vec2 tmpvar_36;
  tmpvar_36.x = tmpvar_33;
  tmpvar_36.y = (1.0 - smoothness_35);
  highp float tmpvar_37;
  tmpvar_37 = (texture2D (unity_NHxRoughness, tmpvar_36).w * 16.0);
  specular_34 = tmpvar_37;
  mediump vec4 tmpvar_38;
  tmpvar_38.w = 1.0;
  tmpvar_38.xyz = ((diffColor_25 + (specular_34 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_21, vec3(tmpvar_5))
  )) * (tmpvar_1 * tmpvar_27));
  c_18.xyz = tmpvar_38.xyz;
  c_18.w = ((1.0 - tmpvar_22) + (alpha_24 * tmpvar_22));
  c_4 = c_18;
  mediump vec4 color_39;
  color_39 = c_4;
  c_4 = color_39;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_9 = _Color2.xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TextureSample1, tmpvar_12);
  highp float tmpvar_14;
  tmpvar_14 = float((tmpvar_13.x >= _rongjie));
  tmpvar_11 = (tmpvar_14 * _opacity);
  tmpvar_10 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(worldN_3);
  worldN_3 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  lowp vec3 tmpvar_16;
  mediump vec4 c_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  mediump vec3 tmpvar_19;
  mediump vec3 albedo_20;
  albedo_20 = tmpvar_9;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_20, vec3(tmpvar_5));
  mediump float tmpvar_22;
  tmpvar_22 = (0.7790837 - (tmpvar_5 * 0.7790837));
  tmpvar_19 = (albedo_20 * tmpvar_22);
  tmpvar_16 = tmpvar_19;
  mediump vec3 diffColor_23;
  diffColor_23 = tmpvar_16;
  mediump float alpha_24;
  alpha_24 = tmpvar_11;
  diffColor_23 = (diffColor_23 * alpha_24);
  tmpvar_16 = diffColor_23;
  mediump vec3 diffColor_25;
  diffColor_25 = tmpvar_16;
  mediump vec3 color_26;
  highp float specularTerm_27;
  highp float a2_28;
  mediump float roughness_29;
  mediump float perceptualRoughness_30;
  highp vec3 tmpvar_31;
  highp vec3 inVec_32;
  inVec_32 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_31 = (inVec_32 * inversesqrt(max (0.001, 
    dot (inVec_32, inVec_32)
  )));
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_18, tmpvar_2), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (dot (tmpvar_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_36;
  highp float smoothness_37;
  smoothness_37 = tmpvar_6;
  tmpvar_36 = (1.0 - smoothness_37);
  perceptualRoughness_30 = tmpvar_36;
  highp float tmpvar_38;
  highp float perceptualRoughness_39;
  perceptualRoughness_39 = perceptualRoughness_30;
  tmpvar_38 = (perceptualRoughness_39 * perceptualRoughness_39);
  roughness_29 = tmpvar_38;
  mediump float tmpvar_40;
  tmpvar_40 = (roughness_29 * roughness_29);
  a2_28 = tmpvar_40;
  specularTerm_27 = ((roughness_29 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_31), 0.0, 1.0)) * (1.5 + roughness_29))
   * 
    (((tmpvar_35 * tmpvar_35) * (a2_28 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_41;
  tmpvar_41 = clamp (specularTerm_27, 0.0, 100.0);
  specularTerm_27 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = (((diffColor_25 + 
    (tmpvar_41 * tmpvar_21)
  ) * tmpvar_1) * tmpvar_33);
  color_26 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = color_26;
  c_17.xyz = tmpvar_43.xyz;
  c_17.w = ((1.0 - tmpvar_22) + (alpha_24 * tmpvar_22));
  c_4 = c_17;
  mediump vec4 color_44;
  color_44 = c_4;
  c_4 = color_44;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color2;
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  mediump float tmpvar_5;
  mediump float tmpvar_6;
  lowp vec3 lightDir_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  lightDir_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  highp vec3 tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_9 = _Color2.xyz;
  highp vec2 tmpvar_12;
  tmpvar_12 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_TextureSample1, tmpvar_12);
  highp float tmpvar_14;
  tmpvar_14 = float((tmpvar_13.x >= _rongjie));
  tmpvar_11 = (tmpvar_14 * _opacity);
  tmpvar_10 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_10);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_10);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_10);
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize(worldN_3);
  worldN_3 = tmpvar_15;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_7;
  lowp vec3 tmpvar_16;
  mediump vec4 c_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize(tmpvar_15);
  mediump vec3 tmpvar_19;
  mediump vec3 albedo_20;
  albedo_20 = tmpvar_9;
  mediump vec3 tmpvar_21;
  tmpvar_21 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_20, vec3(tmpvar_5));
  mediump float tmpvar_22;
  tmpvar_22 = (0.7790837 - (tmpvar_5 * 0.7790837));
  tmpvar_19 = (albedo_20 * tmpvar_22);
  tmpvar_16 = tmpvar_19;
  mediump vec3 diffColor_23;
  diffColor_23 = tmpvar_16;
  mediump float alpha_24;
  alpha_24 = tmpvar_11;
  diffColor_23 = (diffColor_23 * alpha_24);
  tmpvar_16 = diffColor_23;
  mediump vec3 diffColor_25;
  diffColor_25 = tmpvar_16;
  mediump vec3 color_26;
  highp float specularTerm_27;
  highp float a2_28;
  mediump float roughness_29;
  mediump float perceptualRoughness_30;
  highp vec3 tmpvar_31;
  highp vec3 inVec_32;
  inVec_32 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_31 = (inVec_32 * inversesqrt(max (0.001, 
    dot (inVec_32, inVec_32)
  )));
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_18, tmpvar_2), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp float tmpvar_35;
  tmpvar_35 = clamp (dot (tmpvar_18, tmpvar_31), 0.0, 1.0);
  highp float tmpvar_36;
  highp float smoothness_37;
  smoothness_37 = tmpvar_6;
  tmpvar_36 = (1.0 - smoothness_37);
  perceptualRoughness_30 = tmpvar_36;
  highp float tmpvar_38;
  highp float perceptualRoughness_39;
  perceptualRoughness_39 = perceptualRoughness_30;
  tmpvar_38 = (perceptualRoughness_39 * perceptualRoughness_39);
  roughness_29 = tmpvar_38;
  mediump float tmpvar_40;
  tmpvar_40 = (roughness_29 * roughness_29);
  a2_28 = tmpvar_40;
  specularTerm_27 = ((roughness_29 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_31), 0.0, 1.0)) * (1.5 + roughness_29))
   * 
    (((tmpvar_35 * tmpvar_35) * (a2_28 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_41;
  tmpvar_41 = clamp (specularTerm_27, 0.0, 100.0);
  specularTerm_27 = tmpvar_41;
  highp vec3 tmpvar_42;
  tmpvar_42 = (((diffColor_25 + 
    (tmpvar_41 * tmpvar_21)
  ) * tmpvar_1) * tmpvar_33);
  color_26 = tmpvar_42;
  mediump vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = color_26;
  c_17.xyz = tmpvar_43.xyz;
  c_17.w = ((1.0 - tmpvar_22) + (alpha_24 * tmpvar_22));
  c_4 = c_17;
  mediump vec4 color_44;
  color_44 = c_4;
  c_4 = color_44;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec4 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_10 = tmpvar_11;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  lowp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_12 = _Color2.xyz;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_TextureSample1, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = float((tmpvar_16.x >= _rongjie));
  tmpvar_14 = (tmpvar_17 * _opacity);
  tmpvar_13 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_18);
  lowp float tmpvar_19;
  highp vec4 tmpvar_20;
  tmpvar_20 = texture2D (_LightTexture0, ((lightCoord_6.xy / lightCoord_6.w) + 0.5));
  tmpvar_19 = tmpvar_20.w;
  lowp float tmpvar_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = texture2D (_LightTextureB0, vec2(dot (lightCoord_6.xyz, lightCoord_6.xyz)));
  tmpvar_21 = tmpvar_22.w;
  highp float tmpvar_23;
  tmpvar_23 = ((float(
    (lightCoord_6.z > 0.0)
  ) * tmpvar_19) * tmpvar_21);
  atten_5 = tmpvar_23;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
  highp vec3 tmpvar_24;
  tmpvar_24 = normalize(worldN_3);
  worldN_3 = tmpvar_24;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_10;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_25;
  mediump vec4 c_26;
  highp vec3 tmpvar_27;
  tmpvar_27 = normalize(tmpvar_24);
  mediump vec3 tmpvar_28;
  mediump vec3 albedo_29;
  albedo_29 = tmpvar_12;
  mediump float tmpvar_30;
  tmpvar_30 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_28 = (albedo_29 * tmpvar_30);
  tmpvar_25 = tmpvar_28;
  mediump vec3 diffColor_31;
  diffColor_31 = tmpvar_25;
  mediump float alpha_32;
  alpha_32 = tmpvar_14;
  diffColor_31 = (diffColor_31 * alpha_32);
  tmpvar_25 = diffColor_31;
  mediump vec3 diffColor_33;
  diffColor_33 = tmpvar_25;
  mediump vec2 rlPow4AndFresnelTerm_34;
  mediump float tmpvar_35;
  highp float tmpvar_36;
  tmpvar_36 = clamp (dot (tmpvar_27, tmpvar_2), 0.0, 1.0);
  tmpvar_35 = tmpvar_36;
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_27, worldViewDir_9), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  highp vec2 tmpvar_39;
  tmpvar_39.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_27, worldViewDir_9) * tmpvar_27)
  )), tmpvar_2);
  tmpvar_39.y = (1.0 - tmpvar_37);
  highp vec2 tmpvar_40;
  tmpvar_40 = ((tmpvar_39 * tmpvar_39) * (tmpvar_39 * tmpvar_39));
  rlPow4AndFresnelTerm_34 = tmpvar_40;
  mediump float tmpvar_41;
  tmpvar_41 = rlPow4AndFresnelTerm_34.x;
  mediump float specular_42;
  highp float smoothness_43;
  smoothness_43 = tmpvar_8;
  highp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_41;
  tmpvar_44.y = (1.0 - smoothness_43);
  highp float tmpvar_45;
  tmpvar_45 = (texture2D (unity_NHxRoughness, tmpvar_44).w * 16.0);
  specular_42 = tmpvar_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.w = 1.0;
  tmpvar_46.xyz = ((diffColor_33 + (specular_42 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_29, vec3(tmpvar_7))
  )) * (tmpvar_1 * tmpvar_35));
  c_26.xyz = tmpvar_46.xyz;
  c_26.w = ((1.0 - tmpvar_30) + (alpha_32 * tmpvar_30));
  c_4 = c_26;
  mediump vec4 color_47;
  color_47 = c_4;
  c_4 = color_47;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec4 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17);
  lowp float tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, ((lightCoord_6.xy / lightCoord_6.w) + 0.5));
  tmpvar_18 = tmpvar_19.w;
  lowp float tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(dot (lightCoord_6.xyz, lightCoord_6.xyz)));
  tmpvar_20 = tmpvar_21.w;
  highp float tmpvar_22;
  tmpvar_22 = ((float(
    (lightCoord_6.z > 0.0)
  ) * tmpvar_18) * tmpvar_20);
  atten_5 = tmpvar_22;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(worldN_3);
  worldN_3 = tmpvar_23;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_24;
  mediump vec4 c_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_23);
  mediump vec3 tmpvar_27;
  mediump vec3 albedo_28;
  albedo_28 = tmpvar_11;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_28, vec3(tmpvar_7));
  mediump float tmpvar_30;
  tmpvar_30 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_27 = (albedo_28 * tmpvar_30);
  tmpvar_24 = tmpvar_27;
  mediump vec3 diffColor_31;
  diffColor_31 = tmpvar_24;
  mediump float alpha_32;
  alpha_32 = tmpvar_13;
  diffColor_31 = (diffColor_31 * alpha_32);
  tmpvar_24 = diffColor_31;
  mediump vec3 diffColor_33;
  diffColor_33 = tmpvar_24;
  mediump vec3 color_34;
  highp float specularTerm_35;
  highp float a2_36;
  mediump float roughness_37;
  mediump float perceptualRoughness_38;
  highp vec3 tmpvar_39;
  highp vec3 inVec_40;
  inVec_40 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_39 = (inVec_40 * inversesqrt(max (0.001, 
    dot (inVec_40, inVec_40)
  )));
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (tmpvar_26, tmpvar_2), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (tmpvar_26, tmpvar_39), 0.0, 1.0);
  highp float tmpvar_44;
  highp float smoothness_45;
  smoothness_45 = tmpvar_8;
  tmpvar_44 = (1.0 - smoothness_45);
  perceptualRoughness_38 = tmpvar_44;
  highp float tmpvar_46;
  highp float perceptualRoughness_47;
  perceptualRoughness_47 = perceptualRoughness_38;
  tmpvar_46 = (perceptualRoughness_47 * perceptualRoughness_47);
  roughness_37 = tmpvar_46;
  mediump float tmpvar_48;
  tmpvar_48 = (roughness_37 * roughness_37);
  a2_36 = tmpvar_48;
  specularTerm_35 = ((roughness_37 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_39), 0.0, 1.0)) * (1.5 + roughness_37))
   * 
    (((tmpvar_43 * tmpvar_43) * (a2_36 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_49;
  tmpvar_49 = clamp (specularTerm_35, 0.0, 100.0);
  specularTerm_35 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = (((diffColor_33 + 
    (tmpvar_49 * tmpvar_29)
  ) * tmpvar_1) * tmpvar_41);
  color_34 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = color_34;
  c_25.xyz = tmpvar_51.xyz;
  c_25.w = ((1.0 - tmpvar_30) + (alpha_32 * tmpvar_30));
  c_4 = c_25;
  mediump vec4 color_52;
  color_52 = c_4;
  c_4 = color_52;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec4 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17);
  lowp float tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_LightTexture0, ((lightCoord_6.xy / lightCoord_6.w) + 0.5));
  tmpvar_18 = tmpvar_19.w;
  lowp float tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_LightTextureB0, vec2(dot (lightCoord_6.xyz, lightCoord_6.xyz)));
  tmpvar_20 = tmpvar_21.w;
  highp float tmpvar_22;
  tmpvar_22 = ((float(
    (lightCoord_6.z > 0.0)
  ) * tmpvar_18) * tmpvar_20);
  atten_5 = tmpvar_22;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(worldN_3);
  worldN_3 = tmpvar_23;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_24;
  mediump vec4 c_25;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_23);
  mediump vec3 tmpvar_27;
  mediump vec3 albedo_28;
  albedo_28 = tmpvar_11;
  mediump vec3 tmpvar_29;
  tmpvar_29 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_28, vec3(tmpvar_7));
  mediump float tmpvar_30;
  tmpvar_30 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_27 = (albedo_28 * tmpvar_30);
  tmpvar_24 = tmpvar_27;
  mediump vec3 diffColor_31;
  diffColor_31 = tmpvar_24;
  mediump float alpha_32;
  alpha_32 = tmpvar_13;
  diffColor_31 = (diffColor_31 * alpha_32);
  tmpvar_24 = diffColor_31;
  mediump vec3 diffColor_33;
  diffColor_33 = tmpvar_24;
  mediump vec3 color_34;
  highp float specularTerm_35;
  highp float a2_36;
  mediump float roughness_37;
  mediump float perceptualRoughness_38;
  highp vec3 tmpvar_39;
  highp vec3 inVec_40;
  inVec_40 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_39 = (inVec_40 * inversesqrt(max (0.001, 
    dot (inVec_40, inVec_40)
  )));
  mediump float tmpvar_41;
  highp float tmpvar_42;
  tmpvar_42 = clamp (dot (tmpvar_26, tmpvar_2), 0.0, 1.0);
  tmpvar_41 = tmpvar_42;
  highp float tmpvar_43;
  tmpvar_43 = clamp (dot (tmpvar_26, tmpvar_39), 0.0, 1.0);
  highp float tmpvar_44;
  highp float smoothness_45;
  smoothness_45 = tmpvar_8;
  tmpvar_44 = (1.0 - smoothness_45);
  perceptualRoughness_38 = tmpvar_44;
  highp float tmpvar_46;
  highp float perceptualRoughness_47;
  perceptualRoughness_47 = perceptualRoughness_38;
  tmpvar_46 = (perceptualRoughness_47 * perceptualRoughness_47);
  roughness_37 = tmpvar_46;
  mediump float tmpvar_48;
  tmpvar_48 = (roughness_37 * roughness_37);
  a2_36 = tmpvar_48;
  specularTerm_35 = ((roughness_37 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_39), 0.0, 1.0)) * (1.5 + roughness_37))
   * 
    (((tmpvar_43 * tmpvar_43) * (a2_36 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_49;
  tmpvar_49 = clamp (specularTerm_35, 0.0, 100.0);
  specularTerm_35 = tmpvar_49;
  highp vec3 tmpvar_50;
  tmpvar_50 = (((diffColor_33 + 
    (tmpvar_49 * tmpvar_29)
  ) * tmpvar_1) * tmpvar_41);
  color_34 = tmpvar_50;
  mediump vec4 tmpvar_51;
  tmpvar_51.w = 1.0;
  tmpvar_51.xyz = color_34;
  c_25.xyz = tmpvar_51.xyz;
  c_25.w = ((1.0 - tmpvar_30) + (alpha_32 * tmpvar_30));
  c_4 = c_25;
  mediump vec4 color_52;
  color_52 = c_4;
  c_4 = color_52;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  highp vec3 worldViewDir_9;
  lowp vec3 lightDir_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_10 = tmpvar_11;
  worldViewDir_9 = normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4));
  lowp vec3 tmpvar_12;
  highp vec3 tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_12 = _Color2.xyz;
  highp vec2 tmpvar_15;
  tmpvar_15 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_TextureSample1, tmpvar_15);
  highp float tmpvar_17;
  tmpvar_17 = float((tmpvar_16.x >= _rongjie));
  tmpvar_14 = (tmpvar_17 * _opacity);
  tmpvar_13 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_18;
  tmpvar_18.w = 1.0;
  tmpvar_18.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_18).xyz;
  highp float tmpvar_19;
  tmpvar_19 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_6, lightCoord_6))).w * textureCube (_LightTexture0, lightCoord_6).w);
  atten_5 = tmpvar_19;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_13);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_13);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_13);
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(worldN_3);
  worldN_3 = tmpvar_20;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_10;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_21;
  mediump vec4 c_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = normalize(tmpvar_20);
  mediump vec3 tmpvar_24;
  mediump vec3 albedo_25;
  albedo_25 = tmpvar_12;
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_24 = (albedo_25 * tmpvar_26);
  tmpvar_21 = tmpvar_24;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_21;
  mediump float alpha_28;
  alpha_28 = tmpvar_14;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_21 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_21;
  mediump vec2 rlPow4AndFresnelTerm_30;
  mediump float tmpvar_31;
  highp float tmpvar_32;
  tmpvar_32 = clamp (dot (tmpvar_23, tmpvar_2), 0.0, 1.0);
  tmpvar_31 = tmpvar_32;
  mediump float tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = clamp (dot (tmpvar_23, worldViewDir_9), 0.0, 1.0);
  tmpvar_33 = tmpvar_34;
  highp vec2 tmpvar_35;
  tmpvar_35.x = dot ((worldViewDir_9 - (2.0 * 
    (dot (tmpvar_23, worldViewDir_9) * tmpvar_23)
  )), tmpvar_2);
  tmpvar_35.y = (1.0 - tmpvar_33);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((tmpvar_35 * tmpvar_35) * (tmpvar_35 * tmpvar_35));
  rlPow4AndFresnelTerm_30 = tmpvar_36;
  mediump float tmpvar_37;
  tmpvar_37 = rlPow4AndFresnelTerm_30.x;
  mediump float specular_38;
  highp float smoothness_39;
  smoothness_39 = tmpvar_8;
  highp vec2 tmpvar_40;
  tmpvar_40.x = tmpvar_37;
  tmpvar_40.y = (1.0 - smoothness_39);
  highp float tmpvar_41;
  tmpvar_41 = (texture2D (unity_NHxRoughness, tmpvar_40).w * 16.0);
  specular_38 = tmpvar_41;
  mediump vec4 tmpvar_42;
  tmpvar_42.w = 1.0;
  tmpvar_42.xyz = ((diffColor_29 + (specular_38 * 
    mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_25, vec3(tmpvar_7))
  )) * (tmpvar_1 * tmpvar_31));
  c_22.xyz = tmpvar_42.xyz;
  c_22.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_22;
  mediump vec4 color_43;
  color_43 = c_4;
  c_4 = color_43;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17).xyz;
  highp float tmpvar_18;
  tmpvar_18 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_6, lightCoord_6))).w * textureCube (_LightTexture0, lightCoord_6).w);
  atten_5 = tmpvar_18;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  worldN_3 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_20;
  mediump vec4 c_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_19);
  mediump vec3 tmpvar_23;
  mediump vec3 albedo_24;
  albedo_24 = tmpvar_11;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_24, vec3(tmpvar_7));
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_23 = (albedo_24 * tmpvar_26);
  tmpvar_20 = tmpvar_23;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_20;
  mediump float alpha_28;
  alpha_28 = tmpvar_13;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_20 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_20;
  mediump vec3 color_30;
  highp float specularTerm_31;
  highp float a2_32;
  mediump float roughness_33;
  mediump float perceptualRoughness_34;
  highp vec3 tmpvar_35;
  highp vec3 inVec_36;
  inVec_36 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_35 = (inVec_36 * inversesqrt(max (0.001, 
    dot (inVec_36, inVec_36)
  )));
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_22, tmpvar_2), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (tmpvar_22, tmpvar_35), 0.0, 1.0);
  highp float tmpvar_40;
  highp float smoothness_41;
  smoothness_41 = tmpvar_8;
  tmpvar_40 = (1.0 - smoothness_41);
  perceptualRoughness_34 = tmpvar_40;
  highp float tmpvar_42;
  highp float perceptualRoughness_43;
  perceptualRoughness_43 = perceptualRoughness_34;
  tmpvar_42 = (perceptualRoughness_43 * perceptualRoughness_43);
  roughness_33 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = (roughness_33 * roughness_33);
  a2_32 = tmpvar_44;
  specularTerm_31 = ((roughness_33 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_35), 0.0, 1.0)) * (1.5 + roughness_33))
   * 
    (((tmpvar_39 * tmpvar_39) * (a2_32 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((diffColor_29 + 
    (tmpvar_45 * tmpvar_25)
  ) * tmpvar_1) * tmpvar_37);
  color_30 = tmpvar_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = color_30;
  c_21.xyz = tmpvar_47.xyz;
  c_21.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_21;
  mediump vec4 color_48;
  color_48 = c_4;
  c_4 = color_48;
  gl_FragData[0] = c_4;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
varying highp vec4 xlv_TEXCOORD6;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 tmpvar_10;
  highp vec4 tmpvar_11;
  tmpvar_11.w = 1.0;
  tmpvar_11.xyz = tmpvar_1.xyz;
  tmpvar_10 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_11));
  highp mat3 tmpvar_12;
  tmpvar_12[0] = unity_WorldToObject[0].xyz;
  tmpvar_12[1] = unity_WorldToObject[1].xyz;
  tmpvar_12[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_13;
  tmpvar_13 = normalize((_glesNormal * tmpvar_12));
  highp mat3 tmpvar_14;
  tmpvar_14[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_14[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_14[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_15;
  tmpvar_15 = normalize((tmpvar_14 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (((tmpvar_13.yzx * worldTangent_4.zxy) - (tmpvar_13.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = worldTangent_4.x;
  tmpvar_18.y = worldBinormal_2.x;
  tmpvar_18.z = tmpvar_13.x;
  highp vec3 tmpvar_19;
  tmpvar_19.x = worldTangent_4.y;
  tmpvar_19.y = worldBinormal_2.y;
  tmpvar_19.z = tmpvar_13.y;
  highp vec3 tmpvar_20;
  tmpvar_20.x = worldTangent_4.z;
  tmpvar_20.y = worldBinormal_2.z;
  tmpvar_20.z = tmpvar_13.z;
  highp vec4 o_21;
  highp vec4 tmpvar_22;
  tmpvar_22 = (tmpvar_10 * 0.5);
  highp vec2 tmpvar_23;
  tmpvar_23.x = tmpvar_22.x;
  tmpvar_23.y = (tmpvar_22.y * _ProjectionParams.x);
  o_21.xy = (tmpvar_23 + tmpvar_22.w);
  o_21.zw = tmpvar_10.zw;
  gl_Position = tmpvar_10;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_18;
  xlv_TEXCOORD2 = tmpvar_19;
  xlv_TEXCOORD3 = tmpvar_20;
  xlv_TEXCOORD4 = (unity_ObjectToWorld * _glesVertex).xyz;
  xlv_TEXCOORD5 = o_21;
  xlv_TEXCOORD6 = o_7;
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
uniform highp float _rongjie;
uniform sampler2D _TextureSample1;
uniform highp vec4 _TextureSample1_ST;
uniform mediump float _opacity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec3 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 worldN_3;
  lowp vec4 c_4;
  lowp float atten_5;
  highp vec3 lightCoord_6;
  mediump float tmpvar_7;
  mediump float tmpvar_8;
  lowp vec3 lightDir_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((_WorldSpaceLightPos0.xyz - xlv_TEXCOORD4));
  lightDir_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  highp vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_11 = _Color2.xyz;
  highp vec2 tmpvar_14;
  tmpvar_14 = ((xlv_TEXCOORD0 * _TextureSample1_ST.xy) + _TextureSample1_ST.zw);
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2D (_TextureSample1, tmpvar_14);
  highp float tmpvar_16;
  tmpvar_16 = float((tmpvar_15.x >= _rongjie));
  tmpvar_13 = (tmpvar_16 * _opacity);
  tmpvar_12 = (vec3(0.0, 0.0, 1.0) + ((1e-05 * xlv_TEXCOORD5).xyz * xlv_TEXCOORD4));
  highp vec4 tmpvar_17;
  tmpvar_17.w = 1.0;
  tmpvar_17.xyz = xlv_TEXCOORD4;
  lightCoord_6 = (unity_WorldToLight * tmpvar_17).xyz;
  highp float tmpvar_18;
  tmpvar_18 = (texture2D (_LightTextureB0, vec2(dot (lightCoord_6, lightCoord_6))).w * textureCube (_LightTexture0, lightCoord_6).w);
  atten_5 = tmpvar_18;
  worldN_3.x = dot (xlv_TEXCOORD1, tmpvar_12);
  worldN_3.y = dot (xlv_TEXCOORD2, tmpvar_12);
  worldN_3.z = dot (xlv_TEXCOORD3, tmpvar_12);
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(worldN_3);
  worldN_3 = tmpvar_19;
  tmpvar_1 = _LightColor0.xyz;
  tmpvar_2 = lightDir_9;
  tmpvar_1 = (tmpvar_1 * atten_5);
  lowp vec3 tmpvar_20;
  mediump vec4 c_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = normalize(tmpvar_19);
  mediump vec3 tmpvar_23;
  mediump vec3 albedo_24;
  albedo_24 = tmpvar_11;
  mediump vec3 tmpvar_25;
  tmpvar_25 = mix (vec3(0.2209163, 0.2209163, 0.2209163), albedo_24, vec3(tmpvar_7));
  mediump float tmpvar_26;
  tmpvar_26 = (0.7790837 - (tmpvar_7 * 0.7790837));
  tmpvar_23 = (albedo_24 * tmpvar_26);
  tmpvar_20 = tmpvar_23;
  mediump vec3 diffColor_27;
  diffColor_27 = tmpvar_20;
  mediump float alpha_28;
  alpha_28 = tmpvar_13;
  diffColor_27 = (diffColor_27 * alpha_28);
  tmpvar_20 = diffColor_27;
  mediump vec3 diffColor_29;
  diffColor_29 = tmpvar_20;
  mediump vec3 color_30;
  highp float specularTerm_31;
  highp float a2_32;
  mediump float roughness_33;
  mediump float perceptualRoughness_34;
  highp vec3 tmpvar_35;
  highp vec3 inVec_36;
  inVec_36 = (tmpvar_2 + normalize((_WorldSpaceCameraPos - xlv_TEXCOORD4)));
  tmpvar_35 = (inVec_36 * inversesqrt(max (0.001, 
    dot (inVec_36, inVec_36)
  )));
  mediump float tmpvar_37;
  highp float tmpvar_38;
  tmpvar_38 = clamp (dot (tmpvar_22, tmpvar_2), 0.0, 1.0);
  tmpvar_37 = tmpvar_38;
  highp float tmpvar_39;
  tmpvar_39 = clamp (dot (tmpvar_22, tmpvar_35), 0.0, 1.0);
  highp float tmpvar_40;
  highp float smoothness_41;
  smoothness_41 = tmpvar_8;
  tmpvar_40 = (1.0 - smoothness_41);
  perceptualRoughness_34 = tmpvar_40;
  highp float tmpvar_42;
  highp float perceptualRoughness_43;
  perceptualRoughness_43 = perceptualRoughness_34;
  tmpvar_42 = (perceptualRoughness_43 * perceptualRoughness_43);
  roughness_33 = tmpvar_42;
  mediump float tmpvar_44;
  tmpvar_44 = (roughness_33 * roughness_33);
  a2_32 = tmpvar_44;
  specularTerm_31 = ((roughness_33 / (
    (max (0.32, clamp (dot (tmpvar_2, tmpvar_35), 0.0, 1.0)) * (1.5 + roughness_33))
   * 
    (((tmpvar_39 * tmpvar_39) * (a2_32 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_45;
  tmpvar_45 = clamp (specularTerm_31, 0.0, 100.0);
  specularTerm_31 = tmpvar_45;
  highp vec3 tmpvar_46;
  tmpvar_46 = (((diffColor_29 + 
    (tmpvar_45 * tmpvar_25)
  ) * tmpvar_1) * tmpvar_37);
  color_30 = tmpvar_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.w = 1.0;
  tmpvar_47.xyz = color_30;
  c_21.xyz = tmpvar_47.xyz;
  c_21.w = ((1.0 - tmpvar_26) + (alpha_28 * tmpvar_26));
  c_4 = c_21;
  mediump vec4 color_48;
  color_48 = c_4;
  c_4 = color_48;
  gl_FragData[0] = c_4;
}


#endif
"
}
}
Program "fp" {
SubProgram "gles hw_tier00 " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "SPOT" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "POINT_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL_COOKIE" "_ALPHAPREMULTIPLY_ON" }
""
}
}
}
 Pass {
  Name "META"
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "META" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZWrite Off
  Cull Off
  GpuProgramID 173565
Program "vp" {
SubProgram "gles hw_tier00 " {
Keywords { "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 vertex_10;
  vertex_10 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_10.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_11;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_11 = 0.0001;
    } else {
      tmpvar_11 = 0.0;
    };
    vertex_10.z = tmpvar_11;
  };
  if (unity_MetaVertexControl.y) {
    vertex_10.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_12;
    if ((vertex_10.z > 0.0)) {
      tmpvar_12 = 0.0001;
    } else {
      tmpvar_12 = 0.0;
    };
    vertex_10.z = tmpvar_12;
  };
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = vertex_10.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
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
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
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
Keywords { "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 vertex_10;
  vertex_10 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_10.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_11;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_11 = 0.0001;
    } else {
      tmpvar_11 = 0.0;
    };
    vertex_10.z = tmpvar_11;
  };
  if (unity_MetaVertexControl.y) {
    vertex_10.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_12;
    if ((vertex_10.z > 0.0)) {
      tmpvar_12 = 0.0001;
    } else {
      tmpvar_12 = 0.0;
    };
    vertex_10.z = tmpvar_12;
  };
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = vertex_10.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
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
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
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
Keywords { "_ALPHAPREMULTIPLY_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord2;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_WorldToObject;
uniform highp vec4 unity_WorldTransformParams;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 unity_DynamicLightmapST;
uniform bvec4 unity_MetaVertexControl;
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _glesVertex;
  lowp vec3 worldBinormal_2;
  lowp float tangentSign_3;
  lowp vec3 worldTangent_4;
  highp vec4 tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6.w = 1.0;
  tmpvar_6.xyz = tmpvar_1.xyz;
  tmpvar_5 = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_6));
  highp vec4 o_7;
  highp vec4 tmpvar_8;
  tmpvar_8 = (tmpvar_5 * 0.5);
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_8.x;
  tmpvar_9.y = (tmpvar_8.y * _ProjectionParams.x);
  o_7.xy = (tmpvar_9 + tmpvar_8.w);
  o_7.zw = tmpvar_5.zw;
  highp vec4 vertex_10;
  vertex_10 = tmpvar_1;
  if (unity_MetaVertexControl.x) {
    vertex_10.xy = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
    highp float tmpvar_11;
    if ((_glesVertex.z > 0.0)) {
      tmpvar_11 = 0.0001;
    } else {
      tmpvar_11 = 0.0;
    };
    vertex_10.z = tmpvar_11;
  };
  if (unity_MetaVertexControl.y) {
    vertex_10.xy = ((_glesMultiTexCoord2.xy * unity_DynamicLightmapST.xy) + unity_DynamicLightmapST.zw);
    highp float tmpvar_12;
    if ((vertex_10.z > 0.0)) {
      tmpvar_12 = 0.0001;
    } else {
      tmpvar_12 = 0.0;
    };
    vertex_10.z = tmpvar_12;
  };
  highp vec4 tmpvar_13;
  tmpvar_13.w = 1.0;
  tmpvar_13.xyz = vertex_10.xyz;
  highp vec3 tmpvar_14;
  tmpvar_14 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_15;
  tmpvar_15[0] = unity_WorldToObject[0].xyz;
  tmpvar_15[1] = unity_WorldToObject[1].xyz;
  tmpvar_15[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_16;
  tmpvar_16 = normalize((_glesNormal * tmpvar_15));
  highp mat3 tmpvar_17;
  tmpvar_17[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_17[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_17[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((tmpvar_17 * _glesTANGENT.xyz));
  worldTangent_4 = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_3 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = (((tmpvar_16.yzx * worldTangent_4.zxy) - (tmpvar_16.zxy * worldTangent_4.yzx)) * tangentSign_3);
  worldBinormal_2 = tmpvar_20;
  highp vec4 tmpvar_21;
  tmpvar_21.x = worldTangent_4.x;
  tmpvar_21.y = worldBinormal_2.x;
  tmpvar_21.z = tmpvar_16.x;
  tmpvar_21.w = tmpvar_14.x;
  highp vec4 tmpvar_22;
  tmpvar_22.x = worldTangent_4.y;
  tmpvar_22.y = worldBinormal_2.y;
  tmpvar_22.z = tmpvar_16.y;
  tmpvar_22.w = tmpvar_14.y;
  highp vec4 tmpvar_23;
  tmpvar_23.x = worldTangent_4.z;
  tmpvar_23.y = worldBinormal_2.z;
  tmpvar_23.z = tmpvar_16.z;
  tmpvar_23.w = tmpvar_14.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_13));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_21;
  xlv_TEXCOORD2 = tmpvar_22;
  xlv_TEXCOORD3 = tmpvar_23;
  xlv_TEXCOORD4 = o_7;
}


#endif
#ifdef FRAGMENT
uniform highp vec4 _ZBufferParams;
uniform mediump vec4 _Color2;
uniform sampler2D _CameraDepthTexture;
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
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec4 ase_screenPosNorm12_5;
  tmpvar_3 = _Color2.xyz;
  highp vec4 tmpvar_6;
  tmpvar_6 = (xlv_TEXCOORD4 / xlv_TEXCOORD4.w);
  ase_screenPosNorm12_5.xyw = tmpvar_6.xyw;
  ase_screenPosNorm12_5.z = ((tmpvar_6.z * 0.5) + 0.5);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD4);
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
Keywords { "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "_ALPHAPREMULTIPLY_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "_ALPHAPREMULTIPLY_ON" }
""
}
}
}
}
CustomEditor "ASEMaterialInspector"
}