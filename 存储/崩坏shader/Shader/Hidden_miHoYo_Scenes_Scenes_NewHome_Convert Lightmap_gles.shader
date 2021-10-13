//////////////////////////////////////////
//
// NOTE: This is *not* a valid shader file
//
///////////////////////////////////////////
Shader "Hidden/miHoYo_Scenes/Scenes_NewHome/Convert Lightmap" {
Properties {
_MainTex ("Texture", 2D) = "white" { }
}
SubShader {
 LOD 200
 Pass {
  LOD 200
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 22447
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
uniform highp vec4 _LightmapOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _LightmapOffsetScale.xy) + _LightmapOffsetScale.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 decodedLightmap_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (unity_Lightmap_HDR.x * tmpvar_2.xyz);
  decodedLightmap_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = decodedLightmap_1.xxxx;
  gl_FragData[0] = tmpvar_4;
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
uniform highp vec4 _LightmapOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _LightmapOffsetScale.xy) + _LightmapOffsetScale.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 decodedLightmap_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (unity_Lightmap_HDR.x * tmpvar_2.xyz);
  decodedLightmap_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = decodedLightmap_1.xxxx;
  gl_FragData[0] = tmpvar_4;
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
uniform highp vec4 _LightmapOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _LightmapOffsetScale.xy) + _LightmapOffsetScale.zw);
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform mediump vec4 unity_Lightmap_HDR;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec3 decodedLightmap_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_3;
  tmpvar_3 = (unity_Lightmap_HDR.x * tmpvar_2.xyz);
  decodedLightmap_1 = tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = decodedLightmap_1.xxxx;
  gl_FragData[0] = tmpvar_4;
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
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 126099
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec2 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * _MainTex_TexelSize.x);
  tmpvar_2.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_4;
  tmpvar_4 = (2.0 * _MainTex_TexelSize.y);
  tmpvar_2.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  col_1 = (tmpvar_5 * 0.003765);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.y - _MainTex_TexelSize.y);
  tmpvar_6.y = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_6);
  col_1 = (col_1 + (tmpvar_8 * 0.015019));
  highp vec2 tmpvar_9;
  tmpvar_9.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  tmpvar_9.y = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_9);
  col_1 = (col_1 + (tmpvar_11 * 0.023792));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.y + _MainTex_TexelSize.y);
  tmpvar_12.y = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_12);
  col_1 = (col_1 + (tmpvar_14 * 0.015019));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_TEXCOORD0.x - tmpvar_3);
  tmpvar_15.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  col_1 = (col_1 + (tmpvar_16 * 0.003765));
  highp vec2 tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (xlv_TEXCOORD0.x - _MainTex_TexelSize.x);
  tmpvar_17.x = tmpvar_18;
  tmpvar_17.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_17);
  col_1 = (col_1 + (tmpvar_19 * 0.015019));
  highp vec2 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  col_1 = (col_1 + (tmpvar_21 * 0.059912));
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_18;
  tmpvar_22.y = tmpvar_10;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_22);
  col_1 = (col_1 + (tmpvar_23 * 0.094907));
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_18;
  tmpvar_24.y = tmpvar_13;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_24);
  col_1 = (col_1 + (tmpvar_25 * 0.059912));
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_18;
  tmpvar_26.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_26);
  col_1 = (col_1 + (tmpvar_27 * 0.015019));
  highp vec2 tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = xlv_TEXCOORD0.x;
  tmpvar_28.x = tmpvar_29;
  tmpvar_28.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, tmpvar_28);
  col_1 = (col_1 + (tmpvar_30 * 0.023792));
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_29;
  tmpvar_31.y = tmpvar_7;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, tmpvar_31);
  col_1 = (col_1 + (tmpvar_32 * 0.094907));
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_29;
  tmpvar_33.y = tmpvar_10;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_MainTex, tmpvar_33);
  col_1 = (col_1 + (tmpvar_34 * 0.150342));
  highp vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_29;
  tmpvar_35.y = tmpvar_13;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, tmpvar_35);
  col_1 = (col_1 + (tmpvar_36 * 0.094907));
  highp vec2 tmpvar_37;
  tmpvar_37.x = tmpvar_29;
  tmpvar_37.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, tmpvar_37);
  col_1 = (col_1 + (tmpvar_38 * 0.023792));
  highp vec2 tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (xlv_TEXCOORD0.x + _MainTex_TexelSize.x);
  tmpvar_39.x = tmpvar_40;
  tmpvar_39.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_MainTex, tmpvar_39);
  col_1 = (col_1 + (tmpvar_41 * 0.015019));
  highp vec2 tmpvar_42;
  tmpvar_42.x = tmpvar_40;
  tmpvar_42.y = tmpvar_7;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, tmpvar_42);
  col_1 = (col_1 + (tmpvar_43 * 0.059912));
  highp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_40;
  tmpvar_44.y = tmpvar_10;
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_MainTex, tmpvar_44);
  col_1 = (col_1 + (tmpvar_45 * 0.094907));
  highp vec2 tmpvar_46;
  tmpvar_46 = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, tmpvar_46);
  col_1 = (col_1 + (tmpvar_47 * 0.059912));
  highp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_40;
  tmpvar_48.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_MainTex, tmpvar_48);
  col_1 = (col_1 + (tmpvar_49 * 0.015019));
  highp vec2 tmpvar_50;
  tmpvar_50.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_50.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, tmpvar_50);
  col_1 = (col_1 + (tmpvar_51 * 0.003765));
  highp vec2 tmpvar_52;
  tmpvar_52.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_52.y = tmpvar_7;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_MainTex, tmpvar_52);
  col_1 = (col_1 + (tmpvar_53 * 0.015019));
  highp vec2 tmpvar_54;
  tmpvar_54.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_54.y = tmpvar_10;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, tmpvar_54);
  col_1 = (col_1 + (tmpvar_55 * 0.023792));
  highp vec2 tmpvar_56;
  tmpvar_56.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_56.y = tmpvar_13;
  lowp vec4 tmpvar_57;
  tmpvar_57 = texture2D (_MainTex, tmpvar_56);
  col_1 = (col_1 + (tmpvar_57 * 0.015019));
  highp vec2 tmpvar_58;
  tmpvar_58.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_58.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, tmpvar_58);
  col_1 = (col_1 + (tmpvar_59 * 0.003765));
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec2 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * _MainTex_TexelSize.x);
  tmpvar_2.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_4;
  tmpvar_4 = (2.0 * _MainTex_TexelSize.y);
  tmpvar_2.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  col_1 = (tmpvar_5 * 0.003765);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.y - _MainTex_TexelSize.y);
  tmpvar_6.y = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_6);
  col_1 = (col_1 + (tmpvar_8 * 0.015019));
  highp vec2 tmpvar_9;
  tmpvar_9.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  tmpvar_9.y = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_9);
  col_1 = (col_1 + (tmpvar_11 * 0.023792));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.y + _MainTex_TexelSize.y);
  tmpvar_12.y = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_12);
  col_1 = (col_1 + (tmpvar_14 * 0.015019));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_TEXCOORD0.x - tmpvar_3);
  tmpvar_15.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  col_1 = (col_1 + (tmpvar_16 * 0.003765));
  highp vec2 tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (xlv_TEXCOORD0.x - _MainTex_TexelSize.x);
  tmpvar_17.x = tmpvar_18;
  tmpvar_17.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_17);
  col_1 = (col_1 + (tmpvar_19 * 0.015019));
  highp vec2 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  col_1 = (col_1 + (tmpvar_21 * 0.059912));
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_18;
  tmpvar_22.y = tmpvar_10;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_22);
  col_1 = (col_1 + (tmpvar_23 * 0.094907));
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_18;
  tmpvar_24.y = tmpvar_13;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_24);
  col_1 = (col_1 + (tmpvar_25 * 0.059912));
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_18;
  tmpvar_26.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_26);
  col_1 = (col_1 + (tmpvar_27 * 0.015019));
  highp vec2 tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = xlv_TEXCOORD0.x;
  tmpvar_28.x = tmpvar_29;
  tmpvar_28.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, tmpvar_28);
  col_1 = (col_1 + (tmpvar_30 * 0.023792));
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_29;
  tmpvar_31.y = tmpvar_7;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, tmpvar_31);
  col_1 = (col_1 + (tmpvar_32 * 0.094907));
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_29;
  tmpvar_33.y = tmpvar_10;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_MainTex, tmpvar_33);
  col_1 = (col_1 + (tmpvar_34 * 0.150342));
  highp vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_29;
  tmpvar_35.y = tmpvar_13;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, tmpvar_35);
  col_1 = (col_1 + (tmpvar_36 * 0.094907));
  highp vec2 tmpvar_37;
  tmpvar_37.x = tmpvar_29;
  tmpvar_37.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, tmpvar_37);
  col_1 = (col_1 + (tmpvar_38 * 0.023792));
  highp vec2 tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (xlv_TEXCOORD0.x + _MainTex_TexelSize.x);
  tmpvar_39.x = tmpvar_40;
  tmpvar_39.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_MainTex, tmpvar_39);
  col_1 = (col_1 + (tmpvar_41 * 0.015019));
  highp vec2 tmpvar_42;
  tmpvar_42.x = tmpvar_40;
  tmpvar_42.y = tmpvar_7;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, tmpvar_42);
  col_1 = (col_1 + (tmpvar_43 * 0.059912));
  highp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_40;
  tmpvar_44.y = tmpvar_10;
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_MainTex, tmpvar_44);
  col_1 = (col_1 + (tmpvar_45 * 0.094907));
  highp vec2 tmpvar_46;
  tmpvar_46 = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, tmpvar_46);
  col_1 = (col_1 + (tmpvar_47 * 0.059912));
  highp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_40;
  tmpvar_48.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_MainTex, tmpvar_48);
  col_1 = (col_1 + (tmpvar_49 * 0.015019));
  highp vec2 tmpvar_50;
  tmpvar_50.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_50.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, tmpvar_50);
  col_1 = (col_1 + (tmpvar_51 * 0.003765));
  highp vec2 tmpvar_52;
  tmpvar_52.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_52.y = tmpvar_7;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_MainTex, tmpvar_52);
  col_1 = (col_1 + (tmpvar_53 * 0.015019));
  highp vec2 tmpvar_54;
  tmpvar_54.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_54.y = tmpvar_10;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, tmpvar_54);
  col_1 = (col_1 + (tmpvar_55 * 0.023792));
  highp vec2 tmpvar_56;
  tmpvar_56.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_56.y = tmpvar_13;
  lowp vec4 tmpvar_57;
  tmpvar_57 = texture2D (_MainTex, tmpvar_56);
  col_1 = (col_1 + (tmpvar_57 * 0.015019));
  highp vec2 tmpvar_58;
  tmpvar_58.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_58.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, tmpvar_58);
  col_1 = (col_1 + (tmpvar_59 * 0.003765));
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec2 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (2.0 * _MainTex_TexelSize.x);
  tmpvar_2.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_4;
  tmpvar_4 = (2.0 * _MainTex_TexelSize.y);
  tmpvar_2.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, tmpvar_2);
  col_1 = (tmpvar_5 * 0.003765);
  highp vec2 tmpvar_6;
  tmpvar_6.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_7;
  tmpvar_7 = (xlv_TEXCOORD0.y - _MainTex_TexelSize.y);
  tmpvar_6.y = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_6);
  col_1 = (col_1 + (tmpvar_8 * 0.015019));
  highp vec2 tmpvar_9;
  tmpvar_9.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_10;
  tmpvar_10 = xlv_TEXCOORD0.y;
  tmpvar_9.y = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, tmpvar_9);
  col_1 = (col_1 + (tmpvar_11 * 0.023792));
  highp vec2 tmpvar_12;
  tmpvar_12.x = (xlv_TEXCOORD0.x - tmpvar_3);
  highp float tmpvar_13;
  tmpvar_13 = (xlv_TEXCOORD0.y + _MainTex_TexelSize.y);
  tmpvar_12.y = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_12);
  col_1 = (col_1 + (tmpvar_14 * 0.015019));
  highp vec2 tmpvar_15;
  tmpvar_15.x = (xlv_TEXCOORD0.x - tmpvar_3);
  tmpvar_15.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_16;
  tmpvar_16 = texture2D (_MainTex, tmpvar_15);
  col_1 = (col_1 + (tmpvar_16 * 0.003765));
  highp vec2 tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = (xlv_TEXCOORD0.x - _MainTex_TexelSize.x);
  tmpvar_17.x = tmpvar_18;
  tmpvar_17.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_19;
  tmpvar_19 = texture2D (_MainTex, tmpvar_17);
  col_1 = (col_1 + (tmpvar_19 * 0.015019));
  highp vec2 tmpvar_20;
  tmpvar_20 = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_21;
  tmpvar_21 = texture2D (_MainTex, tmpvar_20);
  col_1 = (col_1 + (tmpvar_21 * 0.059912));
  highp vec2 tmpvar_22;
  tmpvar_22.x = tmpvar_18;
  tmpvar_22.y = tmpvar_10;
  lowp vec4 tmpvar_23;
  tmpvar_23 = texture2D (_MainTex, tmpvar_22);
  col_1 = (col_1 + (tmpvar_23 * 0.094907));
  highp vec2 tmpvar_24;
  tmpvar_24.x = tmpvar_18;
  tmpvar_24.y = tmpvar_13;
  lowp vec4 tmpvar_25;
  tmpvar_25 = texture2D (_MainTex, tmpvar_24);
  col_1 = (col_1 + (tmpvar_25 * 0.059912));
  highp vec2 tmpvar_26;
  tmpvar_26.x = tmpvar_18;
  tmpvar_26.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_27;
  tmpvar_27 = texture2D (_MainTex, tmpvar_26);
  col_1 = (col_1 + (tmpvar_27 * 0.015019));
  highp vec2 tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = xlv_TEXCOORD0.x;
  tmpvar_28.x = tmpvar_29;
  tmpvar_28.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_30;
  tmpvar_30 = texture2D (_MainTex, tmpvar_28);
  col_1 = (col_1 + (tmpvar_30 * 0.023792));
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_29;
  tmpvar_31.y = tmpvar_7;
  lowp vec4 tmpvar_32;
  tmpvar_32 = texture2D (_MainTex, tmpvar_31);
  col_1 = (col_1 + (tmpvar_32 * 0.094907));
  highp vec2 tmpvar_33;
  tmpvar_33.x = tmpvar_29;
  tmpvar_33.y = tmpvar_10;
  lowp vec4 tmpvar_34;
  tmpvar_34 = texture2D (_MainTex, tmpvar_33);
  col_1 = (col_1 + (tmpvar_34 * 0.150342));
  highp vec2 tmpvar_35;
  tmpvar_35.x = tmpvar_29;
  tmpvar_35.y = tmpvar_13;
  lowp vec4 tmpvar_36;
  tmpvar_36 = texture2D (_MainTex, tmpvar_35);
  col_1 = (col_1 + (tmpvar_36 * 0.094907));
  highp vec2 tmpvar_37;
  tmpvar_37.x = tmpvar_29;
  tmpvar_37.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_38;
  tmpvar_38 = texture2D (_MainTex, tmpvar_37);
  col_1 = (col_1 + (tmpvar_38 * 0.023792));
  highp vec2 tmpvar_39;
  highp float tmpvar_40;
  tmpvar_40 = (xlv_TEXCOORD0.x + _MainTex_TexelSize.x);
  tmpvar_39.x = tmpvar_40;
  tmpvar_39.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_41;
  tmpvar_41 = texture2D (_MainTex, tmpvar_39);
  col_1 = (col_1 + (tmpvar_41 * 0.015019));
  highp vec2 tmpvar_42;
  tmpvar_42.x = tmpvar_40;
  tmpvar_42.y = tmpvar_7;
  lowp vec4 tmpvar_43;
  tmpvar_43 = texture2D (_MainTex, tmpvar_42);
  col_1 = (col_1 + (tmpvar_43 * 0.059912));
  highp vec2 tmpvar_44;
  tmpvar_44.x = tmpvar_40;
  tmpvar_44.y = tmpvar_10;
  lowp vec4 tmpvar_45;
  tmpvar_45 = texture2D (_MainTex, tmpvar_44);
  col_1 = (col_1 + (tmpvar_45 * 0.094907));
  highp vec2 tmpvar_46;
  tmpvar_46 = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_47;
  tmpvar_47 = texture2D (_MainTex, tmpvar_46);
  col_1 = (col_1 + (tmpvar_47 * 0.059912));
  highp vec2 tmpvar_48;
  tmpvar_48.x = tmpvar_40;
  tmpvar_48.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_49;
  tmpvar_49 = texture2D (_MainTex, tmpvar_48);
  col_1 = (col_1 + (tmpvar_49 * 0.015019));
  highp vec2 tmpvar_50;
  tmpvar_50.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_50.y = (xlv_TEXCOORD0.y - tmpvar_4);
  lowp vec4 tmpvar_51;
  tmpvar_51 = texture2D (_MainTex, tmpvar_50);
  col_1 = (col_1 + (tmpvar_51 * 0.003765));
  highp vec2 tmpvar_52;
  tmpvar_52.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_52.y = tmpvar_7;
  lowp vec4 tmpvar_53;
  tmpvar_53 = texture2D (_MainTex, tmpvar_52);
  col_1 = (col_1 + (tmpvar_53 * 0.015019));
  highp vec2 tmpvar_54;
  tmpvar_54.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_54.y = tmpvar_10;
  lowp vec4 tmpvar_55;
  tmpvar_55 = texture2D (_MainTex, tmpvar_54);
  col_1 = (col_1 + (tmpvar_55 * 0.023792));
  highp vec2 tmpvar_56;
  tmpvar_56.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_56.y = tmpvar_13;
  lowp vec4 tmpvar_57;
  tmpvar_57 = texture2D (_MainTex, tmpvar_56);
  col_1 = (col_1 + (tmpvar_57 * 0.015019));
  highp vec2 tmpvar_58;
  tmpvar_58.x = (xlv_TEXCOORD0.x + tmpvar_3);
  tmpvar_58.y = (xlv_TEXCOORD0.y + tmpvar_4);
  lowp vec4 tmpvar_59;
  tmpvar_59 = texture2D (_MainTex, tmpvar_58);
  col_1 = (col_1 + (tmpvar_59 * 0.003765));
  gl_FragData[0] = col_1;
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
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 171451
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _EdgeMinColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = clamp ((1.0 - _EdgeMinColor), 0.0, 1.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + tmpvar_2);
  col_1 = tmpvar_3;
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _EdgeMinColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = clamp ((1.0 - _EdgeMinColor), 0.0, 1.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + tmpvar_2);
  col_1 = tmpvar_3;
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _EdgeMinColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = clamp ((1.0 - _EdgeMinColor), 0.0, 1.0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = (texture2D (_MainTex, xlv_TEXCOORD0) + tmpvar_2);
  col_1 = tmpvar_3;
  gl_FragData[0] = col_1;
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
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 256047
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
uniform sampler2D _DitherTex;
uniform highp vec4 _DitherTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (floor((xlv_TEXCOORD0 * _MainTex_TexelSize.zw)) * _DitherTex_TexelSize.xy);
  tmpvar_3 = texture2D (_DitherTex, P_4);
  col_1 = (col_1 + ((tmpvar_3.w / 32.0) - 0.0078125));
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
uniform sampler2D _DitherTex;
uniform highp vec4 _DitherTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (floor((xlv_TEXCOORD0 * _MainTex_TexelSize.zw)) * _DitherTex_TexelSize.xy);
  tmpvar_3 = texture2D (_DitherTex, P_4);
  col_1 = (col_1 + ((tmpvar_3.w / 32.0) - 0.0078125));
  gl_FragData[0] = col_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
uniform sampler2D _DitherTex;
uniform highp vec4 _DitherTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  highp vec2 P_4;
  P_4 = (floor((xlv_TEXCOORD0 * _MainTex_TexelSize.zw)) * _DitherTex_TexelSize.xy);
  tmpvar_3 = texture2D (_DitherTex, P_4);
  col_1 = (col_1 + ((tmpvar_3.w / 32.0) - 0.0078125));
  gl_FragData[0] = col_1;
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
  ZTest Always
  ZWrite Off
  Cull Off
  GpuProgramID 301231
Program "vp" {
SubProgram "gles hw_tier00 " {
"#version 100

#ifdef VERTEX
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 unity_ObjectToWorld;
uniform highp mat4 unity_MatrixVP;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AOTexPack;
uniform highp vec4 _PackMask;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 ao_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTexPack, xlv_TEXCOORD0);
  ao_1 = tmpvar_4;
  col_2 = ((col_2 * (1.0 - _PackMask)) + (ao_1 * _PackMask));
  gl_FragData[0] = col_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AOTexPack;
uniform highp vec4 _PackMask;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 ao_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTexPack, xlv_TEXCOORD0);
  ao_1 = tmpvar_4;
  col_2 = ((col_2 * (1.0 - _PackMask)) + (ao_1 * _PackMask));
  gl_FragData[0] = col_2;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.w = 1.0;
  tmpvar_1.xyz = _glesVertex.xyz;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  gl_Position = (unity_MatrixVP * (unity_ObjectToWorld * tmpvar_1));
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
uniform sampler2D _AOTexPack;
uniform highp vec4 _PackMask;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 ao_1;
  highp vec4 col_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_AOTexPack, xlv_TEXCOORD0);
  ao_1 = tmpvar_4;
  col_2 = ((col_2 * (1.0 - _PackMask)) + (ao_1 * _PackMask));
  gl_FragData[0] = col_2;
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
}