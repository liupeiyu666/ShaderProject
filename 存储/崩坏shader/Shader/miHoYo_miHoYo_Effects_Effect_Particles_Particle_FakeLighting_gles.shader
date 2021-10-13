//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "miHoYo/miHoYo_Effects/Effect_Particles/Particle_FakeLighting" {
Properties {
[Toggle] _NormalMapToggle ("NormalMapToggle", Float) = 0
_NormalMap ("NormalMap", 2D) = "bump" { }
_NormaTexlScale ("NormaTexlScale", Range(0, 20)) = 1
_WorldNormalScale ("WorldNormalScale", Range(0, 50)) = 1
_LightingScale ("LightingScale", Range(-1, 1)) = 0
_LightColor ("LightColor", Color) = (1,1,1,0)
_DarkColor ("DarkColor", Color) = (0,0,0,0)
_ColorBrightness ("ColorBrightness", Float) = 1
_BaseTex ("BaseTex", 2D) = "white" { }
[Toggle] _MatcapToggle ("MatcapToggle", Float) = 0
_Matcap ("Matcap", 2D) = "white" { }
_MatcapSize ("MatcapSize", Range(0, 2)) = 1
_Matcap_Light ("Matcap_Light", Float) = 1
_DayColor ("DayColor", Color) = (1,1,1,1)
_texcoord ("", 2D) = "white" { }
__dirty ("", Float) = 1
[Header(Cull Mode)] [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2
[Header(Blend Mode)] [Enum(UnityEngine.Rendering.BlendMode)] _SrcBlendMode ("Src Blend Mode", Float) = 1
[Enum(UnityEngine.Rendering.BlendMode)] _DstBlendMode ("Dst Blend Mode", Float) = 0
[Enum(UnityEngine.Rendering.BlendOp)] _BlendOP ("BlendOp Mode", Float) = 0
[Header(Depth Mode)] [Enum(Off, 0, On, 1)] _Zwrite ("ZWrite Mode", Float) = 1
[Enum(UnityEngine.Rendering.CompareFunction)] _Ztest ("ZTest Mode", Float) = 4
}
SubShader {
 LOD 200
 Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
 Pass {
  Name "FORWARD"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 26734
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec4 hdr_59;
  hdr_59 = tmpvar_2;
  mediump vec4 tmpvar_60;
  tmpvar_60.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_60.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_61;
  tmpvar_61 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_60.xyz, tmpvar_60.w);
  mediump vec4 tmpvar_62;
  tmpvar_62 = tmpvar_61;
  lowp vec3 tmpvar_63;
  mediump vec4 c_64;
  highp vec3 tmpvar_65;
  tmpvar_65 = normalize(tmpvar_53);
  mediump vec3 tmpvar_66;
  tmpvar_66 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_63 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_67;
  diffColor_67 = tmpvar_63;
  mediump float alpha_68;
  alpha_68 = tmpvar_20;
  tmpvar_63 = diffColor_67;
  mediump vec3 diffColor_69;
  diffColor_69 = tmpvar_63;
  mediump vec3 color_70;
  mediump vec2 rlPow4AndFresnelTerm_71;
  mediump float tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = clamp (dot (tmpvar_65, tmpvar_4), 0.0, 1.0);
  tmpvar_72 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (dot (tmpvar_65, worldViewDir_11), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  highp vec2 tmpvar_76;
  tmpvar_76.x = dot ((worldViewDir_11 - (2.0 * 
    (dot (tmpvar_65, worldViewDir_11) * tmpvar_65)
  )), tmpvar_4);
  tmpvar_76.y = (1.0 - tmpvar_74);
  highp vec2 tmpvar_77;
  tmpvar_77 = ((tmpvar_76 * tmpvar_76) * (tmpvar_76 * tmpvar_76));
  rlPow4AndFresnelTerm_71 = tmpvar_77;
  mediump float tmpvar_78;
  tmpvar_78 = rlPow4AndFresnelTerm_71.x;
  mediump float specular_79;
  highp float smoothness_80;
  smoothness_80 = tmpvar_9;
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_78;
  tmpvar_81.y = (1.0 - smoothness_80);
  highp float tmpvar_82;
  tmpvar_82 = (texture2D (unity_NHxRoughness, tmpvar_81).w * 16.0);
  specular_79 = tmpvar_82;
  color_70 = ((diffColor_69 + (specular_79 * tmpvar_66)) * (tmpvar_3 * tmpvar_72));
  color_70 = (color_70 + ((
    (hdr_59.x * ((hdr_59.w * (tmpvar_62.w - 1.0)) + 1.0))
   * tmpvar_62.xyz) * mix (tmpvar_66, vec3(
    clamp ((tmpvar_9 + (1.0 - (0.7790837 - 
      (tmpvar_8 * 0.7790837)
    ))), 0.0, 1.0)
  ), rlPow4AndFresnelTerm_71.yyy)));
  mediump vec4 tmpvar_83;
  tmpvar_83.w = 1.0;
  tmpvar_83.xyz = color_70;
  c_64.xyz = tmpvar_83.xyz;
  c_64.w = alpha_68;
  c_6 = c_64;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" }
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec3 tmpvar_59;
  mediump vec4 hdr_60;
  hdr_60 = tmpvar_2;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_61.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_62;
  tmpvar_62 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_61.xyz, tmpvar_61.w);
  mediump vec4 tmpvar_63;
  tmpvar_63 = tmpvar_62;
  tmpvar_59 = ((hdr_60.x * (
    (hdr_60.w * (tmpvar_63.w - 1.0))
   + 1.0)) * tmpvar_63.xyz);
  lowp vec3 tmpvar_64;
  mediump vec4 c_65;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(tmpvar_53);
  mediump vec3 tmpvar_67;
  tmpvar_67 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_64 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_68;
  diffColor_68 = tmpvar_64;
  mediump float alpha_69;
  alpha_69 = tmpvar_20;
  tmpvar_64 = diffColor_68;
  mediump vec3 diffColor_70;
  diffColor_70 = tmpvar_64;
  mediump vec3 color_71;
  mediump float surfaceReduction_72;
  highp float specularTerm_73;
  highp float a2_74;
  mediump float roughness_75;
  mediump float perceptualRoughness_76;
  highp vec3 tmpvar_77;
  highp vec3 inVec_78;
  inVec_78 = (tmpvar_4 + worldViewDir_11);
  tmpvar_77 = (inVec_78 * inversesqrt(max (0.001, 
    dot (inVec_78, inVec_78)
  )));
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (dot (tmpvar_66, tmpvar_4), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (dot (tmpvar_66, tmpvar_77), 0.0, 1.0);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (dot (tmpvar_66, worldViewDir_11), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  highp float tmpvar_84;
  highp float smoothness_85;
  smoothness_85 = tmpvar_9;
  tmpvar_84 = (1.0 - smoothness_85);
  perceptualRoughness_76 = tmpvar_84;
  highp float tmpvar_86;
  highp float perceptualRoughness_87;
  perceptualRoughness_87 = perceptualRoughness_76;
  tmpvar_86 = (perceptualRoughness_87 * perceptualRoughness_87);
  roughness_75 = tmpvar_86;
  mediump float tmpvar_88;
  tmpvar_88 = (roughness_75 * roughness_75);
  a2_74 = tmpvar_88;
  specularTerm_73 = ((roughness_75 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_77), 0.0, 1.0)) * (1.5 + roughness_75))
   * 
    (((tmpvar_81 * tmpvar_81) * (a2_74 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_89;
  tmpvar_89 = clamp (specularTerm_73, 0.0, 100.0);
  specularTerm_73 = tmpvar_89;
  surfaceReduction_72 = (1.0 - ((roughness_75 * perceptualRoughness_76) * 0.28));
  mediump float x_90;
  x_90 = (1.0 - tmpvar_82);
  mediump vec3 tmpvar_91;
  tmpvar_91 = mix (tmpvar_67, vec3(clamp ((tmpvar_9 + 
    (1.0 - (0.7790837 - (tmpvar_8 * 0.7790837)))
  ), 0.0, 1.0)), vec3(((x_90 * x_90) * (x_90 * x_90))));
  highp vec3 tmpvar_92;
  tmpvar_92 = (((
    (diffColor_70 + (tmpvar_89 * tmpvar_67))
   * tmpvar_3) * tmpvar_79) + ((surfaceReduction_72 * tmpvar_59) * tmpvar_91));
  color_71 = tmpvar_92;
  mediump vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = color_71;
  c_65.xyz = tmpvar_93.xyz;
  c_65.w = alpha_69;
  c_6 = c_65;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" }
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec3 tmpvar_59;
  mediump vec4 hdr_60;
  hdr_60 = tmpvar_2;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_61.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_62;
  tmpvar_62 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_61.xyz, tmpvar_61.w);
  mediump vec4 tmpvar_63;
  tmpvar_63 = tmpvar_62;
  tmpvar_59 = ((hdr_60.x * (
    (hdr_60.w * (tmpvar_63.w - 1.0))
   + 1.0)) * tmpvar_63.xyz);
  lowp vec3 tmpvar_64;
  mediump vec4 c_65;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(tmpvar_53);
  mediump vec3 tmpvar_67;
  tmpvar_67 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_64 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_68;
  diffColor_68 = tmpvar_64;
  mediump float alpha_69;
  alpha_69 = tmpvar_20;
  tmpvar_64 = diffColor_68;
  mediump vec3 diffColor_70;
  diffColor_70 = tmpvar_64;
  mediump vec3 color_71;
  mediump float surfaceReduction_72;
  highp float specularTerm_73;
  highp float a2_74;
  mediump float roughness_75;
  mediump float perceptualRoughness_76;
  highp vec3 tmpvar_77;
  highp vec3 inVec_78;
  inVec_78 = (tmpvar_4 + worldViewDir_11);
  tmpvar_77 = (inVec_78 * inversesqrt(max (0.001, 
    dot (inVec_78, inVec_78)
  )));
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (dot (tmpvar_66, tmpvar_4), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (dot (tmpvar_66, tmpvar_77), 0.0, 1.0);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (dot (tmpvar_66, worldViewDir_11), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  highp float tmpvar_84;
  highp float smoothness_85;
  smoothness_85 = tmpvar_9;
  tmpvar_84 = (1.0 - smoothness_85);
  perceptualRoughness_76 = tmpvar_84;
  highp float tmpvar_86;
  highp float perceptualRoughness_87;
  perceptualRoughness_87 = perceptualRoughness_76;
  tmpvar_86 = (perceptualRoughness_87 * perceptualRoughness_87);
  roughness_75 = tmpvar_86;
  mediump float tmpvar_88;
  tmpvar_88 = (roughness_75 * roughness_75);
  a2_74 = tmpvar_88;
  specularTerm_73 = ((roughness_75 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_77), 0.0, 1.0)) * (1.5 + roughness_75))
   * 
    (((tmpvar_81 * tmpvar_81) * (a2_74 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_89;
  tmpvar_89 = clamp (specularTerm_73, 0.0, 100.0);
  specularTerm_73 = tmpvar_89;
  surfaceReduction_72 = (1.0 - ((roughness_75 * perceptualRoughness_76) * 0.28));
  mediump float x_90;
  x_90 = (1.0 - tmpvar_82);
  mediump vec3 tmpvar_91;
  tmpvar_91 = mix (tmpvar_67, vec3(clamp ((tmpvar_9 + 
    (1.0 - (0.7790837 - (tmpvar_8 * 0.7790837)))
  ), 0.0, 1.0)), vec3(((x_90 * x_90) * (x_90 * x_90))));
  highp vec3 tmpvar_92;
  tmpvar_92 = (((
    (diffColor_70 + (tmpvar_89 * tmpvar_67))
   * tmpvar_3) * tmpvar_79) + ((surfaceReduction_72 * tmpvar_59) * tmpvar_91));
  color_71 = tmpvar_92;
  mediump vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = color_71;
  c_65.xyz = tmpvar_93.xyz;
  c_65.w = alpha_69;
  c_6 = c_65;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  mediump vec3 normal_15;
  normal_15 = tmpvar_7;
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_15.xyzz * normal_15.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD4 = (x1_16 + (unity_SHC.xyz * (
    (normal_15.x * normal_15.x)
   - 
    (normal_15.y * normal_15.y)
  )));
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp sampler2D unity_NHxRoughness;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec4 hdr_59;
  hdr_59 = tmpvar_2;
  mediump vec4 tmpvar_60;
  tmpvar_60.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_60.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_61;
  tmpvar_61 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_60.xyz, tmpvar_60.w);
  mediump vec4 tmpvar_62;
  tmpvar_62 = tmpvar_61;
  lowp vec3 tmpvar_63;
  mediump vec4 c_64;
  highp vec3 tmpvar_65;
  tmpvar_65 = normalize(tmpvar_53);
  mediump vec3 tmpvar_66;
  tmpvar_66 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_63 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_67;
  diffColor_67 = tmpvar_63;
  mediump float alpha_68;
  alpha_68 = tmpvar_20;
  tmpvar_63 = diffColor_67;
  mediump vec3 diffColor_69;
  diffColor_69 = tmpvar_63;
  mediump vec3 color_70;
  mediump vec2 rlPow4AndFresnelTerm_71;
  mediump float tmpvar_72;
  highp float tmpvar_73;
  tmpvar_73 = clamp (dot (tmpvar_65, tmpvar_4), 0.0, 1.0);
  tmpvar_72 = tmpvar_73;
  mediump float tmpvar_74;
  highp float tmpvar_75;
  tmpvar_75 = clamp (dot (tmpvar_65, worldViewDir_11), 0.0, 1.0);
  tmpvar_74 = tmpvar_75;
  highp vec2 tmpvar_76;
  tmpvar_76.x = dot ((worldViewDir_11 - (2.0 * 
    (dot (tmpvar_65, worldViewDir_11) * tmpvar_65)
  )), tmpvar_4);
  tmpvar_76.y = (1.0 - tmpvar_74);
  highp vec2 tmpvar_77;
  tmpvar_77 = ((tmpvar_76 * tmpvar_76) * (tmpvar_76 * tmpvar_76));
  rlPow4AndFresnelTerm_71 = tmpvar_77;
  mediump float tmpvar_78;
  tmpvar_78 = rlPow4AndFresnelTerm_71.x;
  mediump float specular_79;
  highp float smoothness_80;
  smoothness_80 = tmpvar_9;
  highp vec2 tmpvar_81;
  tmpvar_81.x = tmpvar_78;
  tmpvar_81.y = (1.0 - smoothness_80);
  highp float tmpvar_82;
  tmpvar_82 = (texture2D (unity_NHxRoughness, tmpvar_81).w * 16.0);
  specular_79 = tmpvar_82;
  color_70 = ((diffColor_69 + (specular_79 * tmpvar_66)) * (tmpvar_3 * tmpvar_72));
  color_70 = (color_70 + ((
    (hdr_59.x * ((hdr_59.w * (tmpvar_62.w - 1.0)) + 1.0))
   * tmpvar_62.xyz) * mix (tmpvar_66, vec3(
    clamp ((tmpvar_9 + (1.0 - (0.7790837 - 
      (tmpvar_8 * 0.7790837)
    ))), 0.0, 1.0)
  ), rlPow4AndFresnelTerm_71.yyy)));
  mediump vec4 tmpvar_83;
  tmpvar_83.w = 1.0;
  tmpvar_83.xyz = color_70;
  c_64.xyz = tmpvar_83.xyz;
  c_64.w = alpha_68;
  c_6 = c_64;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  mediump vec3 normal_15;
  normal_15 = tmpvar_7;
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_15.xyzz * normal_15.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD4 = (x1_16 + (unity_SHC.xyz * (
    (normal_15.x * normal_15.x)
   - 
    (normal_15.y * normal_15.y)
  )));
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec3 tmpvar_59;
  mediump vec4 hdr_60;
  hdr_60 = tmpvar_2;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_61.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_62;
  tmpvar_62 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_61.xyz, tmpvar_61.w);
  mediump vec4 tmpvar_63;
  tmpvar_63 = tmpvar_62;
  tmpvar_59 = ((hdr_60.x * (
    (hdr_60.w * (tmpvar_63.w - 1.0))
   + 1.0)) * tmpvar_63.xyz);
  lowp vec3 tmpvar_64;
  mediump vec4 c_65;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(tmpvar_53);
  mediump vec3 tmpvar_67;
  tmpvar_67 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_64 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_68;
  diffColor_68 = tmpvar_64;
  mediump float alpha_69;
  alpha_69 = tmpvar_20;
  tmpvar_64 = diffColor_68;
  mediump vec3 diffColor_70;
  diffColor_70 = tmpvar_64;
  mediump vec3 color_71;
  mediump float surfaceReduction_72;
  highp float specularTerm_73;
  highp float a2_74;
  mediump float roughness_75;
  mediump float perceptualRoughness_76;
  highp vec3 tmpvar_77;
  highp vec3 inVec_78;
  inVec_78 = (tmpvar_4 + worldViewDir_11);
  tmpvar_77 = (inVec_78 * inversesqrt(max (0.001, 
    dot (inVec_78, inVec_78)
  )));
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (dot (tmpvar_66, tmpvar_4), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (dot (tmpvar_66, tmpvar_77), 0.0, 1.0);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (dot (tmpvar_66, worldViewDir_11), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  highp float tmpvar_84;
  highp float smoothness_85;
  smoothness_85 = tmpvar_9;
  tmpvar_84 = (1.0 - smoothness_85);
  perceptualRoughness_76 = tmpvar_84;
  highp float tmpvar_86;
  highp float perceptualRoughness_87;
  perceptualRoughness_87 = perceptualRoughness_76;
  tmpvar_86 = (perceptualRoughness_87 * perceptualRoughness_87);
  roughness_75 = tmpvar_86;
  mediump float tmpvar_88;
  tmpvar_88 = (roughness_75 * roughness_75);
  a2_74 = tmpvar_88;
  specularTerm_73 = ((roughness_75 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_77), 0.0, 1.0)) * (1.5 + roughness_75))
   * 
    (((tmpvar_81 * tmpvar_81) * (a2_74 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_89;
  tmpvar_89 = clamp (specularTerm_73, 0.0, 100.0);
  specularTerm_73 = tmpvar_89;
  surfaceReduction_72 = (1.0 - ((roughness_75 * perceptualRoughness_76) * 0.28));
  mediump float x_90;
  x_90 = (1.0 - tmpvar_82);
  mediump vec3 tmpvar_91;
  tmpvar_91 = mix (tmpvar_67, vec3(clamp ((tmpvar_9 + 
    (1.0 - (0.7790837 - (tmpvar_8 * 0.7790837)))
  ), 0.0, 1.0)), vec3(((x_90 * x_90) * (x_90 * x_90))));
  highp vec3 tmpvar_92;
  tmpvar_92 = (((
    (diffColor_70 + (tmpvar_89 * tmpvar_67))
   * tmpvar_3) * tmpvar_79) + ((surfaceReduction_72 * tmpvar_59) * tmpvar_91));
  color_71 = tmpvar_92;
  mediump vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = color_71;
  c_65.xyz = tmpvar_93.xyz;
  c_65.w = alpha_69;
  c_6 = c_65;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying mediump vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  tmpvar_4.w = 1.0;
  tmpvar_4.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = unity_WorldToObject[0].xyz;
  tmpvar_6[1] = unity_WorldToObject[1].xyz;
  tmpvar_6[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = normalize((_glesNormal * tmpvar_6));
  highp mat3 tmpvar_8;
  tmpvar_8[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_8[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_8[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_9;
  tmpvar_9 = normalize((tmpvar_8 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = (((tmpvar_7.yzx * worldTangent_3.zxy) - (tmpvar_7.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_11;
  highp vec4 tmpvar_12;
  tmpvar_12.x = worldTangent_3.x;
  tmpvar_12.y = worldBinormal_1.x;
  tmpvar_12.z = tmpvar_7.x;
  tmpvar_12.w = tmpvar_5.x;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.y;
  tmpvar_13.y = worldBinormal_1.y;
  tmpvar_13.z = tmpvar_7.y;
  tmpvar_13.w = tmpvar_5.y;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.z;
  tmpvar_14.y = worldBinormal_1.z;
  tmpvar_14.z = tmpvar_7.z;
  tmpvar_14.w = tmpvar_5.z;
  mediump vec3 normal_15;
  normal_15 = tmpvar_7;
  mediump vec3 x1_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_15.xyzz * normal_15.yzzx);
  x1_16.x = dot (unity_SHBr, tmpvar_17);
  x1_16.y = dot (unity_SHBg, tmpvar_17);
  x1_16.z = dot (unity_SHBb, tmpvar_17);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_4));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_12;
  xlv_TEXCOORD2 = tmpvar_13;
  xlv_TEXCOORD3 = tmpvar_14;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD4 = (x1_16 + (unity_SHC.xyz * (
    (normal_15.x * normal_15.x)
   - 
    (normal_15.y * normal_15.y)
  )));
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
uniform mediump vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform lowp samplerCube unity_SpecCube0;
uniform mediump vec4 unity_SpecCube0_HDR;
uniform lowp vec4 _LightColor0;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec3 tmpvar_1;
  highp vec4 tmpvar_2;
  mediump vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  highp vec3 worldN_5;
  lowp vec4 c_6;
  mediump vec3 tmpvar_7;
  mediump float tmpvar_8;
  mediump float tmpvar_9;
  lowp float tmpvar_10;
  highp vec3 worldViewDir_11;
  lowp vec3 lightDir_12;
  mediump vec3 tmpvar_13;
  mediump vec3 tmpvar_14;
  mediump vec3 tmpvar_15;
  highp vec4 tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17.x = xlv_TEXCOORD1.w;
  tmpvar_17.y = xlv_TEXCOORD2.w;
  tmpvar_17.z = xlv_TEXCOORD3.w;
  mediump vec3 tmpvar_18;
  tmpvar_18 = _WorldSpaceLightPos0.xyz;
  lightDir_12 = tmpvar_18;
  worldViewDir_11 = normalize((_WorldSpaceCameraPos - tmpvar_17));
  tmpvar_13 = xlv_TEXCOORD1.xyz;
  tmpvar_14 = xlv_TEXCOORD2.xyz;
  tmpvar_15 = xlv_TEXCOORD3.xyz;
  tmpvar_16 = xlv_COLOR0;
  tmpvar_7 = vec3(0.0, 0.0, 0.0);
  tmpvar_10 = 0.0;
  mediump vec3 tmpvar_19;
  lowp float tmpvar_20;
  tmpvar_19 = tmpvar_7;
  tmpvar_20 = tmpvar_10;
  highp vec4 staticSwitch286_21;
  highp vec4 tex2DNode278_22;
  highp vec3 staticSwitch298_23;
  highp vec3 ase_worldNormal_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = _WorldSpaceLightPos0.xyz;
  highp vec3 tmpvar_26;
  tmpvar_26 = normalize(tmpvar_25);
  mediump vec3 tmpvar_27;
  tmpvar_27.x = tmpvar_13.z;
  tmpvar_27.y = tmpvar_14.z;
  tmpvar_27.z = tmpvar_15.z;
  ase_worldNormal_24 = tmpvar_27;
  highp vec3 tmpvar_28;
  tmpvar_28 = normalize(ase_worldNormal_24);
  staticSwitch298_23 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_29;
    tmpvar_29 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_29;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec4 packednormal_34;
    packednormal_34 = tmpvar_29;
    mediump float bumpScale_35;
    bumpScale_35 = _NormaTexlScale;
    mediump vec3 normal_36;
    mediump vec3 tmpvar_37;
    tmpvar_37 = ((packednormal_34.xyz * 2.0) - 1.0);
    normal_36.z = tmpvar_37.z;
    normal_36.xy = (tmpvar_37.xy * bumpScale_35);
    mediump vec4 packednormal_38;
    packednormal_38 = tmpvar_29;
    mediump float bumpScale_39;
    bumpScale_39 = _NormaTexlScale;
    mediump vec3 normal_40;
    mediump vec3 tmpvar_41;
    tmpvar_41 = ((packednormal_38.xyz * 2.0) - 1.0);
    normal_40.z = tmpvar_41.z;
    normal_40.xy = (tmpvar_41.xy * bumpScale_39);
    mediump vec3 tmpvar_42;
    tmpvar_42.x = dot (tmpvar_13, normal_32);
    tmpvar_42.y = dot (tmpvar_14, normal_36);
    tmpvar_42.z = dot (tmpvar_15, normal_40);
    mediump vec3 tmpvar_43;
    tmpvar_43 = normalize(tmpvar_42);
    staticSwitch298_23 = tmpvar_43;
  } else {
    staticSwitch298_23 = tmpvar_28;
  };
  highp vec3 tmpvar_44;
  tmpvar_44 = ((staticSwitch298_23 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_45;
  tmpvar_45 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_46;
  tmpvar_46 = texture2D (_BaseTex, tmpvar_45);
  tex2DNode278_22 = tmpvar_46;
  highp vec4 tmpvar_47;
  tmpvar_47 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_26, tmpvar_44)
  , 0.0, 1.0))) * tex2DNode278_22);
  highp vec3 tmpvar_48;
  highp mat3 tmpvar_49;
  tmpvar_49[0] = unity_MatrixV[0].xyz;
  tmpvar_49[1] = unity_MatrixV[1].xyz;
  tmpvar_49[2] = unity_MatrixV[2].xyz;
  tmpvar_48 = (tmpvar_49 * tmpvar_44);
  staticSwitch286_21 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_50;
    highp vec2 P_51;
    P_51 = (((tmpvar_48.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_50 = texture2D (_Matcap, P_51);
    staticSwitch286_21 = (tmpvar_47 + (tmpvar_50 * _Matcap_Light));
  } else {
    staticSwitch286_21 = tmpvar_47;
  };
  tmpvar_19 = ((_ColorBrightness * staticSwitch286_21) * (tmpvar_16 * _DayColor)).xyz;
  highp float tmpvar_52;
  tmpvar_52 = clamp (((_DayColor.w * tmpvar_16.w) * tex2DNode278_22.w), 0.0, 1.0);
  tmpvar_20 = tmpvar_52;
  tmpvar_7 = tmpvar_19;
  tmpvar_10 = tmpvar_20;
  worldN_5.x = xlv_TEXCOORD1.z;
  worldN_5.y = xlv_TEXCOORD2.z;
  worldN_5.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_53;
  tmpvar_53 = normalize(worldN_5);
  worldN_5 = tmpvar_53;
  tmpvar_3 = _LightColor0.xyz;
  tmpvar_4 = lightDir_12;
  tmpvar_1 = worldViewDir_11;
  tmpvar_2 = unity_SpecCube0_HDR;
  mediump vec3 Normal_54;
  Normal_54 = tmpvar_53;
  mediump float tmpvar_55;
  highp float tmpvar_56;
  highp float smoothness_57;
  smoothness_57 = tmpvar_9;
  tmpvar_56 = (1.0 - smoothness_57);
  tmpvar_55 = tmpvar_56;
  mediump vec3 I_58;
  I_58 = -(tmpvar_1);
  mediump vec3 tmpvar_59;
  mediump vec4 hdr_60;
  hdr_60 = tmpvar_2;
  mediump vec4 tmpvar_61;
  tmpvar_61.xyz = (I_58 - (2.0 * (
    dot (Normal_54, I_58)
   * Normal_54)));
  tmpvar_61.w = ((tmpvar_55 * (1.7 - 
    (0.7 * tmpvar_55)
  )) * 6.0);
  lowp vec4 tmpvar_62;
  tmpvar_62 = impl_low_textureCubeLodEXT (unity_SpecCube0, tmpvar_61.xyz, tmpvar_61.w);
  mediump vec4 tmpvar_63;
  tmpvar_63 = tmpvar_62;
  tmpvar_59 = ((hdr_60.x * (
    (hdr_60.w * (tmpvar_63.w - 1.0))
   + 1.0)) * tmpvar_63.xyz);
  lowp vec3 tmpvar_64;
  mediump vec4 c_65;
  highp vec3 tmpvar_66;
  tmpvar_66 = normalize(tmpvar_53);
  mediump vec3 tmpvar_67;
  tmpvar_67 = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_8)));
  tmpvar_64 = vec3(0.0, 0.0, 0.0);
  mediump vec3 diffColor_68;
  diffColor_68 = tmpvar_64;
  mediump float alpha_69;
  alpha_69 = tmpvar_20;
  tmpvar_64 = diffColor_68;
  mediump vec3 diffColor_70;
  diffColor_70 = tmpvar_64;
  mediump vec3 color_71;
  mediump float surfaceReduction_72;
  highp float specularTerm_73;
  highp float a2_74;
  mediump float roughness_75;
  mediump float perceptualRoughness_76;
  highp vec3 tmpvar_77;
  highp vec3 inVec_78;
  inVec_78 = (tmpvar_4 + worldViewDir_11);
  tmpvar_77 = (inVec_78 * inversesqrt(max (0.001, 
    dot (inVec_78, inVec_78)
  )));
  mediump float tmpvar_79;
  highp float tmpvar_80;
  tmpvar_80 = clamp (dot (tmpvar_66, tmpvar_4), 0.0, 1.0);
  tmpvar_79 = tmpvar_80;
  highp float tmpvar_81;
  tmpvar_81 = clamp (dot (tmpvar_66, tmpvar_77), 0.0, 1.0);
  mediump float tmpvar_82;
  highp float tmpvar_83;
  tmpvar_83 = clamp (dot (tmpvar_66, worldViewDir_11), 0.0, 1.0);
  tmpvar_82 = tmpvar_83;
  highp float tmpvar_84;
  highp float smoothness_85;
  smoothness_85 = tmpvar_9;
  tmpvar_84 = (1.0 - smoothness_85);
  perceptualRoughness_76 = tmpvar_84;
  highp float tmpvar_86;
  highp float perceptualRoughness_87;
  perceptualRoughness_87 = perceptualRoughness_76;
  tmpvar_86 = (perceptualRoughness_87 * perceptualRoughness_87);
  roughness_75 = tmpvar_86;
  mediump float tmpvar_88;
  tmpvar_88 = (roughness_75 * roughness_75);
  a2_74 = tmpvar_88;
  specularTerm_73 = ((roughness_75 / (
    (max (0.32, clamp (dot (tmpvar_4, tmpvar_77), 0.0, 1.0)) * (1.5 + roughness_75))
   * 
    (((tmpvar_81 * tmpvar_81) * (a2_74 - 1.0)) + 1.00001)
  )) - 0.0001);
  highp float tmpvar_89;
  tmpvar_89 = clamp (specularTerm_73, 0.0, 100.0);
  specularTerm_73 = tmpvar_89;
  surfaceReduction_72 = (1.0 - ((roughness_75 * perceptualRoughness_76) * 0.28));
  mediump float x_90;
  x_90 = (1.0 - tmpvar_82);
  mediump vec3 tmpvar_91;
  tmpvar_91 = mix (tmpvar_67, vec3(clamp ((tmpvar_9 + 
    (1.0 - (0.7790837 - (tmpvar_8 * 0.7790837)))
  ), 0.0, 1.0)), vec3(((x_90 * x_90) * (x_90 * x_90))));
  highp vec3 tmpvar_92;
  tmpvar_92 = (((
    (diffColor_70 + (tmpvar_89 * tmpvar_67))
   * tmpvar_3) * tmpvar_79) + ((surfaceReduction_72 * tmpvar_59) * tmpvar_91));
  color_71 = tmpvar_92;
  mediump vec4 tmpvar_93;
  tmpvar_93.w = 1.0;
  tmpvar_93.xyz = color_71;
  c_65.xyz = tmpvar_93.xyz;
  c_65.w = alpha_69;
  c_6 = c_65;
  c_6.xyz = (c_6.xyz + tmpvar_19);
  gl_FragData[0] = c_6;
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
  Name "DEFERRED"
  LOD 200
  Tags { "IGNOREPROJECTOR" = "true" "IsEmissive" = "true" "LIGHTMODE" = "DEFERRED" "PreviewType" = "Plane" "QUEUE" = "Transparent+0" "RenderType" = "Transparent" }
  ZTest Off
  ZWrite Off
  Cull Off
  GpuProgramID 130914
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
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
uniform highp vec4 _texcoord_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  mediump vec4 outEmission_1;
  highp vec3 worldN_2;
  mediump vec3 tmpvar_3;
  mediump float tmpvar_4;
  mediump float tmpvar_5;
  lowp float tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  mediump vec3 tmpvar_9;
  highp vec4 tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11.x = xlv_TEXCOORD1.w;
  tmpvar_11.y = xlv_TEXCOORD2.w;
  tmpvar_11.z = xlv_TEXCOORD3.w;
  tmpvar_7 = xlv_TEXCOORD1.xyz;
  tmpvar_8 = xlv_TEXCOORD2.xyz;
  tmpvar_9 = xlv_TEXCOORD3.xyz;
  tmpvar_10 = xlv_COLOR0;
  tmpvar_3 = vec3(0.0, 0.0, 0.0);
  tmpvar_6 = 0.0;
  mediump vec3 tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_12 = tmpvar_3;
  tmpvar_13 = tmpvar_6;
  highp vec4 staticSwitch286_14;
  highp vec4 tex2DNode278_15;
  highp vec3 staticSwitch298_16;
  highp vec3 ase_worldNormal_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_11 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_19;
  tmpvar_19.x = tmpvar_7.z;
  tmpvar_19.y = tmpvar_8.z;
  tmpvar_19.z = tmpvar_9.z;
  ase_worldNormal_17 = tmpvar_19;
  highp vec3 tmpvar_20;
  tmpvar_20 = normalize(ase_worldNormal_17);
  staticSwitch298_16 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_22;
    packednormal_22 = tmpvar_21;
    mediump float bumpScale_23;
    bumpScale_23 = _NormaTexlScale;
    mediump vec3 normal_24;
    mediump vec3 tmpvar_25;
    tmpvar_25 = ((packednormal_22.xyz * 2.0) - 1.0);
    normal_24.z = tmpvar_25.z;
    normal_24.xy = (tmpvar_25.xy * bumpScale_23);
    mediump vec4 packednormal_26;
    packednormal_26 = tmpvar_21;
    mediump float bumpScale_27;
    bumpScale_27 = _NormaTexlScale;
    mediump vec3 normal_28;
    mediump vec3 tmpvar_29;
    tmpvar_29 = ((packednormal_26.xyz * 2.0) - 1.0);
    normal_28.z = tmpvar_29.z;
    normal_28.xy = (tmpvar_29.xy * bumpScale_27);
    mediump vec4 packednormal_30;
    packednormal_30 = tmpvar_21;
    mediump float bumpScale_31;
    bumpScale_31 = _NormaTexlScale;
    mediump vec3 normal_32;
    mediump vec3 tmpvar_33;
    tmpvar_33 = ((packednormal_30.xyz * 2.0) - 1.0);
    normal_32.z = tmpvar_33.z;
    normal_32.xy = (tmpvar_33.xy * bumpScale_31);
    mediump vec3 tmpvar_34;
    tmpvar_34.x = dot (tmpvar_7, normal_24);
    tmpvar_34.y = dot (tmpvar_8, normal_28);
    tmpvar_34.z = dot (tmpvar_9, normal_32);
    mediump vec3 tmpvar_35;
    tmpvar_35 = normalize(tmpvar_34);
    staticSwitch298_16 = tmpvar_35;
  } else {
    staticSwitch298_16 = tmpvar_20;
  };
  highp vec3 tmpvar_36;
  tmpvar_36 = ((staticSwitch298_16 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_37;
  tmpvar_37 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_BaseTex, tmpvar_37);
  tex2DNode278_15 = tmpvar_38;
  highp vec4 tmpvar_39;
  tmpvar_39 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_18, tmpvar_36)
  , 0.0, 1.0))) * tex2DNode278_15);
  highp vec3 tmpvar_40;
  highp mat3 tmpvar_41;
  tmpvar_41[0] = unity_MatrixV[0].xyz;
  tmpvar_41[1] = unity_MatrixV[1].xyz;
  tmpvar_41[2] = unity_MatrixV[2].xyz;
  tmpvar_40 = (tmpvar_41 * tmpvar_36);
  staticSwitch286_14 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_42;
    highp vec2 P_43;
    P_43 = (((tmpvar_40.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_42 = texture2D (_Matcap, P_43);
    staticSwitch286_14 = (tmpvar_39 + (tmpvar_42 * _Matcap_Light));
  } else {
    staticSwitch286_14 = tmpvar_39;
  };
  tmpvar_12 = ((_ColorBrightness * staticSwitch286_14) * (tmpvar_10 * _DayColor)).xyz;
  highp float tmpvar_44;
  tmpvar_44 = clamp (((_DayColor.w * tmpvar_10.w) * tex2DNode278_15.w), 0.0, 1.0);
  tmpvar_13 = tmpvar_44;
  tmpvar_3 = tmpvar_12;
  tmpvar_6 = tmpvar_13;
  worldN_2.x = xlv_TEXCOORD1.z;
  worldN_2.y = xlv_TEXCOORD2.z;
  worldN_2.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_45;
  tmpvar_45 = normalize(worldN_2);
  worldN_2 = tmpvar_45;
  mediump vec4 outGBuffer2_46;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_47.w = 1.0;
  mediump vec4 tmpvar_48;
  tmpvar_48.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_4)));
  tmpvar_48.w = tmpvar_5;
  highp vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = ((tmpvar_45 * 0.5) + 0.5);
  outGBuffer2_46 = tmpvar_49;
  mediump vec4 tmpvar_50;
  tmpvar_50.w = 1.0;
  tmpvar_50.xyz = tmpvar_12;
  outEmission_1.w = tmpvar_50.w;
  outEmission_1.xyz = exp2(-(tmpvar_12));
  gl_FragData[0] = tmpvar_47;
  gl_FragData[1] = tmpvar_48;
  gl_FragData[2] = outGBuffer2_46;
  gl_FragData[3] = outEmission_1;
}


#endif
"
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec3 worldN_1;
  mediump vec3 tmpvar_2;
  mediump float tmpvar_3;
  mediump float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD1.w;
  tmpvar_10.y = xlv_TEXCOORD2.w;
  tmpvar_10.z = xlv_TEXCOORD3.w;
  tmpvar_6 = xlv_TEXCOORD1.xyz;
  tmpvar_7 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = tmpvar_2;
  tmpvar_12 = tmpvar_5;
  highp vec4 staticSwitch286_13;
  highp vec4 tex2DNode278_14;
  highp vec3 staticSwitch298_15;
  highp vec3 ase_worldNormal_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_10 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_18;
  tmpvar_18.x = tmpvar_6.z;
  tmpvar_18.y = tmpvar_7.z;
  tmpvar_18.z = tmpvar_8.z;
  ase_worldNormal_16 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(ase_worldNormal_16);
  staticSwitch298_15 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_21;
    packednormal_21 = tmpvar_20;
    mediump float bumpScale_22;
    bumpScale_22 = _NormaTexlScale;
    mediump vec3 normal_23;
    mediump vec3 tmpvar_24;
    tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
    normal_23.z = tmpvar_24.z;
    normal_23.xy = (tmpvar_24.xy * bumpScale_22);
    mediump vec4 packednormal_25;
    packednormal_25 = tmpvar_20;
    mediump float bumpScale_26;
    bumpScale_26 = _NormaTexlScale;
    mediump vec3 normal_27;
    mediump vec3 tmpvar_28;
    tmpvar_28 = ((packednormal_25.xyz * 2.0) - 1.0);
    normal_27.z = tmpvar_28.z;
    normal_27.xy = (tmpvar_28.xy * bumpScale_26);
    mediump vec4 packednormal_29;
    packednormal_29 = tmpvar_20;
    mediump float bumpScale_30;
    bumpScale_30 = _NormaTexlScale;
    mediump vec3 normal_31;
    mediump vec3 tmpvar_32;
    tmpvar_32 = ((packednormal_29.xyz * 2.0) - 1.0);
    normal_31.z = tmpvar_32.z;
    normal_31.xy = (tmpvar_32.xy * bumpScale_30);
    mediump vec3 tmpvar_33;
    tmpvar_33.x = dot (tmpvar_6, normal_23);
    tmpvar_33.y = dot (tmpvar_7, normal_27);
    tmpvar_33.z = dot (tmpvar_8, normal_31);
    mediump vec3 tmpvar_34;
    tmpvar_34 = normalize(tmpvar_33);
    staticSwitch298_15 = tmpvar_34;
  } else {
    staticSwitch298_15 = tmpvar_19;
  };
  highp vec3 tmpvar_35;
  tmpvar_35 = ((staticSwitch298_15 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_BaseTex, tmpvar_36);
  tex2DNode278_14 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_17, tmpvar_35)
  , 0.0, 1.0))) * tex2DNode278_14);
  highp vec3 tmpvar_39;
  highp mat3 tmpvar_40;
  tmpvar_40[0] = unity_MatrixV[0].xyz;
  tmpvar_40[1] = unity_MatrixV[1].xyz;
  tmpvar_40[2] = unity_MatrixV[2].xyz;
  tmpvar_39 = (tmpvar_40 * tmpvar_35);
  staticSwitch286_13 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_41;
    highp vec2 P_42;
    P_42 = (((tmpvar_39.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_41 = texture2D (_Matcap, P_42);
    staticSwitch286_13 = (tmpvar_38 + (tmpvar_41 * _Matcap_Light));
  } else {
    staticSwitch286_13 = tmpvar_38;
  };
  tmpvar_11 = ((_ColorBrightness * staticSwitch286_13) * (tmpvar_9 * _DayColor)).xyz;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((_DayColor.w * tmpvar_9.w) * tex2DNode278_14.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_43;
  tmpvar_2 = tmpvar_11;
  tmpvar_5 = tmpvar_12;
  worldN_1.x = xlv_TEXCOORD1.z;
  worldN_1.y = xlv_TEXCOORD2.z;
  worldN_1.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(worldN_1);
  worldN_1 = tmpvar_44;
  mediump vec4 outGBuffer2_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_46.w = 1.0;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_3)));
  tmpvar_47.w = tmpvar_4;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = ((tmpvar_44 * 0.5) + 0.5);
  outGBuffer2_45 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = tmpvar_11;
  gl_FragData[0] = tmpvar_46;
  gl_FragData[1] = tmpvar_47;
  gl_FragData[2] = outGBuffer2_45;
  gl_FragData[3] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec3 worldN_1;
  mediump vec3 tmpvar_2;
  mediump float tmpvar_3;
  mediump float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD1.w;
  tmpvar_10.y = xlv_TEXCOORD2.w;
  tmpvar_10.z = xlv_TEXCOORD3.w;
  tmpvar_6 = xlv_TEXCOORD1.xyz;
  tmpvar_7 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = tmpvar_2;
  tmpvar_12 = tmpvar_5;
  highp vec4 staticSwitch286_13;
  highp vec4 tex2DNode278_14;
  highp vec3 staticSwitch298_15;
  highp vec3 ase_worldNormal_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_10 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_18;
  tmpvar_18.x = tmpvar_6.z;
  tmpvar_18.y = tmpvar_7.z;
  tmpvar_18.z = tmpvar_8.z;
  ase_worldNormal_16 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(ase_worldNormal_16);
  staticSwitch298_15 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_21;
    packednormal_21 = tmpvar_20;
    mediump float bumpScale_22;
    bumpScale_22 = _NormaTexlScale;
    mediump vec3 normal_23;
    mediump vec3 tmpvar_24;
    tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
    normal_23.z = tmpvar_24.z;
    normal_23.xy = (tmpvar_24.xy * bumpScale_22);
    mediump vec4 packednormal_25;
    packednormal_25 = tmpvar_20;
    mediump float bumpScale_26;
    bumpScale_26 = _NormaTexlScale;
    mediump vec3 normal_27;
    mediump vec3 tmpvar_28;
    tmpvar_28 = ((packednormal_25.xyz * 2.0) - 1.0);
    normal_27.z = tmpvar_28.z;
    normal_27.xy = (tmpvar_28.xy * bumpScale_26);
    mediump vec4 packednormal_29;
    packednormal_29 = tmpvar_20;
    mediump float bumpScale_30;
    bumpScale_30 = _NormaTexlScale;
    mediump vec3 normal_31;
    mediump vec3 tmpvar_32;
    tmpvar_32 = ((packednormal_29.xyz * 2.0) - 1.0);
    normal_31.z = tmpvar_32.z;
    normal_31.xy = (tmpvar_32.xy * bumpScale_30);
    mediump vec3 tmpvar_33;
    tmpvar_33.x = dot (tmpvar_6, normal_23);
    tmpvar_33.y = dot (tmpvar_7, normal_27);
    tmpvar_33.z = dot (tmpvar_8, normal_31);
    mediump vec3 tmpvar_34;
    tmpvar_34 = normalize(tmpvar_33);
    staticSwitch298_15 = tmpvar_34;
  } else {
    staticSwitch298_15 = tmpvar_19;
  };
  highp vec3 tmpvar_35;
  tmpvar_35 = ((staticSwitch298_15 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_BaseTex, tmpvar_36);
  tex2DNode278_14 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_17, tmpvar_35)
  , 0.0, 1.0))) * tex2DNode278_14);
  highp vec3 tmpvar_39;
  highp mat3 tmpvar_40;
  tmpvar_40[0] = unity_MatrixV[0].xyz;
  tmpvar_40[1] = unity_MatrixV[1].xyz;
  tmpvar_40[2] = unity_MatrixV[2].xyz;
  tmpvar_39 = (tmpvar_40 * tmpvar_35);
  staticSwitch286_13 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_41;
    highp vec2 P_42;
    P_42 = (((tmpvar_39.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_41 = texture2D (_Matcap, P_42);
    staticSwitch286_13 = (tmpvar_38 + (tmpvar_41 * _Matcap_Light));
  } else {
    staticSwitch286_13 = tmpvar_38;
  };
  tmpvar_11 = ((_ColorBrightness * staticSwitch286_13) * (tmpvar_9 * _DayColor)).xyz;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((_DayColor.w * tmpvar_9.w) * tex2DNode278_14.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_43;
  tmpvar_2 = tmpvar_11;
  tmpvar_5 = tmpvar_12;
  worldN_1.x = xlv_TEXCOORD1.z;
  worldN_1.y = xlv_TEXCOORD2.z;
  worldN_1.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(worldN_1);
  worldN_1 = tmpvar_44;
  mediump vec4 outGBuffer2_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_46.w = 1.0;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_3)));
  tmpvar_47.w = tmpvar_4;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = ((tmpvar_44 * 0.5) + 0.5);
  outGBuffer2_45 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = tmpvar_11;
  gl_FragData[0] = tmpvar_46;
  gl_FragData[1] = tmpvar_47;
  gl_FragData[2] = outGBuffer2_45;
  gl_FragData[3] = tmpvar_49;
}


#endif
"
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
"#version 100

#ifdef VERTEX
attribute vec4 _glesTANGENT;
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
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
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD5;
varying mediump vec3 xlv_TEXCOORD6;
void main ()
{
  lowp vec3 worldBinormal_1;
  lowp float tangentSign_2;
  lowp vec3 worldTangent_3;
  highp vec4 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5.w = 1.0;
  tmpvar_5.xyz = _glesVertex.xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (unity_ObjectToWorld * _glesVertex).xyz;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = unity_WorldToObject[0].xyz;
  tmpvar_7[1] = unity_WorldToObject[1].xyz;
  tmpvar_7[2] = unity_WorldToObject[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = normalize((_glesNormal * tmpvar_7));
  highp mat3 tmpvar_9;
  tmpvar_9[0] = unity_ObjectToWorld[0].xyz;
  tmpvar_9[1] = unity_ObjectToWorld[1].xyz;
  tmpvar_9[2] = unity_ObjectToWorld[2].xyz;
  highp vec3 tmpvar_10;
  tmpvar_10 = normalize((tmpvar_9 * _glesTANGENT.xyz));
  worldTangent_3 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = (_glesTANGENT.w * unity_WorldTransformParams.w);
  tangentSign_2 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = (((tmpvar_8.yzx * worldTangent_3.zxy) - (tmpvar_8.zxy * worldTangent_3.yzx)) * tangentSign_2);
  worldBinormal_1 = tmpvar_12;
  highp vec4 tmpvar_13;
  tmpvar_13.x = worldTangent_3.x;
  tmpvar_13.y = worldBinormal_1.x;
  tmpvar_13.z = tmpvar_8.x;
  tmpvar_13.w = tmpvar_6.x;
  highp vec4 tmpvar_14;
  tmpvar_14.x = worldTangent_3.y;
  tmpvar_14.y = worldBinormal_1.y;
  tmpvar_14.z = tmpvar_8.y;
  tmpvar_14.w = tmpvar_6.y;
  highp vec4 tmpvar_15;
  tmpvar_15.x = worldTangent_3.z;
  tmpvar_15.y = worldBinormal_1.z;
  tmpvar_15.z = tmpvar_8.z;
  tmpvar_15.w = tmpvar_6.z;
  tmpvar_4.zw = vec2(0.0, 0.0);
  tmpvar_4.xy = vec2(0.0, 0.0);
  mediump vec3 normal_16;
  normal_16 = tmpvar_8;
  mediump vec3 x1_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_16.xyzz * normal_16.yzzx);
  x1_17.x = dot (unity_SHBr, tmpvar_18);
  x1_17.y = dot (unity_SHBg, tmpvar_18);
  x1_17.z = dot (unity_SHBb, tmpvar_18);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_5));
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _texcoord_ST.xy) + _texcoord_ST.zw);
  xlv_TEXCOORD1 = tmpvar_13;
  xlv_TEXCOORD2 = tmpvar_14;
  xlv_TEXCOORD3 = tmpvar_15;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD5 = tmpvar_4;
  xlv_TEXCOORD6 = (x1_17 + (unity_SHC.xyz * (
    (normal_16.x * normal_16.x)
   - 
    (normal_16.y * normal_16.y)
  )));
}


#endif
#ifdef FRAGMENT
#extension GL_EXT_draw_buffers : enable
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 unity_MatrixV;
uniform highp float _ColorBrightness;
uniform highp float _MatcapToggle;
uniform highp vec4 _DarkColor;
uniform highp vec4 _LightColor;
uniform highp float _NormalMapToggle;
uniform highp float _NormaTexlScale;
uniform sampler2D _NormalMap;
uniform highp float _LightingScale;
uniform highp float _WorldNormalScale;
uniform sampler2D _BaseTex;
uniform highp vec4 _BaseTex_ST;
uniform sampler2D _Matcap;
uniform highp float _MatcapSize;
uniform highp float _Matcap_Light;
uniform highp vec4 _DayColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
varying lowp vec4 xlv_COLOR0;
void main ()
{
  highp vec3 worldN_1;
  mediump vec3 tmpvar_2;
  mediump float tmpvar_3;
  mediump float tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  mediump vec3 tmpvar_7;
  mediump vec3 tmpvar_8;
  highp vec4 tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10.x = xlv_TEXCOORD1.w;
  tmpvar_10.y = xlv_TEXCOORD2.w;
  tmpvar_10.z = xlv_TEXCOORD3.w;
  tmpvar_6 = xlv_TEXCOORD1.xyz;
  tmpvar_7 = xlv_TEXCOORD2.xyz;
  tmpvar_8 = xlv_TEXCOORD3.xyz;
  tmpvar_9 = xlv_COLOR0;
  tmpvar_2 = vec3(0.0, 0.0, 0.0);
  tmpvar_5 = 0.0;
  mediump vec3 tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_11 = tmpvar_2;
  tmpvar_12 = tmpvar_5;
  highp vec4 staticSwitch286_13;
  highp vec4 tex2DNode278_14;
  highp vec3 staticSwitch298_15;
  highp vec3 ase_worldNormal_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = normalize((_WorldSpaceLightPos0.xyz - (tmpvar_10 * _WorldSpaceLightPos0.w)));
  mediump vec3 tmpvar_18;
  tmpvar_18.x = tmpvar_6.z;
  tmpvar_18.y = tmpvar_7.z;
  tmpvar_18.z = tmpvar_8.z;
  ase_worldNormal_16 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19 = normalize(ase_worldNormal_16);
  staticSwitch298_15 = vec3(0.0, 0.0, 0.0);
  if ((_NormalMapToggle == 1.0)) {
    lowp vec4 tmpvar_20;
    tmpvar_20 = texture2D (_NormalMap, xlv_TEXCOORD0);
    mediump vec4 packednormal_21;
    packednormal_21 = tmpvar_20;
    mediump float bumpScale_22;
    bumpScale_22 = _NormaTexlScale;
    mediump vec3 normal_23;
    mediump vec3 tmpvar_24;
    tmpvar_24 = ((packednormal_21.xyz * 2.0) - 1.0);
    normal_23.z = tmpvar_24.z;
    normal_23.xy = (tmpvar_24.xy * bumpScale_22);
    mediump vec4 packednormal_25;
    packednormal_25 = tmpvar_20;
    mediump float bumpScale_26;
    bumpScale_26 = _NormaTexlScale;
    mediump vec3 normal_27;
    mediump vec3 tmpvar_28;
    tmpvar_28 = ((packednormal_25.xyz * 2.0) - 1.0);
    normal_27.z = tmpvar_28.z;
    normal_27.xy = (tmpvar_28.xy * bumpScale_26);
    mediump vec4 packednormal_29;
    packednormal_29 = tmpvar_20;
    mediump float bumpScale_30;
    bumpScale_30 = _NormaTexlScale;
    mediump vec3 normal_31;
    mediump vec3 tmpvar_32;
    tmpvar_32 = ((packednormal_29.xyz * 2.0) - 1.0);
    normal_31.z = tmpvar_32.z;
    normal_31.xy = (tmpvar_32.xy * bumpScale_30);
    mediump vec3 tmpvar_33;
    tmpvar_33.x = dot (tmpvar_6, normal_23);
    tmpvar_33.y = dot (tmpvar_7, normal_27);
    tmpvar_33.z = dot (tmpvar_8, normal_31);
    mediump vec3 tmpvar_34;
    tmpvar_34 = normalize(tmpvar_33);
    staticSwitch298_15 = tmpvar_34;
  } else {
    staticSwitch298_15 = tmpvar_19;
  };
  highp vec3 tmpvar_35;
  tmpvar_35 = ((staticSwitch298_15 + _LightingScale) * _WorldNormalScale);
  highp vec2 tmpvar_36;
  tmpvar_36 = ((xlv_TEXCOORD0 * _BaseTex_ST.xy) + _BaseTex_ST.zw);
  lowp vec4 tmpvar_37;
  tmpvar_37 = texture2D (_BaseTex, tmpvar_36);
  tex2DNode278_14 = tmpvar_37;
  highp vec4 tmpvar_38;
  tmpvar_38 = (mix (_DarkColor, _LightColor, vec4(clamp (
    dot (tmpvar_17, tmpvar_35)
  , 0.0, 1.0))) * tex2DNode278_14);
  highp vec3 tmpvar_39;
  highp mat3 tmpvar_40;
  tmpvar_40[0] = unity_MatrixV[0].xyz;
  tmpvar_40[1] = unity_MatrixV[1].xyz;
  tmpvar_40[2] = unity_MatrixV[2].xyz;
  tmpvar_39 = (tmpvar_40 * tmpvar_35);
  staticSwitch286_13 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((_MatcapToggle == 1.0)) {
    lowp vec4 tmpvar_41;
    highp vec2 P_42;
    P_42 = (((tmpvar_39.xy * _MatcapSize) + vec2(1.0, 1.0)) * vec2(0.5, 0.5));
    tmpvar_41 = texture2D (_Matcap, P_42);
    staticSwitch286_13 = (tmpvar_38 + (tmpvar_41 * _Matcap_Light));
  } else {
    staticSwitch286_13 = tmpvar_38;
  };
  tmpvar_11 = ((_ColorBrightness * staticSwitch286_13) * (tmpvar_9 * _DayColor)).xyz;
  highp float tmpvar_43;
  tmpvar_43 = clamp (((_DayColor.w * tmpvar_9.w) * tex2DNode278_14.w), 0.0, 1.0);
  tmpvar_12 = tmpvar_43;
  tmpvar_2 = tmpvar_11;
  tmpvar_5 = tmpvar_12;
  worldN_1.x = xlv_TEXCOORD1.z;
  worldN_1.y = xlv_TEXCOORD2.z;
  worldN_1.z = xlv_TEXCOORD3.z;
  highp vec3 tmpvar_44;
  tmpvar_44 = normalize(worldN_1);
  worldN_1 = tmpvar_44;
  mediump vec4 outGBuffer2_45;
  mediump vec4 tmpvar_46;
  tmpvar_46.xyz = vec3(0.0, 0.0, 0.0);
  tmpvar_46.w = 1.0;
  mediump vec4 tmpvar_47;
  tmpvar_47.xyz = (vec3(0.2209163, 0.2209163, 0.2209163) * (vec3(1.0, 1.0, 1.0) - vec3(tmpvar_3)));
  tmpvar_47.w = tmpvar_4;
  highp vec4 tmpvar_48;
  tmpvar_48.w = 1.0;
  tmpvar_48.xyz = ((tmpvar_44 * 0.5) + 0.5);
  outGBuffer2_45 = tmpvar_48;
  mediump vec4 tmpvar_49;
  tmpvar_49.w = 1.0;
  tmpvar_49.xyz = tmpvar_11;
  gl_FragData[0] = tmpvar_46;
  gl_FragData[1] = tmpvar_47;
  gl_FragData[2] = outGBuffer2_45;
  gl_FragData[3] = tmpvar_49;
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
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" }
""
}
SubProgram "gles hw_tier00 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier01 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
SubProgram "gles hw_tier02 " {
Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
""
}
}
}
}
CustomEditor "MiHoYoASEMaterialInspector"
}